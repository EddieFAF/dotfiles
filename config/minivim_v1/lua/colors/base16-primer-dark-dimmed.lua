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
	base00 = "#1c2128",
	base01 = "#373e47",
	base02 = "#444c56",
	base03 = "#545d68",
	base04 = "#768390",
	base05 = "#909dab",
	base06 = "#adbac7",
	base07 = "#cdd9e5",
	base08 = "#f47067",
	base09 = "#e0823d",
	base0A = "#c69026",
	base0B = "#57ab5a",
	base0C = "#96d0ff",
	base0D = "#539bf5",
	base0E = "#e275ad",
	base0F = "#ae5622",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-primer-dark-dimmed"
end
