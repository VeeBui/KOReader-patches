--[[
===================================================================================================
KOREADER CUSTOM HEADER & TRIPLE PROGRESS BARS
===================================================================================================

This patch adds:
1. A customizable header with book/chapter/part information, time, and battery
2. Three RGB-colored progress bars (for Book, Part, and Chapter progress)

REQUIREMENTS:
- Only works on reflowable documents (EPUB, MOBI, etc.) - not PDFs or fixed-layout files
- You need to set a top margin in your book so the header doesn't cover text
- Works best with books that have a proper Table of Contents

CREDITS:
- Original header: https://github.com/joshuacant/KOReader.patches
- Original double progress bar: https://github.com/gilgulgamesh/koreader-patches
- RGB color support: https://gist.github.com/IntrovertedMage/d759ff214f799cfb5e1f8c85daab6cae
- Session duration: https://github.com/koreader/koreader/issues/10231#issuecomment-1477138340
===================================================================================================
]]--

-- Required libraries
local Blitbuffer = require("ffi/blitbuffer")
local TextWidget = require("ui/widget/textwidget")
local CenterContainer = require("ui/widget/container/centercontainer")
local VerticalGroup = require("ui/widget/verticalgroup")
local VerticalSpan = require("ui/widget/verticalspan")
local HorizontalGroup = require("ui/widget/horizontalgroup")
local HorizontalSpan = require("ui/widget/horizontalspan")
local BD = require("ui/bidi")
local Size = require("ui/size")
local Geom = require("ui/geometry")
local Device = require("device")
local Font = require("ui/font")
local logger = require("logger")
local util = require("util")
local datetime = require("datetime")
local Screen = Device.screen
local _ = require("gettext")
local T = require("ffi/util").template
local ReaderView = require("apps/reader/modules/readerview")
local _ReaderView_paintTo_orig = ReaderView.paintTo
local header_settings = G_reader_settings:readSetting("footer")
local screen_width = Screen:getWidth()
local screen_height = Screen:getHeight()
local ProgressWidget = require("ui/widget/progresswidget")
local UIManager = require("ui/uimanager")
local Math = require("optmath")
local ReaderFooter = require("apps/reader/modules/readerfooter")
local SESSION_DURATION = 1  -- Define this constant

-- Constants
local INITIAL_MARKER_HEIGHT_THRESHOLD = Screen:scaleBySize(12)
local CHAPTER = 1
local PART = 2
local BOOK = 3
local ON = true
local OFF = false

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMIZE YOUR DISPLAY
---------------------------------------------------------------------------------------------------

-----------------------------------------------------
-- PROGRESS BAR SETTINGS
-----------------------------------------------------
-- Which progress type for each bar? (CHAPTER, PART, or BOOK)
local top_bar_type = BOOK      -- Top bar shows: Book progress
local mid_bar_type = PART      -- Middle bar shows: Part progress
local bot_bar_type = CHAPTER   -- Bottom bar shows: Chapter progress

-- Bar positioning and appearance
local stacked = ON  -- Stack all bars at bottom? (ON = bottom stack, OFF = hide top and middle)
local margin_l = 75  -- Left margin for progress bars
local margin_r = 450  -- Right margin for progress bars
local gap = 16  -- Space between stacked bars
local radius = 2  -- Corner roundness (0 = sharp corners)
local prog_bar_thickness = 20  -- Height of each bar
local bottom_padding = 9  -- Space between bottom bar and screen edge
local top_padding = -1  -- For unstacked bars: position of top bar (negative = tucked to edge)

-- Progress bar colors (RGB support!)
local top_bar_seen_color = Blitbuffer.colorFromString("#9500FF")  -- Purple for read portion
local mid_bar_seen_color = Blitbuffer.colorFromString("#20BF55")  -- Green for read portion
local bot_bar_seen_color = Blitbuffer.colorFromString("#01BAEF")  -- Blue for read portion
local bar_unread_color = Blitbuffer.COLOR_GRAY_D  -- Gray for unread portion

