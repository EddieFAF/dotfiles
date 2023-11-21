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
	base00 = "#031A16",
	base01 = "#0B342D",
	base02 = "#184E45",
	base03 = "#2B685E",
	base04 = "#5F9C92",
	base05 = "#81B5AC",
	base06 = "#A7CEC8",
	base07 = "#D2E7E4",
	base08 = "#3E9688",
	base09 = "#3E7996",
	base0A = "#3E4C96",
	base0B = "#883E96",
	base0C = "#963E4C",
	base0D = "#96883E",
	base0E = "#4C963E",
	base0F = "#3E965B",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
vim.g.colors_name = "base16-apathy"
end
