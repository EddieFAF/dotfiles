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
	base00 = "#303446",
	base01 = "#292c3c",
	base02 = "#414559",
	base03 = "#51576d",
	base04 = "#626880",
	base05 = "#c6d0f5",
	base06 = "#f2d5cf",
	base07 = "#babbf1",
	base08 = "#e78284",
	base09 = "#ef9f76",
	base0A = "#e5c890",
	base0B = "#a6d189",
	base0C = "#81c8be",
	base0D = "#8caaee",
	base0E = "#ca9ee6",
	base0F = "#eebebe",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-catppuccin-frappe"
end
