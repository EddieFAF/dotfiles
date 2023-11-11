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
	base00 = "#282828",
	base01 = "#3c3836",
	base02 = "#504945",
	base03 = "#665c54",
	base04 = "#bdae93",
	base05 = "#d5c4a1",
	base06 = "#ebdbb2",
	base07 = "#fbf1c7",
	base08 = "#fb4934",
	base09 = "#fe8019",
	base0A = "#fabd2f",
	base0B = "#b8bb26",
	base0C = "#8ec07c",
	base0D = "#83a598",
	base0E = "#d3869b",
	base0F = "#d65d0e",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-gruvbox-dark-medium"
end
