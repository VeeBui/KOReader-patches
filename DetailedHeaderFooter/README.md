# KOReader-patches

Collection of custom patches I've made and modified for [KOReader](https://github.com/koreader/koreader), an ebook reader application supporting various formats on multiple platforms.

## Patches

### [2-detailed-header-footer.lua](2-detailed-header-footer.lua)

A comprehensive header and footer system with triple RGB progress bars for tracking reading progress at multiple levels.

  
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

---

