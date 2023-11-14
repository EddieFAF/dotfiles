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
	base00 = "#282c34",
	base01 = "#353b45",
	base02 = "#3e4451",
	base03 = "#545862",
	base04 = "#565c64",
	base05 = "#abb2bf",
	base06 = "#b6bdca",
	base07 = "#c8ccd4",
	base08 = "#e06c75",
	base09 = "#d19a66",
	base0A = "#e5c07b",
	base0B = "#98c379",
	base0C = "#56b6c2",
	base0D = "#61afef",
	base0E = "#c678dd",
	base0F = "#be5046",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-onedark"
end
