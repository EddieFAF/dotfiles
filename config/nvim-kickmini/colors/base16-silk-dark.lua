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
	base00 = "#0e3c46",
	base01 = "#1D494E",
	base02 = "#2A5054",
	base03 = "#587073",
	base04 = "#9DC8CD",
	base05 = "#C7DBDD",
	base06 = "#CBF2F7",
	base07 = "#D2FAFF",
	base08 = "#fb6953",
	base09 = "#fcab74",
	base0A = "#fce380",
	base0B = "#73d8ad",
	base0C = "#3fb2b9",
	base0D = "#46bddd",
	base0E = "#756b8a",
	base0F = "#9b647b",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-silk-dark"
end
