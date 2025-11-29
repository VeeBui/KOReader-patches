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
===================================================================================================
]]--

-- Required libraries
local BlitBuffer = require("ffi/blitbuffer")
local ReaderHighlight = require("apps/reader/modules/readerhighlight")

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMIZE YOUR COLOURS
---------------------------------------------------------------------------------------------------
local custom_colors = {
    -- {"id", "Display text", "hex code"}
    -- You can have as many or as little lines as you like
    -- ID's can have any value
    -- Colours will show in the order you place them here
    {"red", "Spicy", "#F0A2A2"},
    {"orange", "Weird", "#F7C49C"},
    {"yellow", "Interesting", "#FBEC8B"},
    {"olive", "Character", "#AFE8A8"},
    {"green", "Hate", "#86cc7cff"},
    {"turquoise", "Funny", "#66DCC0"},
    {"cyan", "Artistic", "#7FE7FE"},
    {"blue", "Deep", "#86B6F0"},
    {"indigo", "Special", "#807DE7"},
    {"purple", "General", "#C59CFF"},
    {"pink", "Love", "#FFBEF7"},
    {"grey", "Grey", "#CECECE"}
}

---------------------------------------------------------------------------------------------------
-- 🔧 INTERNAL CODE - YOU DON'T NEED TO EDIT BELOW THIS LINE
---------------------------------------------------------------------------------------------------

ReaderHighlight_orig_colors = ReaderHighlight.highlight_colors
ReaderHighlight.highlight_colors = {}
for _, color_data in ipairs(custom_colors) do
    table.insert(ReaderHighlight.highlight_colors, {color_data[2], color_data[1]})
end

BlitBuffer_orig_highlight_colors = BlitBuffer.HIGHLIGHT_COLORS
BlitBuffer.HIGHLIGHT_COLORS = {}
for _, color_data in ipairs(custom_colors) do
    BlitBuffer.HIGHLIGHT_COLORS[color_data[1]] = color_data[3]
end