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
	base00 = "#191724",
	base01 = "#1f1d2e",
	base02 = "#26233a",
	base03 = "#555169",
	base04 = "#6e6a86",
	base05 = "#e0def4",
	base06 = "#f0f0f3",
	base07 = "#c5c3ce",
	base08 = "#e2e1e7",
	base09 = "#eb6f92",
	base0A = "#f6c177",
	base0B = "#ebbcba",
	base0C = "#31748f",
	base0D = "#9ccfd8",
	base0E = "#c4a7e7",
	base0F = "#e5e5e5",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-rose-pine"
end
