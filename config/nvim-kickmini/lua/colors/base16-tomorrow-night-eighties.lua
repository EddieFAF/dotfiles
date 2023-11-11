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
	base00 = "#2d2d2d",
	base01 = "#393939",
	base02 = "#515151",
	base03 = "#999999",
	base04 = "#b4b7b4",
	base05 = "#cccccc",
	base06 = "#e0e0e0",
	base07 = "#ffffff",
	base08 = "#f2777a",
	base09 = "#f99157",
	base0A = "#ffcc66",
	base0B = "#99cc99",
	base0C = "#66cccc",
	base0D = "#6699cc",
	base0E = "#cc99cc",
	base0F = "#a3685a",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tomorrow-night-eighties"
end
