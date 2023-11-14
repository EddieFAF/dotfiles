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
	base00 = "#2e2a31",
	base01 = "#4b484e",
	base02 = "#69666b",
	base03 = "#878589",
	base04 = "#a5a3a6",
	base05 = "#c3c2c4",
	base06 = "#e1e0e1",
	base07 = "#ffffff",
	base08 = "#d8137f",
	base09 = "#d65407",
	base0A = "#dc8a0e",
	base0B = "#17ad98",
	base0C = "#149bda",
	base0D = "#7864fa",
	base0E = "#b33ce8",
	base0F = "#d41acd",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-unikitty-reversible"
end
