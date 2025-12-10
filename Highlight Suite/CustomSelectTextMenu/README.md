## [2-custom-select-text-menu.lua](./Patches/2-custom-select-text-menu.lua)

A patch to modify the buttons shown in the display text menu. 

<div style="display: flex; align-items: center; gap: 20px;">
  <img src="./Example Images/Pre-CustomSelectTextMenu.jpg" alt="Pre Post Custom Highlight Colours Example" style="width: 400px; max-width: 40%;"/>
  <span style="font-size: 2em;">→</span>
  <img src="./Example Images/Post-CustomSelectTextMenu.jpg" alt="Post Custom Highlight Colours Example" style="width: 400px; max-width: 40%;"/>
</div>
<br>
  
> **Features:**
> - Ability to modify the Select Text Menu
>   - Re-order the original buttons
>   - Change the functions applied by any button
>   - Add your own custom button
> - Vee's custom highlight function:
>   - Allows for custom highlight buttons with predetermined style and/or colour
>   - Modifies the chapter field to include the full Table of Contents path (toggleable)
>     - E.g. Instead of `chapter = Chapter 1`, save `chapter = Section 1 ▸ Part 1 ▸ Chapter 1` (if applicable)

<br>

---

**Versions Available**
1. [Modify buttons from the KOReader stock Select Text Menu](./Patches/2-custom-select-text-menu.lua)
2. [Simple addition of Underline Option and Full TOC path](./Patches/Simple%20Underline%20and%20Full%20TOC%20path/2-custom-select-text-menu.lua)
    - Adds an *Underline* option
    - Modifies *Highlight* button
    - Makes use of my custom highlight function for both buttons
      - (Toggle-able full TOC path for chapters)
3. [Quick Highlight Color options](./Patches/Quick%20HL%20Colours/2-custom-select-text-menu.lua)
    - Completely replace the Select Text Menu with a highlight colour menu
      - Tap to highlight, long press to underline
      - Use display text or custom icons
      - Choose icon file name by colour ID or colour Display Text
        - Get my hand-drawn icons [here](../IconColourMenu/Pre-made%20Icons/)
      - Use with my [Row/Column Select Text Menu](../RowColSelectTextMenu/) patch to change the grid layout
4. [**Vee's version**](./Patches/Vee's%20Set-up/2-custom-select-text-menu.lua)
    - Underline button
    - Full TOC path
    - Custom highlight button:
      - Closes Select Text Menu and opens Highlight Colour Menu
    - Slight bug unless used in conjunction with my custom [Highlight Colour Icon Menu](../IconColourMenu/) patch

