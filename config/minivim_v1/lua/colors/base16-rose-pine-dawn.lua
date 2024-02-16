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
	base00 = "#faf4ed",
	base01 = "#fffaf3",
	base02 = "#f2e9de",
	base03 = "#9893a5",
	base04 = "#6e6a86",
	base05 = "#575279",
	base06 = "#555169",
	base07 = "#26233a",
	base08 = "#1f1d2e",
	base09 = "#b4637a",
	base0A = "#ea9d34",
	base0B = "#d7827e",
	base0C = "#286983",
	base0D = "#56949f",
	base0E = "#907aa9",
	base0F = "#c5c3ce",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-rose-pine-dawn"
end
