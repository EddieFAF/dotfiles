local use_cterm, palette

--base00 - Default Background
--base01 - Lighter Background (Used for status bars, line number and folding marks)
--base02 - Selection Background
--base03 - Comments, Invisibles, Line Highlighting
--base04 - Dark Foreground (Used for status bars)
--base05 - Default Foreground, Caret, Delimiters, Operators
--base06 - Light Foreground (Not often used)
--base07 - Light Background (Not often used)
--base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
--base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
--base0A - Classes, Markup Bold, Search Text Background
--base0B - Strings, Inherited Class, Markup Code, Diff Inserted
--base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
--base0D - Functions, Methods, Attribute IDs, Headings
--base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
--base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

palette = {
	base00 = "#1C1E26",
	base01 = "#232530",
	base02 = "#2E303E",
	base03 = "#6F6F70",
	base04 = "#9DA0A2",
	base05 = "#CBCED0",
	base06 = "#DCDFE4",
	base07 = "#E3E6EE",
	base08 = "#E95678",
	base09 = "#FAB795",
	base0A = "#FAC29A",
	base0B = "#29D398",
	base0C = "#59E1E3",
	base0D = "#26BBD9",
	base0E = "#EE64AC",
	base0F = "#F09383",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-horizon-terminal-dark"
end
