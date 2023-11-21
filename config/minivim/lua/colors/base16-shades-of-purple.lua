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
	base00 = "#1e1e3f",
	base01 = "#43d426",
	base02 = "#f1d000",
	base03 = "#808080",
	base04 = "#6871ff",
	base05 = "#c7c7c7",
	base06 = "#ff77ff",
	base07 = "#ffffff",
	base08 = "#d90429",
	base09 = "#f92a1c",
	base0A = "#ffe700",
	base0B = "#3ad900",
	base0C = "#00c5c7",
	base0D = "#6943ff",
	base0E = "#ff2c70",
	base0F = "#79e8fb",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-shades-of-purple"
end
