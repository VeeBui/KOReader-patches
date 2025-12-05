## [2-customise-highlight-colors.lua](./Patches/2-customise-highlight-colors.lua)

A patch to easily modify the colours available for highlighting

<div style="display: flex; align-items: center; gap: 20px;">
  <img src="./Example Images/Pre-CustomHighlightColours.jpg" alt="Pre Post Custom Highlight Colours Example" style="width: 400px; max-width: 40%;"/>
  <span style="font-size: 2em;">→</span>
  <img src="./Example Images/Post-CustomHighlightColours.jpg" alt="Post Custom Highlight Colours Example" style="width: 400px; max-width: 40%;"/>
</div>
<br>


> **Features:**
> - Ability to modify:
>   - The amount of colours available
>   - The hex codes used for each colour
>   - The display text/name for each colour

<br>

---

**Two Versions Available**
- [Modify set from the KOReader stock colours/display text](./Patches/2-customise-highlight-colors.lua)
- [See my colours/display text values](./Patches/Vee's%20Colours/2-customise-highlight-colors.lua)

**Credits:**
- Original custom highlights: [u/ImSoRight's patch on Reddit](https://www.reddit.com/r/koreader/comments/1ibqhmc/comment/m9kcr4f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) or [on GitHub](https://github.com/ImSoRight/KOReader.patches/blob/main/2-customize-highlight-colors.lua)

**Considerations:**
- Might not work on B/W eReaders
- Must use hex codes, cannot use Blitbuffer grayscales

---

# How to use

All editable settings are located under the following banner found on `lines 24-26`
```lua
---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR COLOURS
---------------------------------------------------------------------------------------------------
```

Each colour entry follows the following **format**:
```lua
{"id", "Display text", "#HEXCODE"}
```

<br>

> **Fields**:
> - **id** → internal reference name  
> - **Display text** → text displayed on menu 
> - **Hex code** → the colour value  

<br>

> **Example**: - adding "pink"
> ```lua
> local custom_colors = {
>     ...
>     {"blue", "Blue", "#56A1FC"},
>     {"pink", "Pink", "#FF66CC"},  -- New colour added here!
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
>
> Add this row to the desired position in the table.

**Notes**:
- The order of colours in the table will match those in the colour selection menu
  - Copy-paste entire rows/lines to re-arrange
  - Delete row/line to remove a colour
  - Modify any field in a row to edit an existing colour
- `id`'s must be unique (but can have any value!)
- Syntax
  - Do not remove the outside curly braces `{ ... }` of the `custom_colors block`
  - The last row can include the trailing "," or can exclude it
  - All fields should be specified in quotes `' ... '` or double quotes `" ... "`
  - Hex codes must begin with a hash `#`

<details>
<summary><strong>Nerd stuff:</strong></summary>

- ReaderHighlight.highlight_colors
  - **koreader/frontend/apps/reader/modules/readerhighlight.lua**
  - This patch will overwrite the highlight_colors table in this module
  - This table only includes the display text (localised) and the colour id
    ```lua
        highlight_colors = {
            ...
            {_("Display text"), "id"},
            ...
        }
    ```
- BlitBuffer.HIGHLIGHT_COLORS
    - *

</details>
