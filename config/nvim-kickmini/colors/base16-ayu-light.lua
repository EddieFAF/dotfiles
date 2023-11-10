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
	base00 = "#FAFAFA",
	base01 = "#F3F4F5",
	base02 = "#F8F9FA",
	base03 = "#ABB0B6",
	base04 = "#828C99",
	base05 = "#5C6773",
	base06 = "#242936",
	base07 = "#1A1F29",
	base08 = "#F07178",
	base09 = "#FA8D3E",
	base0A = "#F2AE49",
	base0B = "#86B300",
	base0C = "#4CBF99",
	base0D = "#36A3D9",
	base0E = "#A37ACC",
	base0F = "#E6BA7E",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-ayu-light"
end
