--[[
===================================================================================================
KOREADER CUSTOM HIGHLIGHT MENU
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

    -- Defaults:
    -- self.view.highlight.saved_drawer
    -- self.view.highlight.saved_color
local function make_custom_buttons(self)
    local custom_buttons = {
        {id = "select"},    -- Default select button
        {id = "copy"},      -- Default copy button
        {
            -- Custom highlight button
            -- Saves full chapter path, opens colour menu, closes initial menu
            id = "highlight",
            func = custom_highlight_func,
            -- End custom highlight button
        },
        {
            -- Custom underline button [NEW]
            -- Saves full chapter path, draws with underscore, stops rolling text
            id = "underline",
            func = function(this)
                return {
                    text = _("Underline"),
                    enabled = this.hold_pos ~= nil,
                    callback = function()
                        this:saveHighlightFormatted(false,"underscore",self.view.highlight.saved_color)
                        this:onClose()
                    end,
                }
            end,
            -- End custom underline button
        },
        {id = "add_note"},  -- Default add note button
        {id = "translate"}, -- Default translate button
        {id = "dictionary"},-- Default dictionary button
        {id = "wikipedia"}, -- Default wikipedia button
        {id = "search"}     -- Default search button
    }
    return custom_buttons
end

----------------------------------------------------------------------
-- Modify function ReaderHighlight:showHighlightColorDialog(caller_callback, item)
-- Because if you close the color_dialog without selecting a colour, the text will remain selected
local old_showHighlightColorDialog = ReaderHighlight.showHighlightColorDialog
function ReaderHighlight:showHighlightColorDialog(caller_callback, item)
    -- run the previous function
    old_showHighlightColorDialog(self, caller_callback, item)
    
    if not self.highlight_color_dialog then
        return
    end
    
    local old_onClose = self.highlight_color_dialog.onClose
    -- modify to clear selection
    self.highlight_color_dialog.onClose = function(dialog)
        -- run the old onTapClose function
        if old_onClose then
            old_onClose(dialog)
        end
        
        -- clear selection if no colour chose
        if not self._color_chosen then
            self:clear()
        end
    end
end
----------------------------------------------------------------------
-- Functions were getting unwieldy, so placed them down here
function custom_highlight_func(this)
    return {
        text = _("Highlight"),
        enabled = this.hold_pos ~= nil,
        callback = function()
            -- Store the selected text before closing
            local saved_selection = {
                pos0 = this.selected_text.pos0,
                pos1 = this.selected_text.pos1,
                text = this.selected_text.text,
                sboxes = this.selected_text.sboxes,
                pboxes = this.selected_text.pboxes,
                datetime = this.selected_text.datetime,
            }
            local saved_hold_pos = this.hold_pos
            
            -- Close ONLY the dialog, not the highlight
            if this.highlight_dialog then
                UIManager:close(this.highlight_dialog)
                this.highlight_dialog = nil
            end
            -- Restore the selection
            this.selected_text = saved_selection
            this.hold_pos = saved_hold_pos

            -- Redraw the highlight with the restored boxes
            if this.ui.paging then
                this.view.highlight.temp[saved_hold_pos.page] = saved_selection.sboxes or saved_selection.pboxes
                UIManager:setDirty(this.dialog, "ui")
            else
                UIManager:setDirty(this.dialog, "ui", Geom.boundingBox(saved_selection.sboxes))
            end

            this._color_chosen = false
            
            -- Then show colour dialog immediately
            this:showHighlightColorDialog(
                function(selected_color)
                    this._color_chosen = true
                    this:saveHighlightFormatted(true, "lighten", selected_color)
                    this:clear()  -- Clear highlight after saving
                end,
                this
            )
        end,
    }
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
        local new_key = string.format("%02d_%s", i, button_id)
        
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