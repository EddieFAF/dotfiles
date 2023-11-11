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
	base00 = "#00002A",
	base01 = "#20204A",
	base02 = "#30305A",
	base03 = "#50507A",
	base04 = "#B0B0DA",
	base05 = "#D0D0FA",
	base06 = "#E0E0FF",
	base07 = "#F5F5FF",
	base08 = "#FF4242",
	base09 = "#FC8D28",
	base0A = "#F3E877",
	base0B = "#59F176",
	base0C = "#0EF0F0",
	base0D = "#66B0FF",
	base0E = "#F10596",
	base0F = "#F003EF",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-outrun-dark"
end
