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
	base00 = "#D5D6DB",
	base01 = "#CBCCD1",
	base02 = "#DFE0E5",
	base03 = "#9699A3",
	base04 = "#4C505E",
	base05 = "#343B59",
	base06 = "#1A1B26",
	base07 = "#1A1B26",
	base08 = "#343B58",
	base09 = "#965027",
	base0A = "#166775",
	base0B = "#485E30",
	base0C = "#3E6968",
	base0D = "#34548A",
	base0E = "#5A4A78",
	base0F = "#8C4351",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tokyo-night-light"
end
