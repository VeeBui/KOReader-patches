-- Required libraries
local Device = require("device")
local logger = require("logger")
local util = require("util")
local Screen = Device.screen
local _ = require("gettext")
local T = require("ffi/util").template
local ReaderView = require("apps/reader/modules/readerview")
local _ReaderView_paintTo_orig = ReaderView.paintTo

-- Global cache
local TOC_cache = {}
local screen_to_stable_cache = {}

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

local function screenToStablePage(screen_page)
    local stable = screen_to_stable_cache[screen_page]
    while stable == nil and screen_page > 0 do
        screen_page = screen_page - 1
        stable = screen_to_stable_cache[screen_page]
    end
    return stable
end

-----------------------------------------------------
-- Debug Utilities
-----------------------------------------------------

function dump(o, indent)
   indent = indent or 0
   local indent_str = string.rep("  ", indent)
   
   if type(o) == 'table' then
      local s = '{\n'
      
      -- Collect and sort keys
      local keys = {}
      for k in pairs(o) do
         table.insert(keys, k)
      end
      table.sort(keys, function(a, b)
         -- Sort numbers before strings, then sort within each type
         if type(a) == "number" and type(b) == "number" then
            return a < b
         elseif type(a) == "string" and type(b) == "string" then
            return a < b
         else
            return type(a) == "number"  -- numbers first
         end
      end)
      
      -- Iterate in sorted order
      for _, k in ipairs(keys) do
         local v = o[k]
         local key_str = type(k) == 'number' and k or '"'..k..'"'
         s = s .. indent_str .. '  [' .. key_str .. '] = ' .. dump(v, indent + 1) .. ',\n'
      end
      
      return s .. indent_str .. '}'
   else
      return tostring(o)
   end
end

local function formatSection(section, depth)
    local indent = string.rep("\t", depth)
    local start_screen = section.start_page.screen[1] or "?"
    local end_screen = section.end_page and section.end_page.screen[1] or "?"
    local start_stable = section.start_page.stable[1] or "?"
    local end_stable = section.end_page and section.end_page.stable[1] or "?"
    
    local output = string.format(
        "%s'%s'\n%s%s > %s\t\t%s > %s\n",
        indent,
        section.title,
        indent,
        start_screen,
        end_screen,
        start_stable,
        end_stable
    )
    
    -- Recursively format subsections
    if section.sections and #section.sections > 0 then
        for _, subsection in ipairs(section.sections) do
            output = output .. formatSection(subsection, depth + 1)
        end
    end
    
    return output
end

local function formatBookCache(book_cache)
    local output = string.format("\n=== %s by %s ===\n", book_cache.title, book_cache.author)
    
    for _, section in ipairs(book_cache.sections) do
        output = output .. formatSection(section, 0)
    end
    
    output = output .. "=== End of TOC ===\n"
    
    return output
end

-----------------------------------------------------
-- Book Information Extraction
-----------------------------------------------------

local function getBookInfo(ui)
    local book_id = ""
    local book_title = ""
    local book_author = ""
    
    if ui.doc_props then
        book_title = ui.doc_props.display_title or ""
        book_author = ui.doc_props.authors or ""
        
        -- Show first author if multiple authors
        if book_author:find("\n") then
            book_author = T(_("%1 et al."), util.splitToArray(book_author, "\n")[1])
        end
        
        book_id = book_title .. "-" .. book_author
    end
    
    return book_id, book_title, book_author
end

-----------------------------------------------------
-- TOC Cache Building
-----------------------------------------------------

local function getMaxDepth(toc)
    local max_depth = 0
    for _, entry in ipairs(toc) do
        if entry.depth > max_depth then
            max_depth = entry.depth
        end
    end
    return max_depth
end

local function createSection(entry)
    return {
        title = entry.title,
        start_page = {
            screen = {entry.page},
            stable = {screenToStablePage(entry.page)}
        },
        depth = entry.depth,
        sections = {}
    }
