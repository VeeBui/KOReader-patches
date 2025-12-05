# *KOReader-Patches* - Highlight Suite

A collection of patches to customise and beautify the highlighting/colour selection options.

All patches can be used individually or in conjuction.


<img src="./Highlight Suite Comparison.gif" alt="Full Highlight Suite Example Gif" style="width: 750px; max-width: 100%;"/>

## Available Patches

> [**Custom Highlight Colours**](./CustomHighlightColours/)
>
> Easily modify the available *highlight colours*
> <div style="display: flex; align-items: center; gap: 20px;">
>   <img src="CustomHighlightColours/Example Images/Pre-CustomHighlightColours.jpg" alt="Pre Post Custom Highlight Colours Example" style="width: 200px; max-width: 40%;"/>
>   <span style="font-size: 2em;">→</span>
>   <img src="CustomHighlightColours/Example Images/Post-CustomHighlightColours.jpg" alt="Post Custom Highlight Colours Example" style="width: 200px; max-width: 40%;"/>
> </div>
> <br>
> <details>
> <summary><strong>Features</strong></summary>
> 
> - Ability to modify:
>   - The amount of colours available
>   - The hex codes used for each colour
>   - The display text/name for each colour
> </details>
>
> <br>
>
> **Credits**
> - Original custom highlights: [u/ImSoRight's patch on Reddit](https://www.reddit.com/r/koreader/comments/1ibqhmc/comment/m9kcr4f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) or [on GitHub](https://github.com/ImSoRight/KOReader.patches/blob/main/2-customize-highlight-colors.lua)


> [**Row/Column Select Text Menu**](./RowColSelectTextMenu/)
>
> Modify the grid layout/number of rows or columns for the *Select Text Menu* without needing to edit any source code files
> <div style="display: flex; align-items: center; gap: 20px;">
>   <img src="CustomSelectTextMenu\Example Images/Pre-CustomSelectTextMenu.jpg" alt="Pre Row/Column Select Text Menu" style="width: 200px; max-width: 40%;"/>
>   <span style="font-size: 2em;">→</span>
>   <img src="RowColSelectTextMenu/Example Images/3-Row-HL-Menu.jpg" alt="Post Row/Column Select Text Menu Example" style="width: 200px; max-width: 40%;"/>
> </div>
> <br>
> <details>
> <summary><strong>Features</strong></summary>
> 
> - Choose between specifying the number of rows or of columns
> - Ability to turn menu grid into:
>   - A single row
>   - A single column
>   - Any sized grid desired
> </details>
>
> <br>
>
> **Requested by**
>   - [u/TheSpicyNovella on Reddit](https://www.reddit.com/r/koreader/comments/1pajkt7/editing_koreader_highlight_menu_columns_on/)


> [**Custom Select Text Menu**](./CustomSelectTextMenu/)
>
> Modify the buttons/functions on the *Select Text Menu*
> <div style="display: flex; align-items: center; gap: 20px;">
>   <img src="CustomSelectTextMenu\Example Images/Pre-CustomSelectTextMenu.jpg" alt="Pre Custom Select Text Menu" style="width: 200px; max-width: 40%;"/>
>   <span style="font-size: 2em;">→</span>
>   <img src="CustomSelectTextMenu\Example Images/Post-CustomSelectTextMenu.jpg" alt="Post Custom Select Text Menu Example" style="width: 200px; max-width: 40%;"/>
> </div>
> <br>
> <details>
> <summary><strong>Features</strong></summary>
> 
> - Easily rearrange/remove buttons
> - Add custom functions to any button
> - Add custom buttons
> </details>
>
> <br>
>
> **Credits**
>   - Full TOC Path: [edo-jan's patch on the KOReader GitHub](https://github.com/koreader/koreader/issues/12480#issuecomment-2835548463)


> [**Icon Colour Menu**](./IconColourMenu/)
>
> Change the colour selection *highlight colour menu* from Text+Radio Buttons to your custom icons.
> 
> Simply add the svg or png files with the correct names to your desired sub-folder in /Icons
> <div style="display: flex; align-items: center; gap: 20px;">
>   <img src="CustomHighlightColours/Example Images/Post-CustomHighlightColours.jpg" alt="Pre Icon Colour Menu" style="width: 200px; max-width: 40%;"/>
>   <span style="font-size: 2em;">→</span>
>   <img src="IconColourMenu/Example Images/Post-IconColourMenu-Lighten.jpg" alt="Post Icon Colour Menu Example" style="width: 200px; max-width: 40%;"/>
> </div>
> <br>
> <details>
> <summary><strong>Features</strong></summary>
> 
> - Choose between having icon files named by the colour's id or the colour's display text
>   - Pre-made icons available
> - Full customisation available. Choose:
>   - Number of rows desired
>   - Icon's:
>      - Size
>      - Border-size
> - Further customisations:
>   - Colour's display text over the icon:
>      - ON/OFF
>      - Text size
>      - Position (Top/middle/bottom)
>      - Vertical offset
>   - Ability to utilise subset of colours when underlining
>      - Choose subset of colours
>      - Choose new display text for colours
>      - Icons will change in case of new display text
> </details>
>
> <br>
>
> **Inspiration**
>   - [u/Erildt on Reddit](https://www.reddit.com/r/koreader/comments/1l5ooyx/quick_highlight_color_menu_with_color_icons/)