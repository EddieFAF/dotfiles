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
	base00 = "#1d2021",
	base01 = "#383c3e",
	base02 = "#53585b",
	base03 = "#6f7579",
	base04 = "#cdcdcd",
	base05 = "#d5d5d5",
	base06 = "#dddddd",
	base07 = "#e5e5e5",
	base08 = "#d72638",
	base09 = "#eb8413",
	base0A = "#f19d1a",
	base0B = "#88b92d",
	base0C = "#1ba595",
	base0D = "#1e8bac",
	base0E = "#be4264",
	base0F = "#c85e0d",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-helios"
end
