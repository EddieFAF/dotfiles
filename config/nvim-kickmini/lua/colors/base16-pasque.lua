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
	base00 = "#271C3A",
	base01 = "#100323",
	base02 = "#3E2D5C",
	base03 = "#5D5766",
	base04 = "#BEBCBF",
	base05 = "#DEDCDF",
	base06 = "#EDEAEF",
	base07 = "#BBAADD",
	base08 = "#A92258",
	base09 = "#918889",
	base0A = "#804ead",
	base0B = "#C6914B",
	base0C = "#7263AA",
	base0D = "#8E7DC6",
	base0E = "#953B9D",
	base0F = "#59325C",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-pasque"
end
