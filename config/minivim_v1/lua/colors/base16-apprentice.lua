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
	base00 = "#262626",
	base01 = "#AF5F5F",
	base02 = "#5F875F",
	base03 = "#87875F",
	base04 = "#5F87AF",
	base05 = "#5F5F87",
	base06 = "#5F8787",
	base07 = "#6C6C6C",
	base08 = "#444444",
	base09 = "#FF8700",
	base0A = "#87AF87",
	base0B = "#FFFFAF",
	base0C = "#87AFD7",
	base0D = "#8787AF",
	base0E = "#5FAFAF",
	base0F = "#BCBCBC",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-apprentice"
end
