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
	base00 = "#232136",
	base01 = "#2a273f",
	base02 = "#393552",
	base03 = "#59546d",
	base04 = "#817c9c",
	base05 = "#e0def4",
	base06 = "#f5f5f7",
	base07 = "#d9d7e1",
	base08 = "#ecebf0",
	base09 = "#eb6f92",
	base0A = "#f6c177",
	base0B = "#ea9a97",
	base0C = "#3e8fb0",
	base0D = "#9ccfd8",
	base0E = "#c4a7e7",
	base0F = "#b9b9bc",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-rose-pine-moon"
end
