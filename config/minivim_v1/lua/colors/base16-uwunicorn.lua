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
	base00 = "#241b26",
	base01 = "#2f2a3f",
	base02 = "#46354a",
	base03 = "#6c3cb2",
	base04 = "#7e5f83",
	base05 = "#eed5d9",
	base06 = "#d9c2c6",
	base07 = "#e4ccd0",
	base08 = "#877bb6",
	base09 = "#de5b44",
	base0A = "#a84a73",
	base0B = "#c965bf",
	base0C = "#9c5fce",
	base0D = "#6a9eb5",
	base0E = "#78a38f",
	base0F = "#a3a079",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-uwunicorn"
end
