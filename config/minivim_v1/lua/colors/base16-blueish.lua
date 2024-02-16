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
	base00 = "#182430",
	base01 = "#243C54",
	base02 = "#46290A",
	base03 = "#616D78",
	base04 = "#74AFE7",
	base05 = "#C8E1F8",
	base06 = "#DDEAF6",
	base07 = "#8F98A0",
	base08 = "#4CE587",
	base09 = "#F6A85C",
	base0A = "#82AAFF",
	base0B = "#C3E88D",
	base0C = "#5FD1FF",
	base0D = "#82AAFF",
	base0E = "#FF84DD",
	base0F = "#BBD2E8",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-blueish"
end
