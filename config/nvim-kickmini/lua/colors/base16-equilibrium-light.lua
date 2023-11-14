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
	base00 = "#f5f0e7",
	base01 = "#e7e2d9",
	base02 = "#d8d4cb",
	base03 = "#73777f",
	base04 = "#5a5f66",
	base05 = "#43474e",
	base06 = "#2c3138",
	base07 = "#181c22",
	base08 = "#d02023",
	base09 = "#bf3e05",
	base0A = "#9d6f00",
	base0B = "#637200",
	base0C = "#007a72",
	base0D = "#0073b5",
	base0E = "#4e66b6",
	base0F = "#c42775",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-equilibrium-light"
end
