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
	base00 = "#f1ecf1",
	base01 = "#e0dee0",
	base02 = "#d8d5d5",
	base03 = "#b5b4b6",
	base04 = "#979598",
	base05 = "#515151",
	base06 = "#474545",
	base07 = "#2d2c2c",
	base08 = "#fe3e31",
	base09 = "#fe6d08",
	base0A = "#f7e203",
	base0B = "#47f74c",
	base0C = "#0f9cfd",
	base0D = "#2931df",
	base0E = "#611fce",
	base0F = "#b16f40",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-fruit-soda"
end
