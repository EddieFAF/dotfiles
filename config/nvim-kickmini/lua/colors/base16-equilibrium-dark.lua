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
	base00 = "#0c1118",
	base01 = "#181c22",
	base02 = "#22262d",
	base03 = "#7b776e",
	base04 = "#949088",
	base05 = "#afaba2",
	base06 = "#cac6bd",
	base07 = "#e7e2d9",
	base08 = "#f04339",
	base09 = "#df5923",
	base0A = "#bb8801",
	base0B = "#7f8b00",
	base0C = "#00948b",
	base0D = "#008dd1",
	base0E = "#6a7fd2",
	base0F = "#e3488e",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-equilibrium-dark"
end
