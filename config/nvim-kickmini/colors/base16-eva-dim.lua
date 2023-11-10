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
	base00 = "#2a3b4d",
	base01 = "#3d566f",
	base02 = "#4b6988",
	base03 = "#55799c",
	base04 = "#7e90a3",
	base05 = "#9fa2a6",
	base06 = "#d6d7d9",
	base07 = "#ffffff",
	base08 = "#c4676c",
	base09 = "#ff9966",
	base0A = "#cfd05d",
	base0B = "#5de561",
	base0C = "#4b8f77",
	base0D = "#1ae1dc",
	base0E = "#9c6cd3",
	base0F = "#bb64a9",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-eva-dim"
end
