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
local TOP = 0
local MID = 0.5
local BOT = 1

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR MENU
---------------------------------------------------------------------------------------------------
local rows = 2
local icon_folder = "colours/" -- the folder inside /icons/
local icon_name_select = NAME -- if your icons are {id}.png or {Name}.png

local icon_width = 120 -- (120) assume square icon (button will also be square unless offset exceed icon bounds)
local bordersize = 2

local show_color_Name = true
local text_size = 10  -- (10)
local min_text_size = 6
local text_position = BOT
local text_offset = 30 -- (30)

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

        --[[
        Create the text widget (if desired, at desired vertical position, with desired offset)
            - {VerticalSpan + textWidget}
            |- Vertical Group
                |- CenterContainer
        ]]
        local color_button
        local icon_widget = IconWidget:new{
                        icon = icon_folder .. icon_prefix,
                        width = icon_width,
                        height = icon_width,
                    }
        local function make_button(padding, bordersize, input_container)
            return InputContainer:new{
                FrameContainer:new{
                    padding = padding,
                    bordersize = bordersize,
                    input_container
                }
            }
        end

        -- Check if text desired
        if show_color_Name then
            -- Create text widget
            local text_Widget = TextWidget:new{
                                    text = color_nm,
                                    face = Font:getFace(nil, text_size),
                                    fgcolor = BlitBuffer.COLOR_BLACK,
                                    bold = true,
                                }
            -- Get original height so that text moves down the same amount
            local orig_text_height = text_Widget:getSize().h
            -- Check if text too large
            for ts=text_size,min_text_size,-1 do
                if text_Widget:getSize().w > icon_width then
                    text_Widget = TextWidget:new{
                                    text = color_nm,
                                    face = Font:getFace(nil, ts-1),
                                    fgcolor = BlitBuffer.COLOR_BLACK,
                                    bold = true,
                                }
                else
                    break
                end
            end

            -- Get the required span
            local mismatch = 0.5*(orig_text_height - text_Widget:getSize().h)
            local required_span = text_position * (icon_width - orig_text_height) + mismatch

            -- Get new span for offset
            local new_span = required_span + text_offset
            local available_height = icon_width - text_Widget:getSize().h -- How far from top can text widget be pushed?

            local overlap_group

            -- Check bounds to see how to arrange
            if new_span < 0 then
                -- Text above icon container
                overlap_group = OverlapGroup:new{
                        CenterContainer:new{
                            dimen = Geom:new{ w = icon_width, h = icon_width + text_offset + text_Widget:getSize().h},
                            VerticalGroup:new{
                                VerticalSpan:new{ width = required_span - text_offset}, -- offset will be negative
                                icon_widget
                            }
                        },
                        CenterContainer:new{
                            dimen = Geom:new{ w = icon_width, h = text_Widget:getSize().h },
                            text_Widget
                        }
                    }

            elseif new_span > available_height then
                -- Text will go below icon container
                overlap_group = OverlapGroup:new{
                    icon_widget,
                    CenterContainer:new{
                        dimen = Geom:new{ w = icon_width, h = icon_width + text_offset - mismatch}, -- overlaps aligned at top-left
                        VerticalGroup:new{
                            VerticalSpan:new{ width = new_span}, -- req_span + offset
                            text_Widget
                        }
                    }
                }
            else
                -- Text within bounds
                overlap_group = OverlapGroup:new{
                    icon_widget,
                    CenterContainer:new{
                        dimen = Geom:new{ w = icon_width, h = icon_width },
                        VerticalGroup:new{
                            VerticalSpan:new{ width = new_span},
                            text_Widget
                        }
                    }
                }
            end

            -- Make the button
            color_button = make_button(padding, bordersize, overlap_group)

        else
            -- Don't need the OverlapGroup
            color_button = make_button(padding, bordersize, icon_widget)
        end
        
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