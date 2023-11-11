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
	base00 = "#222222",
	base01 = "#313131",
	base02 = "#555D55",
	base03 = "#644646",
	base04 = "#5A5A5A",
	base05 = "#DEDEE7",
	base06 = "#C3C3B4",
	base07 = "#FFFFE6",
	base08 = "#C88C8C",
	base09 = "#476C88",
	base0A = "#D8B56D",
	base0B = "#99C899",
	base0C = "#78B4B4",
	base0D = "#537C9C",
	base0E = "#86CACD",
	base0F = "#704F4F",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-kimber"
end
