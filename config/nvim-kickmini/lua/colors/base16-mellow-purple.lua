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
	base00 = "#1e0528",
	base01 = "#1A092D",
	base02 = "#331354",
	base03 = "#320f55",
	base04 = "#873582",
	base05 = "#ffeeff",
	base06 = "#ffeeff",
	base07 = "#f8c0ff",
	base08 = "#00d9e9",
	base09 = "#aa00a3",
	base0A = "#955ae7",
	base0B = "#05cb0d",
	base0C = "#b900b1",
	base0D = "#550068",
	base0E = "#8991bb",
	base0F = "#4d6fff",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-mellow-purple"
end
