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
	base00 = "#282a36",
	base01 = "#34353e",
	base02 = "#43454f",
	base03 = "#78787e",
	base04 = "#a5a5a9",
	base05 = "#e2e4e5",
	base06 = "#eff0eb",
	base07 = "#f1f1f0",
	base08 = "#ff5c57",
	base09 = "#ff9f43",
	base0A = "#f3f99d",
	base0B = "#5af78e",
	base0C = "#9aedfe",
	base0D = "#57c7ff",
	base0E = "#ff6ac1",
	base0F = "#b2643c",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-snazzy"
end
