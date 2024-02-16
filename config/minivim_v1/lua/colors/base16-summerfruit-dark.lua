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
	base00 = "#151515",
	base01 = "#202020",
	base02 = "#303030",
	base03 = "#505050",
	base04 = "#B0B0B0",
	base05 = "#D0D0D0",
	base06 = "#E0E0E0",
	base07 = "#FFFFFF",
	base08 = "#FF0086",
	base09 = "#FD8900",
	base0A = "#ABA800",
	base0B = "#00C918",
	base0C = "#1FAAAA",
	base0D = "#3777E6",
	base0E = "#AD00A1",
	base0F = "#CC6633",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-summerfruit-dark"
end
