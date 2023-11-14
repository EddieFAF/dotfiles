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
	base00 = "#191919",
	base01 = "#DE6E7C",
	base02 = "#819B69",
	base03 = "#B77E64",
	base04 = "#6099C0",
	base05 = "#B279A7",
	base06 = "#66A5AD",
	base07 = "#BBBBBB",
	base08 = "#3D3839",
	base09 = "#E8838F",
	base0A = "#8BAE68",
	base0B = "#D68C67",
	base0C = "#61ABDA",
	base0D = "#CF86C1",
	base0E = "#65B8C1",
	base0F = "#8E8E8E",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-zenbones"
end
