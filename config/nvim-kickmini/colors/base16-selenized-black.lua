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
	base00 = "#181818",
	base01 = "#252525",
	base02 = "#3b3b3b",
	base03 = "#777777",
	base04 = "#777777",
	base05 = "#b9b9b9",
	base06 = "#dedede",
	base07 = "#dedede",
	base08 = "#ed4a46",
	base09 = "#e67f43",
	base0A = "#dbb32d",
	base0B = "#70b433",
	base0C = "#3fc5b7",
	base0D = "#368aeb",
	base0E = "#a580e2",
	base0F = "#eb6eb7",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-selenized-black"
end
