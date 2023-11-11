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
	base00 = "#ffffff",
	base01 = "#e1e1e2",
	base02 = "#c4c3c5",
	base03 = "#a7a5a8",
	base04 = "#89878b",
	base05 = "#6c696e",
	base06 = "#4f4b51",
	base07 = "#322d34",
	base08 = "#d8137f",
	base09 = "#d65407",
	base0A = "#dc8a0e",
	base0B = "#17ad98",
	base0C = "#149bda",
	base0D = "#775dff",
	base0E = "#aa17e6",
	base0F = "#e013d0",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-unikitty-light"
end
