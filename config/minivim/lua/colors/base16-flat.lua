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
	base00 = "#2C3E50",
	base01 = "#34495E",
	base02 = "#7F8C8D",
	base03 = "#95A5A6",
	base04 = "#BDC3C7",
	base05 = "#e0e0e0",
	base06 = "#f5f5f5",
	base07 = "#ECF0F1",
	base08 = "#E74C3C",
	base09 = "#E67E22",
	base0A = "#F1C40F",
	base0B = "#2ECC71",
	base0C = "#1ABC9C",
	base0D = "#3498DB",
	base0E = "#9B59B6",
	base0F = "#be643c",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-flat"
end
