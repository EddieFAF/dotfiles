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
	base00 = "#3B3228",
	base01 = "#534636",
	base02 = "#645240",
	base03 = "#7e705a",
	base04 = "#b8afad",
	base05 = "#d0c8c6",
	base06 = "#e9e1dd",
	base07 = "#f5eeeb",
	base08 = "#cb6077",
	base09 = "#d28b71",
	base0A = "#f4bc87",
	base0B = "#beb55b",
	base0C = "#7bbda4",
	base0D = "#8ab3b5",
	base0E = "#a89bb9",
	base0F = "#bb9584",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-mocha"
end
