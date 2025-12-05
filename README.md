# KOReader-Patches

Collection of custom patches I've made or modified for [KOReader](https://github.com/koreader/koreader), an ebook reader application supporting various formats on multiple platforms.

## Available Patches

### [Highlight Suite](./Highlight%20Suite/)
A collection of patches to customise and beautify the highlighting/colour selection options.

<div style="display: flex; align-items: center; gap: 20px;">
  <img src="./Highlight Suite/CustomHighlightColours/Example Images/gif/Pre-CustomHighlightColours.gif" alt="Pre Highlight Suite Gif" style="width: 150px; max-width: 40%;"/>
  <span style="font-size: 2em;">→</span>
  <img src="./Highlight Suite/IconColourMenu/Example Images/gif/Post-IconColourMenu.gif" alt="Full Highlight Suite Example Gif" style="width: 150px; max-width: 40%;"/>
</div>

<br>

<details>
<summary><strong>Included Patches</strong></summary>

> - [**Custom Highlight Colours**](./Highlight%20Suite/CustomHighlightColours/)
>   - <strong>Easily modify the available *highlight colours*</strong>
>     - Amount
>     - Hex codes
>     - Names
>   - **Credits**
>     - Original custom highlights: [u/ImSoRight's patch on Reddit](https://www.reddit.com/r/koreader/comments/1ibqhmc/comment/m9kcr4f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) or [on GitHub](https://github.com/ImSoRight/KOReader.patches/blob/main/2-customize-highlight-colors.lua)


> - [**Row/Column Select Text Menu**](./Highlight%20Suite/RowColSelectTextMenu/)
>   - <strong>Modify the grid layout for the *Select Text Menu*</strong>
>     - Turn into a single row
>     - Turn into a single column
>     - Turn into any sized grid
>     - No need to change any source code files
>   - **Requested by**
>     - [u/TheSpicyNovella on Reddit](https://www.reddit.com/r/koreader/comments/1pajkt7/editing_koreader_highlight_menu_columns_on/)

> - [**Custom Select Text Menu**](./Highlight%20Suite/CustomSelectTextMenu/)
>   - <strong>Modify the buttons/functions on the *Select Text Menu*</strong>
>     - Rearrange buttons
>     - Modify button functions
>     - Add custom buttons
>   - **Credits**
>     - Full TOC Path: [edo-jan's patch on the KOReader GitHub](https://github.com/koreader/koreader/issues/12480#issuecomment-2835548463)

> - [**Icon Colour Menu**](./Highlight%20Suite/IconColourMenu/)
>   - <strong>Change the colour selection *highlight colour menu* from Text+Radio Buttons to Icons</strong>
>     - Place icon files into sub-folder of choice in icons folder
>     - Name icon files by colour's id or colour's display text
>     - Further customisation available:
>       - Number of rows
>       - Icon size/border-size
>       - Show colour's display text ON/OFF
>         - Display text size/position/off-set
>       - Change colours/icons/display text for *underlines*
>      - Pre-made icons available
>   - **Inspiration**
>     - [u/Erildt on Reddit](https://www.reddit.com/r/koreader/comments/1l5ooyx/quick_highlight_color_menu_with_color_icons/)

</details>

---

### [2-detailed-header-footer.lua](/DetailedHeaderFooter/)

A comprehensive header and footer system with triple RGB progress bars for tracking reading progress at multiple levels.

Soon to be re-done.

<img src="./DetailedHeaderFooter/detailed-header-footer - Cropped.jpg" alt="Detailed Header Footer Example" width="50%">

<br>

<details>
<summary>Click to expand details</summary>
  
> **Features:**
> - Customizable header displaying book title, author, part, chapter, time, and battery
> - Stable page and Normal/Screen page support
> - Detailed footer with reading statistics (current page, total pages, percentage, pages remaining, time remaining)
> - Three independently configurable progress bars for tracking Book, Part, and Chapter progress
> - Progress bars and percentage calculated from screen pages, not stable! (More precision)
> - Full RGB color support for progress bars
> - Session duration tracking

> **Credits:**
> - Original header: [joshuacant/KOReader.patches](https://github.com/joshuacant/KOReader.patches)
> - Original double progress bar: [gilgulgamesh/koreader-patches](https://github.com/gilgulgamesh/koreader-patches)
> - RGB color support: [IntrovertedMage's gist](https://gist.github.com/IntrovertedMage/d759ff214f799cfb5e1f8c85daab6cae)
> - Session duration: [KOReader issue #10231](https://github.com/koreader/koreader/issues/10231#issuecomment-1477138340)

> **Considerations:**
> - Might not work with all document types (tested on epub)
> - If the book has no "Part", chapter row is repeated
> - On every page turn, the progress bars flash
> - If you want to change the number of lines, you'll need to dig into the code more (intermediate difficulty)
> - Can't narrow the footer row vertical spacing
> - If using publication pages, may not support non-integer page values
</details>

---

### Coming Soon/To be uploaded
- Custom Header/Footer Suite - Redo of 2-detail-header-footer.lua
- `2-TOC-with-chapter-lengths.lua` - Enhanced Table of Contents with chapter length information
- `2-browser-folder-coverlist.lua` - Folder browsing with alternate cover image grid view

## Installation
Please follow the instructions [here](https://koreader.rocks/user_guide/#L2-userpatches)

## Contributing

Feel free to open issues for bugs or feature requests, or submit pull requests with improvements!

## License
These patches build upon KOReader's existing codebase. Please refer to the original [KOReader license](https://github.com/koreader/koreader/blob/master/COPYING) for usage terms.

If you use any of these patches to make your own, please credit myself and anyone I have credited in making that patch.