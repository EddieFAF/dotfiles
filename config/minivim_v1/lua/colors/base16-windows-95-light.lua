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
	base01 = "#e0e0e0",
	base02 = "#c4c4c4",
	base03 = "#a8a8a8",
	base04 = "#7e7e7e",
	base05 = "#545454",
	base06 = "#2a2a2a",
	base07 = "#000000",
	base08 = "#a80000",
	base09 = "#fcfc54",
	base0A = "#a85400",
	base0B = "#00a800",
	base0C = "#00a8a8",
	base0D = "#0000a8",
	base0E = "#a800a8",
	base0F = "#54fc54",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-windows-95-light"
end
