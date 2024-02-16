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
	base01 = "#303030",
	base02 = "#505050",
	base03 = "#b0b0b0",
	base04 = "#d0d0d0",
	base05 = "#e0e0e0",
	base06 = "#f5f5f5",
	base07 = "#ffffff",
	base08 = "#fb0120",
	base09 = "#fc6d24",
	base0A = "#fda331",
	base0B = "#a1c659",
	base0C = "#76c7b7",
	base0D = "#6fb3d2",
	base0E = "#d381c3",
	base0F = "#be643c",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-bright"
end
