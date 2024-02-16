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
	base00 = "#0c0c0c",
	base01 = "#2f2f2f",
	base02 = "#535353",
	base03 = "#767676",
	base04 = "#b9b9b9",
	base05 = "#cccccc",
	base06 = "#dfdfdf",
	base07 = "#f2f2f2",
	base08 = "#e74856",
	base09 = "#c19c00",
	base0A = "#f9f1a5",
	base0B = "#16c60c",
	base0C = "#61d6d6",
	base0D = "#3b78ff",
	base0E = "#b4009e",
	base0F = "#13a10e",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-windows-10"
end
