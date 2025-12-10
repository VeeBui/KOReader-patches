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
>| | | | | |
>|:---:|:---:|:---:|:---:|:---:|
>| <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/red.png" width="80"><br>red.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/orange.png" width="80"><br>orange.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/yellow.png" width="80"><br>yellow.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/olive.png" width="80"><br>olive.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/green.png" width="80"><br>green.png |
>| <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/turquoise.png" width="80"><br>turquoise.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/cyan.png" width="80"><br>cyan.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/blue.png" width="80"><br>blue.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/indigo.png" width="80"><br>indigo.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/purple.png" width="80"><br>purple.png |
>| <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/pink.png" width="80"><br>pink.png | <img src="Pre-made%20Icons/Vee's%20Basic%20Icons/grey.png" width="80"><br>grey.png | | | |
> 
> <br>
> 
>| | | | | |
>|:---:|:---:|:---:|:---:|:---:|
>| <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Spicy.png" width="80"><br>Spicy.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Weird.png" width="80"><br>Weird.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Interesting.png" width="80"><br>Interesting.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Character.png" width="80"><br>Character.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Hate.png" width="80"><br>Hate.png |
>| <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Funny.png" width="80"><br>Funny.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Artistic.png" width="80"><br>Artistic.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Deep.png" width="80"><br>Deep.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Special.png" width="80"><br>Special.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/General.png" width="80"><br>General.png |
>| <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Love.png" width="80"><br>Love.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Lighten/Grey.png" width="80"><br>Grey.png | | | |
> <br>
> 
> - Ability to use subset of colours while underlining
>     - Can change display text
>     - Can utilise different icons for underlining if `local icon_name_select = NAME`
> 
>       | | | |
>       |:---:|:---:|:---:|
>       | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore/Characters.png" width="80"><br>Characters.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore/Deities.png" width="80"><br>Deities.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore/Animals.png" width="80"><br>Animals.png |
>       | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore/References.png" width="80"><br>References.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore/Mentions.png" width="80"><br>Mentions.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore/Other.png" width="80"><br>Other.png | | | |
> 
>   <br>
> 
>   - With outlines for some darkmode applications:
> 
>       | | | |
>       |:---:|:---:|:---:|
>       | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore%20(outlined)/Characters.png" width="80"><br>Characters.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore%20(outlined)/Deities.png" width="80"><br>Deities.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore%20(outlined)/Animals.png" width="80"><br>Animals.png |
>       | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore%20(outlined)/References.png" width="80"><br>References.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore%20(outlined)/Mentions.png" width="80"><br>Mentions.png | <img src="Pre-made%20Icons/Vee's%20Hand-drawn%20Icons/Underscore%20(outlined)/Other.png" width="80"><br>Other.png | | | |
> 
> 
> <br>
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

<img src="./Math notes/4-diagram.png" alt="Diagram of layout" style="width: 500px; max-width: 100%;">

</details>

<br>

---

<br>


    │  │   ├─ new_text_widget (CentreContainer)
    │  │   │   ├─ (VerticalSpan)
    │  │   │   ├─ text_widget (TextWidget)
    │  │   │   ├─ (VerticalSpan)

Basically, if the text shrinks due to spillage, the height will also shrink. So all `text_widget`'s need to be encased to ensure that the centre of all text displays will remain aligned.

$VerticalSpan = 0.5\times(original\_text.height - new\_text.height)$


---

<br>

    │  ├─ text_container (VerticalGroup)
    │  ├─ icon_container (VerticalGroup)

Setting the inital `new_text_widget` y-position, before taking into account any offsets, was surprisingly satisfying.


$required\_span = \alpha \times (icon.height - original\_text.height)$

Where $\alpha$ is `0, 0.5, 1` respectively for `TOP, MID, BOT`.

<br>

---

<br>

To deal with the offsets, the easiest way was to:

1) Seperately consider the cases where the text was:
    - Higher than the top of the icon (Case 1)

        $required\_span + offset < 0$

    - Lower than the bottom of the icon (Case 2)

        $required\_span + offset > available\_space$
        <br>
        where
        <br>
        $available\_space = icon.height - original\_text.height$

    - Between these two/Fully within the icon space (Case 3)
2) Seperately position the `new_text_widget` and `icon_widget` into new `VerticalGroup`s with the same heights.


$Case_1: VerticalGroup.height = icon.height - required\_span - offset$





</details>