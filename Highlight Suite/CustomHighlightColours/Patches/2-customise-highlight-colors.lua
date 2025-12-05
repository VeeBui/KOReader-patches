--[[
===================================================================================================
KOREADER CUSTOM HIGHLIGHT COLOURS AND DISPLAY TEXT
===================================================================================================

This patch adds:
1. Ability to choose custom display text and hex values for any amount of highlight colours

REQUIREMENTS:
- No longer will work with translation/localisation

CREDITS:
- Original custom highlights: 
    https://www.reddit.com/r/koreader/comments/1ibqhmc/comment/m9kcr4f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    or 
    https://github.com/ImSoRight/KOReader.patches/blob/main/2-customize-highlight-colors.lua
===================================================================================================
]]--

-- Required libraries
local BlitBuffer = require("ffi/blitbuffer")
local _ = require("gettext")
local ReaderHighlight = require("apps/reader/modules/readerhighlight")

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR COLOURS
---------------------------------------------------------------------------------------------------
local custom_colors = {
    -- {"id", "Display text", "hex code"}
    -- You can have as many or as little lines as you like
    -- ID's can have any value
    -- Colours will show in the order you place them here
    {"red", "Red", "#FF3300"},
    {"orange", "Orange", "#FF8800"},
    {"yellow", "Yellow", "#FFFF33"},
    {"green", "Green", "#00AA66"},
    {"olive", "Olive", "#88FF77"},
    {"cyan", "Cyan", "#00FFEE"},
    {"blue", "Blue", "#56A1FC"},
    {"purple", "Purple", "#9500FF"},
    {"gray", "Gray", "#AAAAAA"}
}

---------------------------------------------------------------------------------------------------
-- 🔧 INTERNAL CODE - YOU DON'T NEED TO EDIT BELOW THIS LINE
---------------------------------------------------------------------------------------------------

ReaderHighlight_orig_colors = ReaderHighlight.highlight_colors
ReaderHighlight.highlight_colors = {}
for i, color_data in ipairs(custom_colors) do
    table.insert(ReaderHighlight.highlight_colors, {_(color_data[2]), color_data[1]})
end

BlitBuffer_orig_highlight_colors = BlitBuffer.HIGHLIGHT_COLORS
BlitBuffer.HIGHLIGHT_COLORS = {}
for i, color_data in ipairs(custom_colors) do
    BlitBuffer.HIGHLIGHT_COLORS[color_data[1]] = color_data[3]
end