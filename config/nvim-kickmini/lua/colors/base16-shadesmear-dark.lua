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
	base00 = "#232323",
	base01 = "#1C1C1C",
	base02 = "#4E4E4E",
	base03 = "#C0C0C0",
	base04 = "#E4E4E4",
	base05 = "#DBDBDB",
	base06 = "#E4E4E4",
	base07 = "#1C1C1C",
	base08 = "#CC5450",
	base09 = "#A64270",
	base0A = "#307878",
	base0B = "#71983B",
	base0C = "#C57D42",
	base0D = "#376388",
	base0E = "#D7AB54",
	base0F = "#6D6D6D",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-shadesmear-dark"
end
