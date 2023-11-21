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
	base00 = "#f8f8f8",
	base01 = "#e8e8e8",
	base02 = "#d8d8d8",
	base03 = "#b8b8b8",
	base04 = "#585858",
	base05 = "#383838",
	base06 = "#282828",
	base07 = "#181818",
	base08 = "#fa8480",
	base09 = "#ffaa61",
	base0A = "#ffdc61",
	base0B = "#a0d2c8",
	base0C = "#a2d6f5",
	base0D = "#a0a7d2",
	base0E = "#c8a0d2",
	base0F = "#d2b2a0",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-sagelight"
end
