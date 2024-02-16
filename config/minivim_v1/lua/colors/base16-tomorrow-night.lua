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
	base00 = "#1d1f21",
	base01 = "#282a2e",
	base02 = "#373b41",
	base03 = "#969896",
	base04 = "#b4b7b4",
	base05 = "#c5c8c6",
	base06 = "#e0e0e0",
	base07 = "#ffffff",
	base08 = "#cc6666",
	base09 = "#de935f",
	base0A = "#f0c674",
	base0B = "#b5bd68",
	base0C = "#8abeb7",
	base0D = "#81a2be",
	base0E = "#b294bb",
	base0F = "#a3685a",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tomorrow-night"
end