**Credits:**
- Full TOC Path: [edo-jan's patch on koreader/issues](https://github.com/koreader/koreader/issues/12480#issuecomment-2835548463)
- Icons in Select Text Menu: [erildt's branch of my highlight-menu-patch](https://github.com/erildt/koReader-highlight-menu-patch/blob/main/2-highlight-menu-modifications.lua)

**Considerations:**
- Can't get rid of the "Generate QR code" button here, but there should be a menu option somewhere.
- Vee's Version - Bug:
  - `selecting text > highlight > exiting without choosing a colour` causes the text selection will persist.
    - Tapping again will bring up the Select Text Menu. Tapping again will close the selection.
    - My custom [Highlight Colour Icon Menu](../IconColourMenu/) patch fixes this.
    - Other options:
      - Edit the custom_highlight_func to remove the functionality which closes the Select Text menu
      - Edit the source code file: `frontend/apps/reader/modules/readerhighlight.lua > ReaderHighlight:showHighlightColorDialog`
      - ... Just make sure you always apply a colour :(
      - ... Live with it... :(

---

# How to use

All editable settings are located under the following banner
```lua
---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR COLOURS
---------------------------------------------------------------------------------------------------
```

## My custom highlight function
```lua
function ReaderHighlight:saveHighlightFormatted(extend_to_sentence, hlStyle, hlColor)
```

<strong>
You do not need to modify anything in this function itself. This section explains the purpose of this function and how to use it.
<br>
<br>

You may use the variables in the `SETTINGS SECTION` - `local full_chapter_path` and `local seperator_symbol` to customise your use of this function.

You may also use this function when creating new buttons or modifying existing ones.
</strong>
<br>
<br>

This function allows for users to specify three arguments and two other variables:
- <strong>`local full_chapter_path`</strong>:
  - Located at the top of the file, under `SETTINGS SECTION`
  - Accepted values: `ON` or `OFF`
  - Some books have nested layers of Table of Contents
  <br>
    <img src="./Example Images/Multi TOC Depth Book Map.jpg" alt="Book map showing multiple TOC depths" style="width: 300px; max-width: 100%;"/>
    <br>
  - For a highlight at the marked location, the original highlight function will save the chapter value as `"Chapter 15: Vincent"` whereas this functionality will instead save it as `"PART TWO: The Book of Knowledge ▸ Chapter 15: Vincent"`
- <strong>`local seperator_symbol`</strong>:
  - Located at the top of the file, under `SETTINGS SECTION`
  - The text used to seperate TOC items
  - If `full_chapter_path = OFF`, this variable will be ignored
- `extend_to_sentence`: If `true`, when applied, the selected text will roll forwards and backwards to encapsulate punctuation and entire words.
- `hlStyle`: The drawer used for the annotation
  - From `koreader/frontend/apps/reader/modules/readerhighlight.lua > local highlight_style`:
    - **self.view.highlight.saved_drawer**
      - The selected default drawer style
    - "lighten"
    - "underscore"
    - "strikeout"
    - "invert"
- `hlColor`: The colour used for the annotation
  - From `koreader/frontend/apps/reader/modules/readerhighlight.lua > local ReaderHighlight:highlight_colors` (unless otherwise modified):
    - **self.view.highlight.saved_color**
      - The selected default highlight colour
    - red
    - orange
    - yellow<details><summary>...</summary>
      - green
      - olive
      - cyan
      - blue
      - purple
      - gray
      </details>


## Quick Highlight Colour Menu
<details><summary>See customistations for the <strong>Quick Highlight Colour Menu</strong> version here</summary>

All under `SETTINGS SECTION` at the top of the file
- <strong>`local show_name_or_icon`</strong>:
  - Accepted values:
     - `NAME`: Shows the display text for each colour
     - `ICON`: Shows the custom icon for each colour
- <strong>`local icon_folder`</strong>:
  - The sub-folder name within the icons folder where the icons are stored
  - Ignored if `show_name_or_icon = NAME`
  - ```
      koreader/
    ├─ icons/
    │  ├─ colours/ <-- this folder here
    │  │   ├─ red.png
    │  │   ├─ orange.png
    ...
- <strong>`local icon_name_select`</strong>:
  - Accepted values:
    - `NAME`: icons files are named the same as the colour display text value
      - ```
          koreader/
        ├─ icons/
        │  ├─ colours/
        │  │   ├─ Red.png
        │  │   ├─ Orange.png <-- default colours have the display text the same the ID, but capitalised
      - ```
          koreader/
        ├─ icons/
        │  ├─ colours/
        │  │   ├─ Spicy.png
        │  │   ├─ Weird.png <-- my colours have altered display texts
      ...
     - `ID`: icons files are named the same as the colour ID value
        - ```
            koreader/
          ├─ icons/
          │  ├─ colours/
          │  │   ├─ red.png
          │  │   ├─ orange.png <-- default colours have ID's in lowercase
  - Ignored if `show_name_or_icon = NAME`
  </details>

## Modifying the buttons (ignore for Quick Highlight Colour Menu)

``` lua
local function make_custom_buttons(self)
    local custom_buttons = {
        {id = "select"},
        {id = "highlight"},
        {id = "copy"},
        {id = "add_note"},
        {id = "wikipedia"},
        ...
        {id = "search"},
    }
    return custom_buttons
end
```

Each item (encased in curly braces `{ }`) represents a button.

- **Mandatory field**:
  <br>
  `id = ...`
- **Optional field**: 
  ```lua
  func = function(this, ...)
    ...
    return ...
  end
  ```
  If no `func` is specified, the code will look for the original function from the source code to use.

### Modifying existing functions
Simply copy paste buttons/items to the desired order. Buttons will appear in the order specified in the custom_buttons table.
> **Example**: Re-ordering
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "select"},
>        {id = "highlight"},
>        {id = "copy"},
>        ...
>        {id = "search"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "highlight"}, -- swapped
>        {id = "select"}, -- swapped
>        {id = "copy"},
>        ...
>        {id = "search"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> </tr>
> </table>

<br>

> **Example**: Deleting
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "select"}, -- delete
>        {id = "highlight"},
>        {id = "copy"},
>        ... -- delete all
>        {id = "search"}, -- delete
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> -- only two buttons now
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "highlight"},
>        {id = "copy"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> </tr>
> </table>

### Adding functions
Specify a function in the `func` field. The function should return a table with fields such as text, (icon), enabled callback (function), hold_callback (function), etc.

> **Example**: Customising the function for `highlight`
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "select"},
>        {id = "highlight"}, -- to mod
>        {id = "copy"},
>        ...
>        {id = "search"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "select"},
>        {
>         id = "highlight",
>         func = return {
>           -- What displays on the button's face
>           text = _("Highlight"),
>           
>           -- What triggers the button
>           enabled = this.hold_pos ~= nil,
>           
>           -- What the button does (on pressing/tapping)
>           callback = function()
>                        this:saveHighlightFormatted(
>                            true,
>                            "lighten",
>                            self.view.highlight.saved_color
>                        )
>                        this:onClose()
>                      end,
>          }
>        end
>        },
>        {id = "copy"},
>        ...
>        {id = "search"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> </tr>
> </table>

<br>

> **Example**: Adding a new button `underline`
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "select"},
>        {id = "highlight"},
>        -- add new button here
>        {id = "copy"},
>        ...
>        {id = "search"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local function make_custom_buttons(self)
>    local custom_buttons = {
>        {id = "select"},
>        {id = "highlight"},
>        {
>         id = "underline",
>         func = return {
>           text = _("Underline"),
>           enabled = this.hold_pos ~= nil,
>           callback = function()
>                        this:saveHighlightFormatted(
>                            true,
>                            "underscore",
>                            self.view.highlight.saved_color
>                        )
>                        this:onClose()
>                      end,
>          }
>        end
>        },
>        {id = "copy"},
>        ...
>        {id = "search"},
>    }
>    return custom_buttons
> end
> ```
> 
> </td>
> </tr>
> </table>

<details>
<summary><strong>Nerd stuff:</strong></summary>

- `function ReaderHighlight:saveHighlightFormatted(extend_to_sentence, hlStyle, hlColor)`
  - Works by (saving then) overwriting the saved drawer style/colour
  - Then calls the original highlight function
  - Restores the saved drawer style/colour
  - Modifies the existing chapter field if desired
    - Could add/edit more fields for the `item`

- `function ReaderHighlight:init(index)`
  - **koreader/frontend/apps/reader/modules/readerhighlight.lua** (line 55?)
  - Overwriting the ReaderHighlight:init function
  - Works by iterating through each specified button from `local function make_custom_buttons(self)` > `custom_buttons`
    - Makes a new ID/key by prefixing 3-digits to the front
      - Buttons get inserted by alphabetical order
      - Other buttons get assigned 2-digits to specify the order
      - By assigning 3-digits, we assure our buttons go first
    - If a function has been specified, simply insert a new button with that function
    - If no function has been specified, insert the new button if we can find the matching button id (scrub the prefix) in the original list
    - Lastly, overwrite the original `_highlight_buttons` table

- `ReaderHighlight._highlight_buttons`
  - **koreader/frontend/apps/reader/modules/readerhighlight.lua** (line 68?)
  - This patch overwrites the _highlight_buttons table in this module
  - This table includes the id with a two-digit prefix, and a table with the fields for a `Button`.
    ```lua
        BB.HIGHLIGHT_COLORS = {
            ...
            ["##_id"] = function(...) return { button_stuff } end,
            ...
        }
    ```
  - These items get displayed in a `ButtonDialog` containing a `ButtonTable` containing `Buttons`
    ```
      koreader/frontend/ui/widget
    ├─ buttondialog.lua
    │  ├─ ButtonDialog:init()
    │  │   ...
    │  │   self.buttontable = ButtonTable:new{...}
    │  │   ...
    │  │  end
    ├─ buttontable.lua
    │  ├─ ButtonTable:init()
    │  │   ...
    │  │   local button = Button:new{...}
    │  │   ...
    │  │  end
    ├─ button.lua
    │  ├─ local Button = InputContainer:extend{
    │  │   -- You can find available fields here
    │  │   ...
    │  │  }
    ```

- Vee's set-up
  - This was so annoying to set-up and it technically still has a bug >.<
  - When closing the Select Text Menu, the text selection also closes, so we need to restore the selection before programatically opening the Highlight Colour Menu
  - There were lots of issues with the Text Selection not showing on the screen correctly, but it's fixed now (don't ask me how...)
  - I can't say I understand all of this code, but hopefully the comments explain enough
  - Some notes:
    - UIManager:setDirty(...) refreshes the screen (helps with ghosting).
    - `this._color_chosen` was an attempt at setting a flag to clear the text selection - it works with my custom [Highlight Colour Icon Menu](../IconColourMenu/) patch, but not with anything else that I've tried.

- Quick Highlight Colours
  <br>
  I.e. `function make_custom_buttons_from_colours(self)`
  - This function iterates through all colours in the `ReaderHighlight.highlight_colors` table
    - Creates an ID using the colour's ID
    - Creates the func function
      - With the table including the following fields:
        - `enabled`
        - `callback` (the function run when button pressed/tapped)
        - `hold_callback` (the function run when button long pressed/held)
      - Then adds an `icon` or `text` field based on user selection
        - If `text` shows the colour's display text
        - If `icon` shows the custom icon in the specified folder with the specified naming convention

</details>