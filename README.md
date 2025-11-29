# KOReader-patches

Collection of custom patches I've made and modified for [KOReader](https://github.com/koreader/koreader), an ebook reader application supporting various formats on multiple platforms.

## Patches

### [2-detailed-header-footer.lua](/DetailedHeaderFooter/)

A comprehensive header and footer system with triple RGB progress bars for tracking reading progress at multiple levels.

<img src="/DetailedHeaderFooter/detailed-header-footer - Cropped.jpg" alt="Detailed Header Footer Example" width="50%">

<details>
<summary>Click to expand details</summary>
  
**Features:**
- Customizable header displaying book title, author, part, chapter, time, and battery
- Stable page and Normal/Screen page support
- Detailed footer with reading statistics (current page, total pages, percentage, pages remaining, time remaining)
- Three independently configurable progress bars for tracking Book, Part, and Chapter progress
- Progress bars and percentage calculated from screen pages, not stable! (More precision)
- Full RGB color support for progress bars
- Session duration tracking

<img src="detailed-header-footer.jpg" alt="Detailed Header Footer Example" width="50%">

**Credits:**
- Original header: [joshuacant/KOReader.patches](https://github.com/joshuacant/KOReader.patches)
- Original double progress bar: [gilgulgamesh/koreader-patches](https://github.com/gilgulgamesh/koreader-patches)
- RGB color support: [IntrovertedMage's gist](https://gist.github.com/IntrovertedMage/d759ff214f799cfb5e1f8c85daab6cae)
- Session duration: [KOReader issue #10231](https://github.com/koreader/koreader/issues/10231#issuecomment-1477138340)

**Considerations:**
- Might not work with all document types (tested on epub)
- If the book has no "Part", chapter row is repeated
- On every page turn, the progress bars flash
- If you want to change the number of lines, you'll need to dig into the code more (intermediate difficulty)
- Can't narrow the footer row vertical spacing
- If using publication pages, may not support non-integer page values
</details>

### [2-customise-highlight-colors.lua](/CustomHighlightColours/)

A patch to easily modify the colours available for highlighting

<img src="/CustomHighlightColours/custom-HL-cropped.jpg" alt="Custom Highlight Colour Example" width="25%">

<details>
<summary>Click to expand details</summary>
  
**Features:**
- Simple editability
- Ability to change display text
- Ability to change hex value
- Can have as many or as few colours as desired

**Two Versions Available**
- [Original values/names/colours](2-customise-highlight-colors-ORIGINAL.lua)
- <img src="custom-HL-orig.jpg" alt="Original Colours Example" width="50%">
- [Vee's values/names/colours](2-customise-highlight-colors-VEE-COLOURS.lua)
- <img src="custom-HL-Vee.jpg" alt="Vee's Colours Example" width="50%">

**Credits:**
- Original custom highlights: [u/ImSoRight's patch on Reddit](https://www.reddit.com/r/koreader/comments/1ibqhmc/comment/m9kcr4f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)

**Considerations:**
- Might not work on B/W eReaders
- Highlight labels/display text no longer has translation/localisation ability
- Must use hex codes, cannot use Blitbuffer grayscales
</details>

---

### Coming Soon/To be uploaded

- `2-TOC-with-chapter-lengths.lua` - Enhanced Table of Contents with chapter length information
- `2-underline-option-in-menu.lua` - Add underline option to the highlighting menu
- `2-browser-folder-coverlist.lua` - Folder browsing with alternate cover image grid view

## Installation

1. Connect your KOReader device to your computer
2. Navigate to the KOReader installation directory
3. Copy the desired `.lua` patch file to `koreader/patches/`
4. Restart KOReader
5. The patch will be automatically applied

* Only tested on Kobo Libra Color

## Contributing

Feel free to open issues for bugs or feature requests, or submit pull requests with improvements!

## License

These patches build upon KOReader's existing codebase. Please refer to the original [KOReader license](https://github.com/koreader/koreader/blob/master/COPYING) for usage terms.
