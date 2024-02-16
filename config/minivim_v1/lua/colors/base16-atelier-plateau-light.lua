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
	base00 = "#f4ecec",
	base01 = "#e7dfdf",
	base02 = "#8a8585",
	base03 = "#7e7777",
	base04 = "#655d5d",
	base05 = "#585050",
	base06 = "#292424",
	base07 = "#1b1818",
	base08 = "#ca4949",
	base09 = "#b45a3c",
	base0A = "#a06e3b",
	base0B = "#4b8b8b",
	base0C = "#5485b6",
	base0D = "#7272ca",
	base0E = "#8464c4",
	base0F = "#bd5187",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-atelier-plateau-light"
end
