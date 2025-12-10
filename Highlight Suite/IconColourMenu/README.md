## [**Icon Colour Menu**](./Patches/2-icon-name-colour-menu.lua)

A patch to change the Select Highlight Colour Menu from a list of radio buttons with text and coloured backgroud, to a grid of custom icons.

<div style="display: flex; align-items: center; gap: 20px;">
  <img src="../CustomHighlightColours/Example Images/Post-CustomHighlightColours.jpg" alt="Pre Icon Colour Menu Example" style="width: 400px; max-width: 40%;"/>
  <span style="font-size: 2em;">→</span>
  <img src="./Example Images/Post-IconColourMenu-Lighten.jpg" alt="Post Row/Column Select Text Menu Example" style="width: 400px; max-width: 40%;"/>
</div>
<br>

> **Features:**
> - Set icon file names to match the colour ID or the colour display text
>     - [Pre-made icons](./Pre-made%20Icons/), hand-drawn by myself, available
>         - Note, these match the hex values from my [Custom Highlight Colours](../CustomHighlightColours/Patches/Vee's%20Colours/) patch
>         <br>
> 
>             <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(30px, 80px)); gap: 5px; padding: 0px;">
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/red.png" alt="Red" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">red.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/orange.png" alt="Orange" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">orange.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/yellow.png" alt="Yellow" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">yellow.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/olive.png" alt="Olive" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">olive.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/green.png" alt="Green" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">green.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/turquoise.png" alt="Turquoise" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">turquoise.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/cyan.png" alt="Cyan" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">cyan.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/blue.png" alt="Blue" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">blue.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/indigo.png" alt="Indigo" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">indigo.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/purple.png" alt="Purple" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">purple.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/pink.png" alt="Pink" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">pink.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Basic Icons/grey.png" alt="Grey" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">grey.png</div>
>             </div>
>             </div>
>             <br>
> 
>             <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(30px, 80px)); gap: 5px; padding: 0px;">
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Spicy.png" alt="Spicy" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Spicy.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Weird.png" alt="Weird" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Weird.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Interesting.png" alt="Interesting" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Interesting.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Character.png" alt="Character" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Character.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Hate.png" alt="Hate" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Hate.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Funny.png" alt="Funny" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Funny.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Artistic.png" alt="Artistic" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Artistic.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Deep.png" alt="Deep" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Deep.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Special.png" alt="Special" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Special.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/General.png" alt="General" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">General.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Love.png" alt="Love" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Love.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Lighten/Grey.png" alt="Grey" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Grey.png</div>
>             </div>
>             </div>
> <br>
> 
> - Ability to use subset of colours while underlining
>     - Can change display text
>     - Can utilise different icons for underlining if `local icon_name_select = NAME`
>         - <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(30px, 80px)); gap: 5px; padding: 0px;">
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore/Characters.png" alt="Characters" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Characters.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore/Deities.png" alt="Deities" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Deities.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore/Animals.png" alt="Animals" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Animals.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore/References.png" alt="References" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">References.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore/Mentions.png" alt="Mentions" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Mentions.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore/Other.png" alt="Other" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Other.png</div>
>             </div>
>             </div>
>         <br>
> 
>         - With outlines for some darkmode applications:
>         - <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(30px, 80px)); gap: 5px; padding: 0px;">
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore%20(outlined)/Characters.png" alt="Characters" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Characters.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore%20(outlined)/Deities.png" alt="Deities" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Deities.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore%20(outlined)/Animals.png" alt="Animals" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Animals.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore%20(outlined)/References.png" alt="References" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">References.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore%20(outlined)/Mentions.png" alt="Mentions" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Mentions.png</div>
>             </div>
>             <div style="text-align: center;">
>                 <img src="Pre-made Icons/Vee's Hand-drawn Icons/Underscore%20(outlined)/Other.png" alt="Other" style="width: 100%; height: auto;">
>                 <div style="font-size: 10px; margin-top: 0px;">Other.png</div>
>             </div>
>             </div>
>         <br>
> 
> - Full customisation available:
>     - Number of rows desired
>     - Icon naming convention:
>         - Declare your subfolder in /icons/
>         - Choose to name icon files by colour ID or colour display text
>     - Icon appearance:
>         - Width
>         - Bordersize
>     - Show colour's display text over the icon:
>         - ON/OFF
>         - Nominal text size - minimum text size
>         - Vertical position + offset
        
<br>

---

**Two Versions Available**
1. [Simple version](./Patches/2-icon-name-colour-menu.lua)
    - Create the sub-folder `koreader/icons/colours`
    - Place in icons using colour IDs for the file name
        - E.g. red.png
    - Display text will show in the middle of the icon
        - With all text at font size 10px
    - No subset for underlines
2. [Vee's version](./Patches/Vee's%20Set-up/2-icon-name-colour-menu.lua)
    - Create the sub-folder `koreader/icons/colours`
    - Place in icons using colour display text for the file name
        - E.g. Red.png or Spicy.png
    - Display text will show 30px below the bottom of the icon
        - Long text will shrink in font size to fit icon
    - Vee's subset for underlines
        - I use underlines for names, so they have quite different meanings to me than "lightens"

