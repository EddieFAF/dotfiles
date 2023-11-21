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
	base00 = "#1f1f1f",
	base01 = "#f81118",
	base02 = "#2dc55e",
	base03 = "#ecba0f",
	base04 = "#2a84d2",
	base05 = "#4e5ab7",
	base06 = "#1081d6",
	base07 = "#d6dbe5",
	base08 = "#d6dbe5",
	base09 = "#de352e",
	base0A = "#1dd361",
	base0B = "#f3bd09",
	base0C = "#1081d6",
	base0D = "#5350b9",
	base0E = "#0f7ddb",
	base0F = "#ffffff",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-brogrammer"
end
