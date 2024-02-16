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
	base00 = "#485867",
	base01 = "#5A6D7A",
	base02 = "#6D828E",
	base03 = "#8299A1",
	base04 = "#98AFB5",
	base05 = "#B0C5C8",
	base06 = "#C9DBDC",
	base07 = "#E3EFEF",
	base08 = "#b38686",
	base09 = "#d8bba2",
	base0A = "#aab386",
	base0B = "#87b386",
	base0C = "#86b3b3",
	base0D = "#868cb3",
	base0E = "#b386b2",
	base0F = "#b39f9f",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-brushtrees-dark"
end
