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
	base00 = "#0f0f0f",
	base01 = "#191919",
	base02 = "#262626",
	base03 = "#4c4c4c",
	base04 = "#ac8a8c",
	base05 = "#cacaca",
	base06 = "#e7e7e7",
	base07 = "#f0f0f0",
	base08 = "#ac8a8c",
	base09 = "#ceb188",
	base0A = "#aca98a",
	base0B = "#8aac8b",
	base0C = "#8aabac",
	base0D = "#8f8aac",
	base0E = "#ac8aac",
	base0F = "#ac8a8c",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-mountain"
end
