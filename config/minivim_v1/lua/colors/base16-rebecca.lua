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
	base00 = "#292a44",
	base01 = "#663399",
	base02 = "#383a62",
	base03 = "#666699",
	base04 = "#a0a0c5",
	base05 = "#f1eff8",
	base06 = "#ccccff",
	base07 = "#53495d",
	base08 = "#a0a0c5",
	base09 = "#efe4a1",
	base0A = "#ae81ff",
	base0B = "#6dfedf",
	base0C = "#8eaee0",
	base0D = "#2de0a7",
	base0E = "#7aa5ff",
	base0F = "#ff79c6",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-rebecca"
end
