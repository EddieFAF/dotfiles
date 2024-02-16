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
	base00 = "#fbf1c7",
	base01 = "#f2e5bc",
	base02 = "#d5c4a1",
	base03 = "#bdae93",
	base04 = "#665c54",
	base05 = "#654735",
	base06 = "#3c3836",
	base07 = "#282828",
	base08 = "#c14a4a",
	base09 = "#c35e0a",
	base0A = "#b47109",
	base0B = "#6c782e",
	base0C = "#4c7a5d",
	base0D = "#45707a",
	base0E = "#945e80",
	base0F = "#e78a4e",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-gruvbox-material-light-medium"
end
