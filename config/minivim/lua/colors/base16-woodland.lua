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
	base00 = "#231e18",
	base01 = "#302b25",
	base02 = "#48413a",
	base03 = "#9d8b70",
	base04 = "#b4a490",
	base05 = "#cabcb1",
	base06 = "#d7c8bc",
	base07 = "#e4d4c8",
	base08 = "#d35c5c",
	base09 = "#ca7f32",
	base0A = "#e0ac16",
	base0B = "#b7ba53",
	base0C = "#6eb958",
	base0D = "#88a4d3",
	base0E = "#bb90e2",
	base0F = "#b49368",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-woodland"
end
