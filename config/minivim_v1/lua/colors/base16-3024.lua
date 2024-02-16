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
	base00 = "#090300",
	base01 = "#3a3432",
	base02 = "#4a4543",
	base03 = "#5c5855",
	base04 = "#807d7c",
	base05 = "#a5a2a2",
	base06 = "#d6d5d4",
	base07 = "#f7f7f7",
	base08 = "#db2d20",
	base09 = "#e8bbd0",
	base0A = "#fded02",
	base0B = "#01a252",
	base0C = "#b5e4f4",
	base0D = "#01a0e4",
	base0E = "#a16a94",
	base0F = "#cdab53",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-3024"
end
