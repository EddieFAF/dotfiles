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
	base00 = "#181818",
	base01 = "#453d41",
	base02 = "#484848",
	base03 = "#52494e",
	base04 = "#e4e4ef",
	base05 = "#f4f4ff",
	base06 = "#f5f5f5",
	base07 = "#e4e4ef",
	base08 = "#f43841",
	base09 = "#c73c3f",
	base0A = "#ffdd33",
	base0B = "#73c936",
	base0C = "#95a99f",
	base0D = "#96a6c8",
	base0E = "#9e95c7",
	base0F = "#cc8c3c",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-gruber"
end
