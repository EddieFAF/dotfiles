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
	base00 = "#322931",
	base01 = "#433b42",
	base02 = "#5c545b",
	base03 = "#797379",
	base04 = "#989498",
	base05 = "#b9b5b8",
	base06 = "#d5d3d5",
	base07 = "#ffffff",
	base08 = "#dd464c",
	base09 = "#fd8b19",
	base0A = "#fdcc59",
	base0B = "#8fc13e",
	base0C = "#149b93",
	base0D = "#1290bf",
	base0E = "#c85e7c",
	base0F = "#b33508",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-hopscotch"
end
