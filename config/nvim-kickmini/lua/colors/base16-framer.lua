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
	base00 = "#181818",
	base01 = "#151515",
	base02 = "#464646",
	base03 = "#747474",
	base04 = "#B9B9B9",
	base05 = "#D0D0D0",
	base06 = "#E8E8E8",
	base07 = "#EEEEEE",
	base08 = "#FD886B",
	base09 = "#FC4769",
	base0A = "#FECB6E",
	base0B = "#32CCDC",
	base0C = "#ACDDFD",
	base0D = "#20BCFC",
	base0E = "#BA8CFC",
	base0F = "#B15F4A",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-framer"
end
