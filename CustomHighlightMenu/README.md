## [2-custom-highlight-menu.lua](2-custom-highlight-menu.lua)

A patch to modify the select text menu

  
**Features:**
- Ability to rearrange menu buttons in select text menu
- Ability to add custom buttons to select text menu
  - Custom highlight function for specification of highlight style and colour
  - Functionality can be customised from readerhighlight.lua
- Toggle whether chapter gets saved as lowest TOC level or full path
  - e.g. Part 1 ▸ Chapter 1

**My Modifications**
- My menu
  - <img src="custom-HL-menu.jpg" alt="My menu" width="50%">
- My custom highlight button
  - <img src="Highlight_Button.gif" alt="Vee's Custom Highlight button" width="25%">
  - Immediately opens the select colour menu
- My custom underline button
  - <img src="Underline_Button.gif" alt="Vee's Custom Underline button" width="25%">
  - Style set as "underscore"
  - Rolling disabled for this button
- Full Table of Contents path for chapter field for highlights
  - <img src="Full_TOC_path.png" alt="Full TOC Path" width="50%">

**Credits:**
- My original highlight menu patch: [here](https://github.com/VeeBui/koReader-highlight-menu-patch/blob/main/2-highlight-menu-modifications.lua)
- Full TOC Path: [edo-jan's patch on koreader/issues](https://github.com/koreader/koreader/issues/12480#issuecomment-2835548463)

**Considerations:**
- Can't get rid of the "Generate QR code" button
- If you're not using my 2-icon-name-colour-menu.lua, if you tap out of the highlight colour menu without choosing a colour, the text will remain selected and you'll have to tap out of the Select-Text menu.
  - You can either edit the custom_highlight_func to remove the functionality which closes the Select-Text menu, modify the source code for frontend/apps/reader/modules/readerhighlight.lua > ReaderHighlight:showHighlightColorDialog, or install my 2-icon-name-color-menua.lua patch
    - or... just make sure you always apply a colour/live with having to tap twice if  you didn't actually want to highlight.

---

