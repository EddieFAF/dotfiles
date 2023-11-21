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
	base00 = "#fcfcfc",
	base01 = "#e8e8e8",
	base02 = "#d4d4d4",
	base03 = "#c0c0c0",
	base04 = "#7e7e7e",
	base05 = "#545454",
	base06 = "#2a2a2a",
	base07 = "#000000",
	base08 = "#800000",
	base09 = "#fcfc54",
	base0A = "#808000",
	base0B = "#008000",
	base0C = "#008080",
	base0D = "#000080",
	base0E = "#800080",
	base0F = "#54fc54",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-windows-highcontrast-light"
end