**Inspiration**
  - Erildt's branch of my old highlight-menu-patch: [u/Erildt on Reddit](https://www.reddit.com/r/koreader/comments/1l5ooyx/quick_highlight_color_menu_with_color_icons/)

**Considerations:**
- Icons should be square - math not configured otherwise.
- I run a programatic screen refresh a lot. Sometimes it still doesn't fully clear the ghosting, but it works most of the time.
- No support currently if you want to add completely new hex codes for underline subset, 

---

# How to use

All editable settings are located under the following banner
```lua
---------------------------------------------------------------------------------------------------
-- ⚙️ SETTINGS SECTION - EDIT THESE TO CUSTOMISE YOUR COLOURS
---------------------------------------------------------------------------------------------------
```

- `local rows`
  - Number of rows desired in final grid.
- `local icon_folder`
  - The subfolder name in `koreader/icons/`.
  - ```
      koreader/
    ├─ icons/
    │  ├─ colours/ <-- this folder here
    │  │   ├─ red.png
    │  │   ├─ orange.png
    ...
- `local icon_name_select`
  - Accepted values:
    - `NAME`: icons files are named the same as the colour display text value.
        <details>

        ```
            koreader/
            ├─ icons/
            │  ├─ colours/
            │  │   ├─ Red.png
            │  │   ├─ Orange.png <-- default colours have the display text the same the ID, but capitalised

        ```
            koreader/
            ├─ icons/
            │  ├─ colours/
            │  │   ├─ Spicy.png
            │  │   ├─ Weird.png <-- my colours have altered display texts

        </details>
     - `ID`: icons files are named the same as the colour ID value.
        <details>

        ```
            koreader/
          ├─ icons/
          │  ├─ colours/
          │  │   ├─ red.png
          │  │   ├─ orange.png <-- default colours have ID's in lowercase

        </details>
<br>

- `local icon_width`
    - The width in px for each icon. This assumes all icons are square and will all end up the same size.
- `local bordersize`
    - The thickness of the borders of the menu, in px.
<br>

---

- `local show_color_Name`
  - Accepted values:
    - `true`: Display text for colours will show on top of icons.
    - `false`: Only the icons will show. No display text.
- The following items are ignored if `show_color_Name = false`
>   - `local text_size`
>       - The nominal font size for the display text.
>   - `local min_text_size`
>       - If the nominal font size causes the text to be wider than the icon, the code will shrink the font size until the text fits, or it reaches this value.
>       - Set this to the same as `text_size` if you want all text to be the same font size regardless of spillage.
>   - `local text_position`
>       - Accepted values:
>           - `TOP`: Pushes the text to the top of the icon.
>               - Top of text coincides with top of icon.
>           - `MID`: Sets the text vertically in the middle of the icon.
>           - `BOT`: Pushes the text to the bottom of the icon.
>               - Bottom of text coincides with bottom of icon.
>   - `local text_offset`
>       - Pushes the text the specified amount of pixels down
>           - Negatives values push text up

<br>

---

- `local underline_colors`
    ```lua
    local underline_colors = {=
        -- {"Name", "id"}
        {"Characters", "purple"},
        {"Deities", "red"},
        ...
    }
    ```
    - ID values must already exist in highlight_colors
    - Refer to [Custom Highlight Colours > How to use](../CustomHighlightColours/README.md) for help with customisations

<br>

---

<details>
<summary><strong>Nerd stuff:</strong></summary>

OMG the math for the text_position + text_offset took me way longer than it should have!

I basically ended up having to create my own "button" which is just an `InputContainer` containing a `FrameContainer` containing everything that I want to show on the face of the button.

(Then add boring stuff like `ges_events` and `onTap` to each button and `ges_events` and `onTapClose` to the dialog box itself.)

If no text is displayed, the button is super easy to construct :)

    
    button
    ├─ icon_widget (IconWidget)
    

If text is diplayed...

    
    button
    ├─ overlap_group (OverlapGroup)
    │  ├─ text_container (VerticalGroup)
    │  │   ├─ new_text_widget (CentreContainer)
    │  │   │   ├─ (VerticalSpan)
    │  │   │   ├─ text_widget (TextWidget)
    │  │   │   ├─ (VerticalSpan)
    │  │   ├─ (VerticalSpan) -- Either above, below, or not needed
    │  ├─ icon_container (VerticalGroup)
    │  │   ├─ icon_widget (IconWidget)
    │  │   ├─ (VerticalSpan) -- Either above, below, or not needed

<details><summary>Diagram</summary>

<img src="./Math notes/4-diagram.png" alt="Diagram of layout" style="width: 1000px; max-width: 100%;">

</details>

<br>

---

<br>


    │  │   ├─ new_text_widget (CentreContainer)
    │  │   │   ├─ (VerticalSpan)
    │  │   │   ├─ text_widget (TextWidget)
    │  │   │   ├─ (VerticalSpan)

Basically, if the text shrinks due to spillage, the height will also shrink. So all `text_widget`'s need to be encased to ensure that the centre of all text displays will remain aligned.

```
$$
VerticalSpan = 
$$
```
    


</details>