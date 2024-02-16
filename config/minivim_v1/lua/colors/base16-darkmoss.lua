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
	base00 = "#171e1f",
	base01 = "#252c2d",
	base02 = "#373c3d",
	base03 = "#555e5f",
	base04 = "#818f80",
	base05 = "#c7c7a5",
	base06 = "#e3e3c8",
	base07 = "#e1eaef",
	base08 = "#ff4658",
	base09 = "#e6db74",
	base0A = "#fdb11f",
	base0B = "#499180",
	base0C = "#66d9ef",
	base0D = "#498091",
	base0E = "#9bc0c8",
	base0F = "#d27b53",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-darkmoss"
end
