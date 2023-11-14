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
	base00 = "#190134",
	base01 = "#392551",
	base02 = "#5A496E",
	base03 = "#7B6D8B",
	base04 = "#9C92A8",
	base05 = "#BDB6C5",
	base06 = "#DEDAE2",
	base07 = "#FEFFFF",
	base08 = "#27D9D5",
	base09 = "#5BA2B6",
	base0A = "#8F6C97",
	base0B = "#C33678",
	base0C = "#F80059",
	base0D = "#BD0152",
	base0E = "#82034C",
	base0F = "#470546",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-heetch"
end
