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

local WidgetContainer = require("ui/widget/container/widgetcontainer")
local FrameContainer = require("ui/widget/container/framecontainer")
local CenterContainer = require("ui/widget/container/centercontainer")
local VerticalGroup = require("ui/widget/verticalgroup")
local VerticalSpan = require("ui/widget/verticalspan")
local HorizontalGroup = require("ui/widget/horizontalgroup")
local HorizontalSpan = require("ui/widget/horizontalspan")
local IconWidget = require("ui/widget/iconwidget")
local TextWidget = require("ui/widget/textwidget")
local OverlapGroup = require("ui/widget/overlapgroup")
local InputContainer = require("ui/widget/container/inputcontainer")
local GestureRange = require("ui/gesturerange")
local Font = require("ui/font")
local Size = require("ui/size")
local Device = require("device")
local Screen = require("device").screen
local Geom = require("ui/geometry")

local logger = require("logger")

-- Store the original functions to call it later if needed
local orig_showHighlightColorDialog = ReaderHighlight.showHighlightColorDialog

-- Constants
local ID = 2
local NAME = 1

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR MENU
---------------------------------------------------------------------------------------------------
local rows = 2
local icon_folder = "colours/" -- the folder inside /icons/
local icon_name_select = ID -- if your icons are {id}.png or {Name}.png

local icon_width = 100
local text_size = 10
local min_text_size = 6

local change_set_for_underline = true

-- underline options (optional)
local underline_colors = {
    -- {"Name", "id"}
    {"Characters", "purple"},
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
    local curr_style
    if item then
        curr_style = item.drawer
    else
        curr_style = "lighten"
    end

    local hl_colors
    if curr_style == "underscore" then
        hl_colors = underline_colors
    else
        hl_colors = self.highlight_colors
    end

    local colors_per_row = math.ceil(#(hl_colors) / rows)
    local button_rows = {}
    local current_row = {}
    
    for _, v in ipairs(hl_colors) do
        local color_nm = v[1]
        local color_id = v[2]
        local icon_prefix = v[icon_name_select]

        if #current_row >= colors_per_row then
            table.insert(button_rows, HorizontalGroup:new{ unpack(current_row) })
            current_row = {}
        end

        -- Create text widget
        local textWidget = TextWidget:new{
                                text = color_nm,
                                face = Font:getFace(nil, text_size),
                                fgcolor = BlitBuffer.COLOR_BLACK,
                                bold = true,
                            }

        -- Check if text too large
        for ts=text_size,min_text_size,-1 do
            if textWidget:getSize().w > icon_width then
                textWidget = TextWidget:new{
                                text = color_nm,
                                face = Font:getFace(nil, ts-1),
                                fgcolor = BlitBuffer.COLOR_BLACK,
                                bold = true,
                            }
            else
                break
            end
        end
        
        -- Create button with icon and overlaid text
        local color_button = InputContainer:new{
            FrameContainer:new{
                padding = Size.padding.small,
                bordersize = Size.border.button,
                OverlapGroup:new{
                    IconWidget:new{
                        icon = icon_folder .. icon_prefix,
                        width = icon_width,
                        height = icon_width,
                    },
                    CenterContainer:new{
                        dimen = Geom:new{ w = icon_width, h = icon_width },
                        VerticalGroup:new{
                            VerticalSpan:new{width = icon_width - textWidget:getSize().h},
                            textWidget
                        }
                    }
                }
            }
        }
        
        color_button.ges_events = {
            Tap = {
                GestureRange:new{
                    ges = "tap",
                    range = function()
                        return color_button[1].dimen
                    end
                }
            }
        }
        
        color_button.onTap = function()
            caller_callback(color_id)
            UIManager:close(self.highlight_color_dialog)
            UIManager:setDirty(nil, "full")
            return true
        end
        
        table.insert(current_row, color_button)
    end
    
    if #current_row > 0 then
        table.insert(button_rows, HorizontalGroup:new{ unpack(current_row) })
    end
    
    -- Create the main dialog as an InputContainer
    self.highlight_color_dialog = InputContainer:new{
        CenterContainer:new{
            dimen = Screen:getSize(),
            FrameContainer:new{
                background = BlitBuffer.COLOR_WHITE,
                bordersize = Size.border.window,
                radius = Size.radius.window,
                padding = Size.padding.default,
                VerticalGroup:new(button_rows)
            }
        }
    }

    -- Add tap-to-close background gesture
    self.highlight_color_dialog.ges_events = {
        TapClose = {
            GestureRange:new{
                ges = "tap",
                range = Screen:getSize(),
            }
        }
    }
    
    self.highlight_color_dialog.onTapClose = function(this, arg, ges)
        local frame = this[1][1]  -- Get the FrameContainer
        if not ges.pos:intersectWith(frame.dimen) then
            UIManager:close(self.highlight_color_dialog)
            UIManager:setDirty(nil, "full")
        end

        -- clear selection
        if not self._color_chosen then
            self:clear()
        end
        return true
    end
    
    UIManager:show(self.highlight_color_dialog, "[ui]")
    UIManager:setDirty(nil, "full")
    UIManager:setDirty(nil, "full")
end