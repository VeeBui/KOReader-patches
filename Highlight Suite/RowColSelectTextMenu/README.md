## [2-row-highlight-menu.lua](./Patches/2-row-highlight-menu.lua)

A patch to be able to modify the number of rows or columns in the Select Text Menu, without modifying source code files.

> <div style="display: flex; align-items: center; gap: 20px;">
>   <img src="../CustomSelectTextMenu/Example Images/Pre-CustomSelectTextMenu.jpg" alt="Pre Row/Column Select Text Menu" style="width: 400px; max-width: 40%;"/>
>   <span style="font-size: 2em;">→</span>
>   <img src="./Example Images/3-Row-HL-Menu.jpg" alt="Post Row/Column Select Text Menu Example" style="width: 400px; max-width: 40%;"/>
> </div>
> <br>
  
**Features:**
- Ability to choose the number of columns OR rows (but not both) in the Select Text Menu
  - I.e. can be used to create:
    - A single row of button icons
    - A single column of button icons
    - Any sized grid of button icons desired
    - See examples [here](./Example%20Images/)
  - Independent to any changes to the source ReaderHighlight:onShowHighlightMenu as long as ButtonDialog is still called (and hasn't changed)
  - Works with my [Custom Select Text Menu](../CustomSelectTextMenu/) patch and [2-highlight-menu-modifications.lua](https://github.com/VeeBui/koReader-highlight-menu-patch) patch

**Requested by**
  - [u/TheSpicyNovella on Reddit](https://www.reddit.com/r/koreader/comments/1pajkt7/editing_koreader_highlight_menu_columns_on/)

**Considerations:**
- If changes are made to ButtonDialog, usability may be impaired
- Dialog box will still take up most of the screen width. I may make another patch for this in the future. For now, more columns means smaller column-width :)

---

# How to use

All editable settings are located under the following banner
```lua
---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR COLOURS
---------------------------------------------------------------------------------------------------
```

- `local set_rows_or_cols`
  - Accepted values: 
    - `ROWS`: grid will transform to `num_rows_or_cols` number of rows.
    - `COLS`: grid will transform to `num_rows_or_cols` number of columns.
- `local num_rows_or_cols`
  - The amount of rows or columns that you want.
    - The code already takes care of cases where the number of values is not perfectly divisible
    - E.g. for 9 buttons with 2 rows, it will create a 2x5 grid

<details>
<summary><strong>Nerd stuff:</strong></summary>

- `function ReaderHighlight:onShowHighlightMenu(index)`
  - **koreader/frontend/apps/reader/modules/readerhighlight.lua** (line 1510?)
  - Overwriting the `ReaderHighlight:onShowHighlightMenu` function by:
    - Lets the original `ReaderHighlight:onShowHighlightMenu` function run, then rebuilds highlight_buttons with the correct row or column count.
    - First flattens the created buttons into a single list (instead of grid)
    - Second calculates the number of columns needed based on user input (round up)
    - Third rebuilds the button grid layout, by calculating when a row has exceeded the column count
  - This function only modifies the `ButtonDialog.new` function when `ReaderHighlight:onShowHighlightMenu` is run

</details>