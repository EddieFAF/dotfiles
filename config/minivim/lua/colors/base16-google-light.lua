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
	base00 = "#ffffff",
	base01 = "#e0e0e0",
	base02 = "#c5c8c6",
	base03 = "#b4b7b4",
	base04 = "#969896",
	base05 = "#373b41",
	base06 = "#282a2e",
	base07 = "#1d1f21",
	base08 = "#CC342B",
	base09 = "#F96A38",
	base0A = "#FBA922",
	base0B = "#198844",
	base0C = "#3971ED",
	base0D = "#3971ED",
	base0E = "#A36AC7",
	base0F = "#3971ED",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-google-light"
end
