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
	base00 = "#151515",
	base01 = "#202020",
	base02 = "#303030",
	base03 = "#505050",
	base04 = "#b0b0b0",
	base05 = "#d0d0d0",
	base06 = "#e0e0e0",
	base07 = "#f5f5f5",
	base08 = "#fb9fb1",
	base09 = "#eda987",
	base0A = "#ddb26f",
	base0B = "#acc267",
	base0C = "#12cfc0",
	base0D = "#6fc2ef",
	base0E = "#e1a3ee",
	base0F = "#deaf8f",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-chalk"
end