--[[
COLOR OPTIONS - Choose from any of these formats:
1. Hex colors: Blitbuffer.colorFromString("#9500FF")
2. Named colors: Blitbuffer.colorFromName("purple") -- red, orange, yellow, green, olive, cyan, blue, purple
3. Grayscale shades:
   - Blitbuffer.COLOR_WHITE (lightest)
   - Blitbuffer.COLOR_GRAY_E, COLOR_GRAY_D, COLOR_LIGHT_GRAY
   - Blitbuffer.COLOR_GRAY_B, COLOR_GRAY, COLOR_GRAY_9
   - Blitbuffer.COLOR_DARK_GRAY, COLOR_GRAY_7, COLOR_GRAY_6
   - Blitbuffer.COLOR_GRAY_5, COLOR_GRAY_4, COLOR_GRAY_3
   - Blitbuffer.COLOR_GRAY_2, COLOR_GRAY_1
   - Blitbuffer.COLOR_BLACK (darkest)
]]--

-----------------------------------------------------
-- HEADER SETTINGS
-----------------------------------------------------
local header_font_face = "ffont"  -- Font for header text ("ffont" is KOReader's default)
local header_font_size = header_settings.text_font_size or 14  -- Size of header text
local header_font_bold = header_settings.text_font_bold or false  -- Bold header text?
local header_font_color = Blitbuffer.COLOR_BLACK  -- Color of header text
local header_top_padding = Size.padding.small  -- Space above header (small/default/large)
local header_use_book_margins = true  -- Use book's left/right margins for header?
local header_margin = Size.padding.large  -- Manual margin if book margins disabled
local left_max_width_pct = 65  -- Max % of width for left header content
local right_max_width_pct = 30  -- Max % of width for right header content

---------------------------------------------------------------------------------------------------
-- 🎨 HEADER CONTENT CUSTOMIZATION - WHAT TO DISPLAY
---------------------------------------------------------------------------------------------------
--[[
Available variables you can use in your header strings:

BOOK INFO:
- book.author                   -- Author name
- all chapter info              -- Everything available in chapter is also available for book
                                -- Replace "chapter" with "book"
                                -- e.g. book.pages.total.stable

PART INFO (only if book has parts):
- part.exists                   -- Boolean: does book have parts?
- all chapter info              -- Everything available in chapter is also available for part
                                -- Replace "chapter" with "part"
                                -- e.g. part.pages.current.screen

CHAPTER INFO (TOC entries with maximum depth):
- chapter.title                 -- Current chapter title
- chapter.pages.current         -- Current page in chapter
                    .stable         -- stable is the stable or "physical page" equivalent
                    .screen         -- screen refers to the screen of text
- chapter.pages.total           -- Total pages in chapter
                    .stable
                    .screen
- chapter.pages.remaining       -- Pages left in chapter
                    .stable
                    .screen
- chapter.reading.percentage    -- Chapter progress as percentage (0-100) (calculated from screen)
- chapter.reading.progress      -- Format: "current / total" (calculated from stable)
- chapter.reading.time          -- Estimated time remaining in chapter (calculated from screen)


SYSTEM INFO:
- time                          -- Current clock time
- battery                       -- Battery level with icon

STRING FORMATTING:
Use string.format() for custom layouts:
  %s = string, %d = number, %.0f = rounded number, %.2f = 2 decimal places
  Example: string.format("Page %d of %d", book.pages.current.stable, book.pages.total.stable)
]]--

-- This function is called to generate the header content
-- Modify the return strings to customize what appears in your header
local function generateHeaderContent(book, part, chapter, time, battery, session_duration)
    -- HEADER
    -- LINE 1: Main header line
    local left_line1 = string.format("₍^..^₎⟆  %s: %s", 
                                     book.title, book.author)
    local right_line1 = string.format("˗ˏˋ❁ˎˊ˗ • %s • %s", 
                                      time, battery)

    -- LINE 2: Secondary header line  
    local left_line2 = string.format("  ✮⋆˙⊹ ♡࣪ ˖.   ★ %s             ➤ %s", 
                                     part.title, chapter.title)
    local right_line2 = string.format("Session: %s",
                                    session_duration)

    return left_line1, right_line1, left_line2, right_line2
end
-- Modify the return strings to customize what appears in your footer
local function generateFooterContent(book, part, chapter, time, battery, session_duration)
    -- FOOTER
    -- stats format
    local stats_format = "%d/[%d] = %.0f%% | ⤻%d ⌛%s"
    -- LINE 3: 1st footer line  
    local left_line3 = string.format("■")
    local right_line3 = string.format(stats_format,
                                    book.pages.current.stable,
                                    book.pages.total.stable,
                                    book.reading.percentage,
                                    book.pages.remaining.stable,
                                    book.reading.time)
    -- LINE 4: 2nd footer line  
    local left_line4 = string.format("★")
    local right_line4 = string.format(stats_format,
                                    part.pages.current.stable,
                                    part.pages.total.stable,
                                    part.reading.percentage,
                                    part.pages.remaining.stable,
                                    part.reading.time)
    -- LINE 5: 3rd footer line  
    local left_line5 = string.format("➤")
    local right_line5 = string.format(stats_format,
                                    chapter.pages.current.stable,
                                    chapter.pages.total.stable,
                                    chapter.reading.percentage,
                                    chapter.pages.remaining.stable,
                                    chapter.reading.time)
    
    return left_line3, right_line3, left_line4, right_line4, left_line5, right_line5
end

---------------------------------------------------------------------------------------------------
-- 🔧 INTERNAL CODE - YOU DON'T NEED TO EDIT BELOW THIS LINE
---------------------------------------------------------------------------------------------------

-----------------------------------------------------
-- Custom RGB Progress Bar Painter
-----------------------------------------------------
local function paintProgressBarRGB(self, bb, x, y)
    local my_size = self:getSize()
    if not self.dimen then
        self.dimen = Geom:new{x = x, y = y, w = my_size.w, h = my_size.h}
    else
        self.dimen.x = x
        self.dimen.y = y
    end
    if self.dimen.w == 0 or self.dimen.h == 0 then return end

    local _mirroredUI = BD.mirroredUILayout()
    local fill_width = my_size.w - 2*(self.margin_h + self.bordersize)
    local fill_y = y + self.margin_v + self.bordersize
    local fill_height = my_size.h - 2*(self.margin_v + self.bordersize)

    -- Draw background
    if self.radius == 0 then
        -- Simple rectangle without rounded borders
        bb:paintRect(x, y, my_size.w, my_size.h, self.bordercolor)
        bb:paintRect(x + self.margin_h + self.bordersize, fill_y,
                     math.ceil(fill_width), math.ceil(fill_height), self.bordercolor)
    else
        -- Rounded borders
        bb:paintRoundedRect(x, y, my_size.w, my_size.h, self.bordercolor, self.radius)
        bb:paintBorder(math.floor(x), math.floor(y), my_size.w, my_size.h,
                       self.bordersize, self.bordercolor, self.radius)
    end

    -- Draw alternate pages fill bars (for non-linear flows)
    if self.alt and self.alt[1] ~= nil then
        for i=1, #self.alt do
            local tick_x = fill_width * ((self.alt[i][1] - 1) / self.last)
            local width = fill_width * (self.alt[i][2] / self.last)
            if _mirroredUI then
                tick_x = fill_width - tick_x - width
            end
            tick_x = math.floor(tick_x)
            width = math.ceil(width)

            bb:paintRectRGB32(x + self.margin_h + self.bordersize + tick_x,
                         fill_y, width, math.ceil(fill_height), self.altcolor)
        end
    end

    -- Draw main fill bar
    if self.percentage >= 0 and self.percentage <= 1 then
        local fill_x = x + self.margin_h + self.bordersize
        if self.fill_from_right or (_mirroredUI and not self.fill_from_right) then
            fill_x = fill_x + (fill_width * (1 - self.percentage))
            fill_x = math.floor(fill_x)
        end

        bb:paintRectRGB32(fill_x, fill_y,
                     math.ceil(fill_width * self.percentage),
                     math.ceil(fill_height), self.fillcolor)

        -- Draw initial position marker overlay
        if self.initial_pos_marker and self.initial_percentage >= 0 then
            if self.height <= INITIAL_MARKER_HEIGHT_THRESHOLD then
                self.initial_pos_icon:paintTo(bb, 
                    Math.round(fill_x + math.ceil(fill_width * self.initial_percentage) - self.height / 4), 
                    y - Math.round(self.height / 6))
            else
                self.initial_pos_icon:paintTo(bb, 
                    Math.round(fill_x + math.ceil(fill_width * self.initial_percentage) - self.height / 2), 
                    y)
            end
        end
    end

    -- Draw ticks if present
    if self.ticks and self.last and self.last > 0 then
        for i, tick in ipairs(self.ticks) do
            local tick_x = fill_width * (tick / self.last)
            if _mirroredUI then tick_x = fill_width - tick_x end
            tick_x = math.floor(tick_x)
            bb:paintRect(x + self.margin_h + self.bordersize + tick_x, fill_y,
                         self.tick_width, math.ceil(fill_height), self.bordercolor)
        end
    end
end

-----------------------------------------------------
-- Page Number Conversion Functions
-----------------------------------------------------
local function buildPageCaches(ui)
    local stable_to_screen = {}
    local screen_to_stable = {}
    
    if ui.pagemap and ui.pagemap.page_labels_cache then
        for _, page_data in pairs(ui.pagemap.page_labels_cache) do
            if type(page_data) == "table" and #page_data >= 2 then
                local stable_page = page_data[1]
                local screen_page = page_data[2]
                stable_to_screen[stable_page] = screen_page
                screen_to_stable[screen_page] = stable_page
            end
        end
    end
    
    return stable_to_screen, screen_to_stable
end

local function screenToStablePage(screen_page, cache)
    local stable = cache[screen_page]
    while stable == nil and screen_page > 0 do
        screen_page = screen_page - 1
        stable = cache[screen_page]
    end
    return stable
end

-----------------------------------------------------
-- Function to get session duration
local function getSessionDuration(ui)
    if not ui.statistics then
        return "n/a"
    end
    local session_started = ui.statistics.start_current_period
    local user_duration_format = G_reader_settings:readSetting("duration_format", "classic")
    user_duration_format = "letters"  -- Force letters format
    local duration = datetime.secondsToClockDuration(user_duration_format, os.time() - session_started, true)
    return duration
end

-----------------------------------------------------
-- Main Paint Function Override
-----------------------------------------------------
ReaderView.paintTo = function(self, bb, x, y)
    _ReaderView_paintTo_orig(self, bb, x, y)
    
    -- Only show on reflowable documents (EPUB, MOBI, etc.)
    if self.render_mode ~= nil then return end
    
    -- Build page number conversion caches
    local stable_to_screen_cache, screen_to_stable_cache = buildPageCaches(self.ui)
    
    ------------------------------------------------------
    -- COLLECT BOOK DATA
    ------------------------------------------------------
    local book = {
        title = "",
        author = "",
        pages = {
            total = {
                screen = self.ui.doc_settings.data.doc_pages or 1,
                stable = screenToStablePage(self.ui.doc_settings.data.doc_pages or 1, screen_to_stable_cache) or 1
            },
            current = {
                screen = self.state.page or 1,
                stable = screenToStablePage(self.state.page or 1, screen_to_stable_cache) or 1
            },
            remaining = {screen = 0, stable = 0}
        },
        reading = {progress = "", percentage = 0, time = "N/A"}
    }
    
    if self.ui.doc_props then
        book.title = self.ui.doc_props.display_title or ""
        book.author = self.ui.doc_props.authors or ""
        if book.author:find("\n") then -- Show first author if multiple authors
            book.author = T(_("%1 et al."), util.splitToArray(book.author, "\n")[1])
        end
    end
    
    -- Calculate book-level metrics
    book.pages.remaining.screen = book.pages.total.screen - book.pages.current.screen
    book.pages.remaining.stable = book.pages.total.stable - book.pages.current.stable
    book.reading.progress = ("%d / %d"):format(book.pages.current.stable, book.pages.total.stable)
    book.reading.percentage = (book.pages.current.screen / book.pages.total.screen) * 100
    
    ------------------------------------------------------
    -- COLLECT CHAPTER AND PART DATA
    ------------------------------------------------------
    local chapter = {
        title = "",
        pages = {total = {screen = 0, stable = 0}, current = {screen = 0, stable = 0}, remaining = {screen = 0, stable = 0}},
        reading = {progress = "", percentage = 0, time = "N/A"}
    }
    
    local part = {
        exists = false,
        title = "",
        pages = {total = {screen = 0, stable = 0}, current = {screen = 0, stable = 0}, remaining = {screen = 0, stable = 0}},
        reading = {progress = "", percentage = 0, time = "N/A"}
    }
    
    local temp = {
        title = "",
        pages = {total = {screen = 0, stable = 0}, current = {screen = 0, stable = 0}, remaining = {screen = 0, stable = 0}},
        reading = {progress = "", percentage = 0, time = "N/A"}
    }
    
    if self.ui.toc then
        chapter.title = self.ui.toc:getTocTitleByPage(book.pages.current.screen) or ""
        
        -- Ensure chapter lengths are calculated
        if not self.ui.toc.toc[1].chapter_length then
            self.ui.toc:completeTocWithChapterLengths()
        end
        
        local max_depth = 0
        for _, entry in ipairs(self.ui.toc.toc) do
            if entry.depth == 2 then part.exists = true end -- check if book has parts
            if entry.depth > max_depth then max_depth = entry.depth end -- get chapter level depth
        end
        
        for _, entry in ipairs(self.ui.toc.toc) do
            if book.pages.current.screen >= entry.page and 
               book.pages.current.screen < (entry.page + entry.chapter_length) then
                
                temp.title = entry.title
                temp.pages.current.screen = book.pages.current.screen - entry.page + 1
                temp.pages.total.screen = entry.chapter_length
                temp.pages.remaining.screen = temp.pages.total.screen - temp.pages.current.screen
                
                local temp_start_stable = screenToStablePage(entry.page, screen_to_stable_cache) or 1
                local temp_end_stable = screenToStablePage(entry.page + entry.chapter_length, screen_to_stable_cache) or 1
                temp.pages.current.stable = book.pages.current.stable - temp_start_stable + 1
                temp.pages.total.stable = temp_end_stable - temp_start_stable + 1
                temp.pages.remaining.stable = temp.pages.total.stable - temp.pages.current.stable
                
                temp.reading.progress = ("%d / %d"):format(temp.pages.current.stable, temp.pages.total.stable)
                if temp.pages.total.screen > 0 then
                    temp.reading.percentage = (temp.pages.current.screen / temp.pages.total.screen) * 100
                end

                -- Part data (depth 1)
                if entry.depth == 1 then
                    part.title = temp.title

                    for key, value in pairs(temp.reading) do
                        part.reading[key] = value
                    end

                    for key, value in pairs(temp.pages) do
                        part.pages[key].stable = value.stable
                        part.pages[key].screen = value.screen
                    end
                end
                
                -- Chapter data (max depth)
                if entry.depth == max_depth then
                    chapter = temp
                end
            end
        end
    end
    
    ------------------------------------------------------
    -- CALCULATE TIME REMAINING
    ------------------------------------------------------
    if self.ui.statistics and self.ui.statistics.settings and self.ui.statistics.settings.is_enabled then
        local avg_time = self.ui.statistics.avg_time
        if avg_time and avg_time > 0 then
            local user_format = G_reader_settings:readSetting("duration_format", "classic")
            book.reading.time = datetime.secondsToClockDuration(user_format, book.pages.remaining.screen * avg_time, true)
            if chapter.pages.total.screen > 0 then
                chapter.reading.time = datetime.secondsToClockDuration(user_format, chapter.pages.remaining.screen * avg_time, true)
            end
            if part.exists and part.pages.total.screen > 0 then
                part.reading.time = datetime.secondsToClockDuration(user_format, part.pages.remaining.screen * avg_time, true)
            end
        end
    end
    
    ------------------------------------------------------
    -- SYSTEM INFO
    ------------------------------------------------------
    local time = datetime.secondsToHour(os.time(), G_reader_settings:isTrue("twelve_hour_clock")) or ""
    local battery = ""
    if Device:hasBattery() then
        local power_dev = Device:getPowerDevice()
        local batt_lvl = power_dev:getCapacity() or 0
        local is_charging = power_dev:isCharging() or false
        local batt_prefix = power_dev:getBatterySymbol(power_dev:isCharged(), is_charging, batt_lvl) or ""
        battery = batt_prefix .. batt_lvl .. "%"
    end
    local session_duration = getSessionDuration(self.ui)
    logger.info(session_duration)
    
    ------------------------------------------------------
    -- Text Fitting Function
    ------------------------------------------------------
    -- Calculate margins
    local left_margin = header_use_book_margins and (self.document:getPageMargins().left or header_margin) or header_margin
    local right_margin = header_use_book_margins and (self.document:getPageMargins().right or header_margin) or header_margin
    local avail_width = screen_width - left_margin - right_margin

    local function getFittedText(text, max_width_pct)
        if not text or text == "" then return "" end
        local text_widget = TextWidget:new{
            text = text:gsub(" ", "\u{00A0}"),
            max_width = avail_width * max_width_pct * 0.01,
            face = Font:getFace(header_font_face, header_font_size),
            bold = header_font_bold,
            padding = 0,
        }
        local fitted_text, add_ellipsis = text_widget:getFittedText()
        text_widget:free()
        if add_ellipsis then fitted_text = fitted_text .. "…" end
        return BD.auto(fitted_text)
    end    
    ------------------------------------------------------
    -- BUILD HEADER
    ------------------------------------------------------
    local left_line1, right_line1, left_line2, right_line2 = generateHeaderContent(book, part, chapter, time, battery, session_duration)

    
    -- Create text widgets
    left_line1 = getFittedText(left_line1, left_max_width_pct)
    right_line1 = getFittedText(right_line1, right_max_width_pct)
    left_line2 = getFittedText(left_line2, left_max_width_pct)
    right_line2 = getFittedText(right_line2, right_max_width_pct)

    local function createTextWidget(text, color)
        return TextWidget:new{
            text = text, 
            face = Font:getFace(header_font_face, header_font_size), 
            bold = header_font_bold, 
            fgcolor = color, 
            padding = 0
        }
    end
    
    local left_text1 = createTextWidget(left_line1, header_font_color)
    local right_text1 = createTextWidget(right_line1, header_font_color)
    
    local left_text2 = createTextWidget(left_line2, Blitbuffer.COLOR_GRAY_6)
    local right_text2 = createTextWidget(right_line2, Blitbuffer.COLOR_GRAY_6)
    
    local space1 = avail_width - left_text1:getSize().w - right_text1:getSize().w
    local space2 = avail_width - left_text2:getSize().w - right_text2:getSize().w
    local header_height = math.max(left_text1:getSize().h, right_text1:getSize().h) + 
                         math.max(left_text2:getSize().h, right_text2:getSize().h) + header_top_padding
    
    local header = CenterContainer:new{
        dimen = Geom:new{w = screen_width, h = header_height},
        VerticalGroup:new{
            VerticalSpan:new{width = header_top_padding},
            HorizontalGroup:new{left_text1, HorizontalSpan:new{width = space1}, right_text1},
            VerticalSpan:new{width = 5},
            HorizontalGroup:new{left_text2, HorizontalSpan:new{width = space2}, right_text2}
        }
    }
    header:paintTo(bb, x, y)
    ------------------------------------------------------
    -- BUILD FOOTER
    ------------------------------------------------------
    local left_line3 = ""
    local right_line3 = ""
    left_line1, right_line1, left_line2, right_line2, left_line3, right_line3 = generateFooterContent(book, part, chapter, time, battery, session_duration)
    
    local bar_width = screen_width - margin_l - margin_r + 30
    
    left_text1 = createTextWidget(left_line1, header_font_color)
    right_text1 = createTextWidget(right_line1, header_font_color)
    
    left_text2 = createTextWidget(left_line2, header_font_color)
    right_text2 = createTextWidget(right_line2, header_font_color)

    local left_text3 = createTextWidget(left_line3, header_font_color)
    local right_text3 = createTextWidget(right_line3, header_font_color)

    
    space1 = avail_width - left_text1:getSize().w - bar_width - right_text1:getSize().w
    space2 = avail_width - left_text2:getSize().w - bar_width - right_text2:getSize().w
    local space3 = avail_width - left_text3:getSize().w - bar_width - right_text3:getSize().w
    
    local footer_height = math.max(left_text1:getSize().h, right_text1:getSize().h) +  
                         math.max(left_text2:getSize().h, right_text2:getSize().h) + 
                         math.max(left_text3:getSize().h, right_text3:getSize().h) + header_top_padding
    
    local footer = CenterContainer:new{
        dimen = Geom:new{w = screen_width, h = screen_height},
        VerticalGroup:new{
            VerticalSpan:new{width = screen_height - footer_height},
            HorizontalGroup:new{left_text1, HorizontalSpan:new{width = bar_width}, right_text1, HorizontalSpan:new{width = space1}},
            VerticalSpan:new{height = -5},
            HorizontalGroup:new{left_text2, HorizontalSpan:new{width = bar_width}, right_text2, HorizontalSpan:new{width = space2}},
            VerticalSpan:new{height = -5},
            HorizontalGroup:new{left_text3, HorizontalSpan:new{width = bar_width}, right_text3, HorizontalSpan:new{width = space3}}
        }
    }
    footer:paintTo(bb, x, y)
    
    ------------------------------------------------------
    -- BUILD PROGRESS BARS
    ------------------------------------------------------
    local prog_bar_width = screen_width - margin_l - margin_r
    local bot_bar_y = screen_height - prog_bar_thickness - bottom_padding
    local mid_bar_y, top_bar_y
    
    if stacked then
        mid_bar_y = bot_bar_y - prog_bar_thickness - gap
        top_bar_y = mid_bar_y - prog_bar_thickness - gap
    else
        mid_bar_y = top_padding
        top_bar_y = top_padding
    end
    
    local bar_percentages = {
        chapter.reading.percentage / 100,
        part.reading.percentage / 100,
        book.reading.percentage / 100
    }
    
    local function createBar(percentage, color)
        return ProgressWidget:new{
            width = prog_bar_width, 
            height = prog_bar_thickness, 
            percentage = percentage,
            margin_v = 0, 
            margin_h = 0, 
            radius = radius, 
            bordersize = 0,
            fillcolor = color, 
            bordercolor = bar_unread_color, 
            bgcolor = bar_unread_color
        }
    end
    
    local top_bar = createBar(bar_percentages[top_bar_type], top_bar_seen_color)
    local mid_bar = createBar(bar_percentages[mid_bar_type], mid_bar_seen_color)
    local bot_bar = createBar(bar_percentages[bot_bar_type], bot_bar_seen_color)
    
    paintProgressBarRGB(top_bar, bb, margin_l, top_bar_y)
    paintProgressBarRGB(mid_bar, bb, margin_l, mid_bar_y)
    paintProgressBarRGB(bot_bar, bb, margin_l, bot_bar_y)
end
