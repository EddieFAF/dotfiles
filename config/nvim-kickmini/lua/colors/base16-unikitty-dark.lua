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
	base01 = "#4a464d",
	base02 = "#666369",
	base03 = "#838085",
	base04 = "#9f9da2",
	base05 = "#bcbabe",
	base06 = "#d8d7da",
	base07 = "#f5f4f7",
	base08 = "#d8137f",
	base09 = "#d65407",
	base0A = "#dc8a0e",
	base0B = "#17ad98",
	base0C = "#149bda",
	base0D = "#796af5",
	base0E = "#bb60ea",
	base0F = "#c720ca",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-unikitty-dark"
end
