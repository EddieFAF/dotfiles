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
	base00 = "#263238",
	base01 = "#2E3C43",
	base02 = "#314549",
	base03 = "#546E7A",
	base04 = "#B2CCD6",
	base05 = "#EEFFFF",
	base06 = "#EEFFFF",
	base07 = "#FFFFFF",
	base08 = "#F07178",
	base09 = "#F78C6C",
	base0A = "#FFCB6B",
	base0B = "#C3E88D",
	base0C = "#89DDFF",
	base0D = "#82AAFF",
	base0E = "#C792EA",
	base0F = "#FF5370",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-material"
end
