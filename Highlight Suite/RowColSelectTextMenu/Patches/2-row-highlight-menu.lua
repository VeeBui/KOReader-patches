--[[
===================================================================================================
KOREADER ROW HIGHLIGHT MENU
===================================================================================================

This patch adds:
1. Ability to choose the number of columns OR rows (but not both) in the Select Text Menu
    i. I.e. can be used to create a single row of button icons
    ii. Independent to any changes to the source ReaderHighlight:onShowHighlightMenu
        as long as ButtonDialog is still called (and hasn't changed)
    iii. Works with my CustomHighlightMenu patch and 2-underline-option-in-menu.lua patch

===================================================================================================
]]--

-- Required libraries
local ReaderHighlight = require("apps/reader/modules/readerhighlight")

-- Store the original function(s) to call later (if needed)
local orig_onShowHighlightMenu = ReaderHighlight.onShowHighlightMenu

-- Constants (Don't change)
local ROWS = true
local COLS = false

---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR MENU
---------------------------------------------------------------------------------------------------

-- Set the number of columns/rows for the highlight menu
--  Default is 2 columns
local set_rows_or_cols = ROWS   -- Set to "ROWS" or "COLS"
local num_rows_or_cols = 1      -- How many of the chosen do you want?

---------------------------------------------------------------------------------------------------
-- 🔧 INTERNAL CODE - YOU DON'T NEED TO EDIT BELOW THIS LINE
---------------------------------------------------------------------------------------------------

-- Override the function
function ReaderHighlight:onShowHighlightMenu(index)
    if not self.selected_text then
        return
    end

    -- Call original but intercept the columns variable
    local orig_ButtonDialog_new = require("ui/widget/buttondialog").new
    local ButtonDialog = require("ui/widget/buttondialog")
    
    -- Temporarily wrap ButtonDialog constructor to modify the columns before it's used
    ButtonDialog.new = function(class, args)
        -- args is a pointer so any changes here will persist for the current function call

        --[[
        Original function will have already built highlight_buttons with wrong columns
        So we need to rebuild it with correct columns
        ]]--
        if args.buttons and #args.buttons > 0 then

            -- Flatten and rebuild with new column count
            local all_buttons = {}
            for _, row in ipairs(args.buttons) do
                for _, button in ipairs(row) do
                    table.insert(all_buttons, button)
                end
            end

            -- Logic for determining number of columns
            local highlight_menu_columns = num_rows_or_cols
            if set_rows_or_cols then
                highlight_menu_columns = math.ceil(#(all_buttons) / num_rows_or_cols)
            end
            
            -- Rebuild with new column count
            local new_buttons = {{}}
            for _, button in ipairs(all_buttons) do
                if #new_buttons[#new_buttons] >= highlight_menu_columns then
                    table.insert(new_buttons, {})
                end
                table.insert(new_buttons[#new_buttons], button)
            end
            
            args.buttons = new_buttons
        end
        
        -- Restore original and call it
        ButtonDialog.new = orig_ButtonDialog_new
        return orig_ButtonDialog_new(class, args)
    end
    
    -- Call original
    return orig_onShowHighlightMenu(self, index)
end