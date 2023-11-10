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
	base00 = "#3C4C55",
	base01 = "#556873",
	base02 = "#6A7D89",
	base03 = "#899BA6",
	base04 = "#899BA6",
	base05 = "#C5D4DD",
	base06 = "#899BA6",
	base07 = "#556873",
	base08 = "#83AFE5",
	base09 = "#7FC1CA",
	base0A = "#A8CE93",
	base0B = "#7FC1CA",
	base0C = "#F2C38F",
	base0D = "#83AFE5",
	base0E = "#9A93E1",
	base0F = "#F2C38F",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-nova"
end
