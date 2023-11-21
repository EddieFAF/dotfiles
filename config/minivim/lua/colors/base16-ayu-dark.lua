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
	base00 = "#0F1419",
	base01 = "#131721",
	base02 = "#272D38",
	base03 = "#3E4B59",
	base04 = "#BFBDB6",
	base05 = "#E6E1CF",
	base06 = "#E6E1CF",
	base07 = "#F3F4F5",
	base08 = "#F07178",
	base09 = "#FF8F40",
	base0A = "#FFB454",
	base0B = "#B8CC52",
	base0C = "#95E6CB",
	base0D = "#59C2FF",
	base0E = "#D2A6FF",
	base0F = "#E6B673",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-ayu-dark"
end
