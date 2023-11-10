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
	base00 = "#103c48",
	base01 = "#184956",
	base02 = "#2d5b69",
	base03 = "#72898f",
	base04 = "#72898f",
	base05 = "#adbcbc",
	base06 = "#cad8d9",
	base07 = "#cad8d9",
	base08 = "#fa5750",
	base09 = "#ed8649",
	base0A = "#dbb32d",
	base0B = "#75b938",
	base0C = "#41c7b9",
	base0D = "#4695f7",
	base0E = "#af88eb",
	base0F = "#f275be",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-selenized-dark"
end
