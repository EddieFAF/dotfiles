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
	base00 = "#000000",
	base01 = "#1C1C1C",
	base02 = "#383838",
	base03 = "#545454",
	base04 = "#7e7e7e",
	base05 = "#a8a8a8",
	base06 = "#d2d2d2",
	base07 = "#fcfcfc",
	base08 = "#fc5454",
	base09 = "#a85400",
	base0A = "#fcfc54",
	base0B = "#54fc54",
	base0C = "#54fcfc",
	base0D = "#5454fc",
	base0E = "#fc54fc",
	base0F = "#00a800",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-windows-95"
end