end

local function calculateEndPages(sections, book_end_page, parent_end_page)
    for i, section in ipairs(sections) do
        -- Determine end page based on next sibling or parent's end
        if i < #sections then
            -- End page is one before the next section starts
            local next_section = sections[i + 1]
            local temp = math.max(next_section.start_page.screen[1] - 1, section.start_page.screen[1])
            section.end_page = {
                screen = {temp},
                stable = {screenToStablePage(temp)}
            }
        else
            -- Last section in this level uses parent's end page
            section.end_page = {
                screen = {parent_end_page.screen[1]},
                stable = {parent_end_page.stable[1]}
            }
        end
        
        -- Recursively calculate end pages for subsections
        if section.sections and #section.sections > 0 then
            calculateEndPages(section.sections, book_end_page, section.end_page)
        end
    end
end

local function buildTOCCache(ui, book_id, book_title, book_author)
    TOC_cache[book_id] = {
        title = book_title,
        author = book_author,
        depth = 0,
        start_page = {
            screen = {1},
            stable = {1}
        },
        end_page = {
            screen = {ui.doc_settings.data.doc_pages or 1},
            stable = {screenToStablePage(ui.doc_settings.data.doc_pages or 1) or 1}
        },
        sections = {}
    }
    
    local book_cache = TOC_cache[book_id] -- pointer to sub-table
    
    -- Ensure chapter lengths are calculated
    if not ui.toc.toc[1].chapter_length then
        ui.toc:completeTocWithChapterLengths()
    end
    
    -- Get maximum depth of TOC
    local MAX_DEPTH = getMaxDepth(ui.toc.toc)
    book_cache.max_depth = MAX_DEPTH
    
    -- Initialize tracking variables
    local trackers = {}
    for i = 1, MAX_DEPTH do
        trackers[i] = 0
    end
    
    local prev_depth = 1
    local section_pointers = {book_cache.sections}
    
    -- Build hierarchical structure
    for _, entry in ipairs(ui.toc.toc) do
        if entry.depth <= prev_depth then
            -- New section at same or higher level
            trackers[entry.depth] = trackers[entry.depth] + 1
            
            -- Reset deeper level trackers
            for i = entry.depth + 1, MAX_DEPTH do
                trackers[i] = 0
            end

        elseif entry.depth > prev_depth then
            -- Sub-section (deeper level)
            trackers[entry.depth] = trackers[entry.depth] + 1
            section_pointers[entry.depth] = section_pointers[entry.depth - 1][trackers[entry.depth - 1]].sections
        end

        section_pointers[entry.depth][trackers[entry.depth]] = createSection(entry)        
        prev_depth = entry.depth
    end

    -- Calculate end pages for all sections
    calculateEndPages(book_cache.sections, book_cache.end_page, book_cache.end_page)
    
    -- Debugging
    --logger.info(dump(book_cache))
    --logger.info(formatBookCache(book_cache))
    
end

-----------------------------------------------------
-- Main Paint Override
-----------------------------------------------------

ReaderView.paintTo = function(self, bb, x, y)
    _ReaderView_paintTo_orig(self, bb, x, y)
    
    -- Build page number conversion caches
    local stable_to_screen_cache, temp = buildPageCaches(self.ui)
    screen_to_stable_cache = temp
    
    -- Get book information
    local book_id, book_title, book_author = getBookInfo(self.ui)
    
    -- Check if cache already exists for book
    if TOC_cache[book_id] then
        logger.info(string.format("TOC_cache for %s exists", book_id))
        
    elseif self.ui.toc then
        -- Build the cache
        logger.info(string.format("Building TOC_cache for %s", book_id))
        buildTOCCache(self.ui, book_id, book_title, book_author)
        
    else
        -- No TOC available, create generic cache
        logger.info(string.format("No TOC available for %s", book_id))
        TOC_cache[book_id] = {
            max_depth = 0,
            sections = {}
        }
    end
end