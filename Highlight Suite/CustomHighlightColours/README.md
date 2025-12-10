## [2-customise-highlight-colors.lua](./Patches/2-customise-highlight-colors.lua)

A patch to easily modify the colours available for highlighting.

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
1. [Modify set from the KOReader stock colours/display text](./Patches/2-customise-highlight-colors.lua)
2. [**Vee's version**](./Patches/Vee's%20Colours/2-customise-highlight-colors.lua)

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

> **Example**: - Rearranging colours
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"cyan", "Cyan", "#00FFEE"},
>     {"blue", "Blue", "#56A1FC"},
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"blue", "Blue", "#56A1FC"}, -- swapped
>     {"cyan", "Cyan", "#00FFEE"}, -- swapped
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> </tr>
> </table>
>
> Add this row to the desired position in the table.

<br>

> **Example**: - adding "pink"
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"blue", "Blue", "#56A1FC"},
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"blue", "Blue", "#56A1FC"},
>     {"pink", "Pink", "#FF66CC"},  -- Here!
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> </tr>
> </table>

<br>

> **Example**: - Deleting colours
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"cyan", "Cyan", "#00FFEE"},
>     {"blue", "Blue", "#56A1FC"}, -- Delete this
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"cyan", "Cyan", "#00FFEE"},
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> </tr>
> </table>

<br>

> **Example**: - Modifying exisitng colours
> 
> <table>
> <tr>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"cyan", "Cyan", "#00FFEE"}, -- Mod hex code
>     {"blue", "Blue", "#56A1FC"}, -- Mod display text
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> <td align="center" valign="middle" style="font-size: 2em;">→</td>
> <td>
> 
> ```lua
> local custom_colors = {
>     ...
>     {"cyan", "Cyan", "#A9CCC9"}, -- New hex code
>     {"blue", "Sad", "#56A1FC"}, -- New display text
>     {"purple", "Purple", "#9500FF"},
>     ...
> }
> ```
> 
> </td>
> </tr>
> </table>

<br>


<details>
<summary><strong>Nerd stuff:</strong></summary>

- `ReaderHighlight.highlight_colors`
  - **koreader/frontend/apps/reader/modules/readerhighlight.lua** (line 31?)
  - This patch will overwrite the highlight_colors table in this module
  - This table only includes the display text (localised) and the colour id
    ```lua
        highlight_colors = {
            ...
            {_("Display text"), "id"},
            ...
        }
    ```
- `BlitBuffer.HIGHLIGHT_COLORS`
    - **koreader-base/ffi/blitbuffer.lua** (line 2625)
  - This patch will overwrite the HIGHLIGHT_COLORS table in this module
  - This table only includes the colour id and the hex code
    ```lua
        BB.HIGHLIGHT_COLORS = {
            ...
            ["id"] = "hexcode",
            ...
        }
    ```
  - It is usually called by with the function `BB.colorFromName` where BB is how BlitBuffer is referenced in the file
    - i.e. `BB = require("ffi/blitbuffer")`

</details>
