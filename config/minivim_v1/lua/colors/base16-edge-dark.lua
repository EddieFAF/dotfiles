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
	base00 = "#262729",
	base01 = "#88909f",
	base02 = "#b7bec9",
	base03 = "#3e4249",
	base04 = "#73b3e7",
	base05 = "#b7bec9",
	base06 = "#d390e7",
	base07 = "#3e4249",
	base08 = "#e77171",
	base09 = "#e77171",
	base0A = "#dbb774",
	base0B = "#a1bf78",
	base0C = "#5ebaa5",
	base0D = "#73b3e7",
	base0E = "#d390e7",
	base0F = "#5ebaa5",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-edge-dark"
end
