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
	base00 = "#383838",
	base01 = "#404040",
	base02 = "#606060",
	base03 = "#6f6f6f",
	base04 = "#808080",
	base05 = "#dcdccc",
	base06 = "#c0c0c0",
	base07 = "#ffffff",
	base08 = "#dca3a3",
	base09 = "#dfaf8f",
	base0A = "#e0cf9f",
	base0B = "#5f7f5f",
	base0C = "#93e0e3",
	base0D = "#7cb8bb",
	base0E = "#dc8cc3",
	base0F = "#000000",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-zenburn"
end
