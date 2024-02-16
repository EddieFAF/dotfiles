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
	base00 = "#1f2022",
	base01 = "#282828",
	base02 = "#444155",
	base03 = "#585858",
	base04 = "#b8b8b8",
	base05 = "#a3a3a3",
	base06 = "#e8e8e8",
	base07 = "#f8f8f8",
	base08 = "#f2241f",
	base09 = "#ffa500",
	base0A = "#b1951d",
	base0B = "#67b11d",
	base0C = "#2d9574",
	base0D = "#4f97d7",
	base0E = "#a31db1",
	base0F = "#b03060",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-spacemacs"
end
