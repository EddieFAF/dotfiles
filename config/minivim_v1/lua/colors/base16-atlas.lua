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
	base00 = "#002635",
	base01 = "#00384d",
	base02 = "#517F8D",
	base03 = "#6C8B91",
	base04 = "#869696",
	base05 = "#a1a19a",
	base06 = "#e6e6dc",
	base07 = "#fafaf8",
	base08 = "#ff5a67",
	base09 = "#f08e48",
	base0A = "#ffcc1b",
	base0B = "#7fc06e",
	base0C = "#14747e",
	base0D = "#5dd7b9",
	base0E = "#9a70a4",
	base0F = "#c43060",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-atlas"
end
