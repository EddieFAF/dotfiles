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
	base00 = "#feffff",
	base01 = "#392551",
	base02 = "#7b6d8b",
	base03 = "#9c92a8",
	base04 = "#ddd6e5",
	base05 = "#5a496e",
	base06 = "#470546",
	base07 = "#190134",
	base08 = "#27d9d5",
	base09 = "#bdb6c5",
	base0A = "#5ba2b6",
	base0B = "#f80059",
	base0C = "#c33678",
	base0D = "#47f9f5",
	base0E = "#bd0152",
	base0F = "#dedae2",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-heetch-light"
end
