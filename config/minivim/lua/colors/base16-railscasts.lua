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
	base00 = "#2b2b2b",
	base01 = "#272935",
	base02 = "#3a4055",
	base03 = "#5a647e",
	base04 = "#d4cfc9",
	base05 = "#e6e1dc",
	base06 = "#f4f1ed",
	base07 = "#f9f7f3",
	base08 = "#da4939",
	base09 = "#cc7833",
	base0A = "#ffc66d",
	base0B = "#a5c261",
	base0C = "#519f50",
	base0D = "#6d9cbe",
	base0E = "#b6b3eb",
	base0F = "#bc9458",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-railscasts"
end
