--[[
===================================================================================================
KOREADER ICON HIGHLIGHT MENU
===================================================================================================

This patch adds:
1. 

CREDITS:
- erildt's branch of my highlight-menu-patch: https://github.com/erildt/koReader-highlight-menu-patch/blob/main/2-highlight-menu-modifications.lua
===================================================================================================
]]--

-- Required libraries
local ReaderHighlight = require("apps/reader/modules/readerhighlight")
local _ = require("gettext")
local UIManager = require("ui/uimanager")
local ButtonDialog = require("ui/widget/buttondialog")
local IconButton = require("ui/widget/iconbutton")
local BlitBuffer = require("ffi/blitbuffer")
local DataStorage = require("datastorage")
local lfs = require("libs/libkoreader-lfs")
local logger = require("logger")

-- Store the original functions to call it later if needed
local orig_showHighlightColorDialog = ReaderHighlight.showHighlightColorDialog

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR MENU
---------------------------------------------------------------------------------------------------
local rows = 2
local icon_folder = "colours/" -- the folder inside /icons/
local change_set_for_underline = true

-- underline options (optional)
local underline_colors = {
    -- {"Name", "id"}
    {"General", "purple"},
    {"Deities", "red"},
    {"Animals", "yellow"},
    {"References", "green"},
    {"Mentions", "grey"},
    {"Other", "cyan"}
}
---------------------------------------------------------------------------------------------------
-- 🔧 INTERNAL CODE - YOU DON'T NEED TO EDIT BELOW THIS LINE
---------------------------------------------------------------------------------------------------

function ReaderHighlight:showHighlightColorDialog(caller_callback, item)
    -- currently in my patches I only modify underscores
    -- I don't call this function during creation, like I do with lighten

    local curr_style
    if item then
        -- we are modifying an existing highlight
        -- could be any value
        curr_style = item.drawer
    else
        -- we are in the lighten -> creation menu from my other patch
        curr_style = "lighten"
    end

    local hl_colors
    if curr_style == "underscore" then
        hl_colors = underline_colors
    else
        hl_colors = self.highlight_colors
    end
    
    -- Build button rows
    local buttons = {{}}
    local colors_per_row = math.ceil(#(hl_colors) / rows)
    
    for _, v in ipairs(hl_colors) do
        -- Start a new row if current row is full
        if #buttons[#buttons] >= colors_per_row then
            table.insert(buttons, {})
        end
        
        table.insert(buttons[#buttons], {
            icon = icon_folder .. v[2],  -- Just the path within icons/, no .png
            callback = function()
                caller_callback(v[2])
                UIManager:close(self.highlight_color_dialog)
            end,
        })
    end
    
    self.highlight_color_dialog = ButtonDialog:new{
        buttons = buttons,
    }
    
    UIManager:show(self.highlight_color_dialog, "[ui]")
end