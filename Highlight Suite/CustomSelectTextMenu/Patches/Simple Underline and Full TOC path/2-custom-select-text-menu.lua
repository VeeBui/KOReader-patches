--[[
===================================================================================================
KOREADER CUSTOM HIGHLIGHT MENU
- Adds an underline option and changes chapter field to Full TOC Path
===================================================================================================

This patch adds:
1. Ability to rearrange menu buttons in select text menu
2. Ability to add custom buttons to select text menu
    i) Custom highlight function saveHighlightFormatted()
        which allows specification of highlight style and colour
    ii) Functionality can be customised from readerhighlight.lua
3. Toggle whether chapter gets saved as lowest TOC level or full path
    e.g. Part 1 ▸ Chapter 1

CREDITS:
- My original highlight menu patch: https://github.com/VeeBui/koReader-highlight-menu-patch/blob/main/2-highlight-menu-modifications.lua
- Full TOC Path: https://github.com/koreader/koreader/issues/12480#issuecomment-2835548463
===================================================================================================
]]--

-- Required libraries
local ReaderHighlight = require("apps/reader/modules/readerhighlight")
local _ = require("gettext")
local UIManager = require("ui/uimanager")
local Geom = require("ui/geometry")
local logger = require("logger")

-- Store the original functions to call it later if needed
local orig_init = ReaderHighlight.init
local orig_saveHighlight = ReaderHighlight.saveHighlight

-- Constants
local ON = true
local OFF = false

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR MENU
---------------------------------------------------------------------------------------------------

local full_chapter_path = ON -- Show all valid table of contents items in chapter field
local seperator_symbol = " ▸ " -- How to seperate TOC items in chapter field

-- PLACE YOUR DESIRED BUTTONS/FUNCTIONS HERE
    -- If no func is specified, the original source code will be used for that button
local function make_custom_buttons(self)
    local custom_buttons = {
        {id = "select"},    -- Default select button
        {
            -- Custom highligh button [MODIFIED]
            -- Saves full chapter path, draws with lighten, does not stop rolling text
            id = "highlight",
            func = function(this)
                return {
                    text = _("Highlight"),
                    enabled = this.hold_pos ~= nil,
                    callback = function()
                        this:saveHighlightFormatted(
                            true,
                            "lighten",
                            self.view.highlight.saved_color
                        )
                        this:onClose()
                    end,
                }
            end,
            -- End custom highlight button
        },
        {id = "copy"},      -- Default copy button
        {
            -- Custom underline button [NEW]
            -- Saves full chapter path, draws with underscore, stops rolling text
            id = "underline",
            func = function(this)
                return {
                    text = _("Underline"),
                    enabled = this.hold_pos ~= nil,
                    callback = function()
                        this:saveHighlightFormatted(
                            false,
                            "underscore",
                            self.view.highlight.saved_color
                        )
                        this:onClose()
                    end,
                }
            end,
            -- End custom underline button
        },
        {id = "add_note"},
        {id = "wikipedia"},
        {id = "dictionary"},
        {id = "translate"},
        {id = "share_text"}, -- for devices that can share text
        {id = "view_html"}, -- for cre documents only
        {id = "user_dict"},
        {id = "follow_link"}, -- if link selected
        {id = "search"},
    }
    return custom_buttons
end

---------------------------------------------------------------------------------------------------
-- 🔧 INTERNAL CODE - YOU DON'T NEED TO EDIT BELOW THIS LINE
---------------------------------------------------------------------------------------------------
function ReaderHighlight:init(index)
    orig_init(self)
    local new_buttons = {}
    local custom_buttons = make_custom_buttons(self)
    
    for i, button_data in ipairs(custom_buttons) do
        local button_id = button_data.id
        local new_key = string.format("%003d_%s", i, button_id)
        
        if button_data.func then
            new_buttons[new_key] = button_data.func
        else
            -- Search for matching button in original _highlight_buttons
            for orig_key, orig_button_fn in pairs(self._highlight_buttons) do
                -- Extract the part after the first 3 characters (e.g., "01_" -> "select")
                local orig_id = orig_key:sub(4)  -- Skip "XX_" prefix
                
                if orig_id == button_id then
                    new_buttons[new_key] = orig_button_fn
                    break
                end
            end
        end
    end
	
    self._highlight_buttons = new_buttons
end

function ReaderHighlight:saveHighlightFormatted(extend_to_sentence, hlStyle, hlColor)
    -- Temporarily override the saved drawer and color
    local original_drawer = self.view.highlight.saved_drawer
    local original_color = self.view.highlight.saved_color
    
    self.view.highlight.saved_drawer = hlStyle
    self.view.highlight.saved_color = hlColor
    
    -- Call the original function
    local index = orig_saveHighlight(self, extend_to_sentence)
    
    -- Restore original values
    self.view.highlight.saved_drawer = original_drawer
    self.view.highlight.saved_color = original_color
    
    -- Modify the chapter field if needed
    if index and full_chapter_path then
        local item = self.ui.annotation.annotations[index]
        if item then
            local pg_or_xp
            if self.ui.rolling then
                pg_or_xp = item.pos0
            else
                pg_or_xp = item.pos0.page
            end
            item.chapter = table.concat(self.ui.toc:getFullTocTitleByPage(pg_or_xp), seperator_symbol)
        end
    end
    
    return index
end