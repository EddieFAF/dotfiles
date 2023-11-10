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
	base00 = "#22273b",
	base01 = "#414f60",
	base02 = "#5a8380",
	base03 = "#6e6f72",
	base04 = "#87888b",
	base05 = "#a4a6a9",
	base06 = "#c7c9cd",
	base07 = "#8dbdaa",
	base08 = "#777abc",
	base09 = "#94929e",
	base0A = "#4f9062",
	base0B = "#6562a8",
	base0C = "#226f68",
	base0D = "#4d6bb6",
	base0E = "#716cae",
	base0F = "#8c70a7",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-nebula"
end
