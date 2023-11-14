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
	base00 = "#FAFAFA",
	base01 = "#E7EAEC",
	base02 = "#CCEAE7",
	base03 = "#CCD7DA",
	base04 = "#8796B0",
	base05 = "#80CBC4",
	base06 = "#80CBC4",
	base07 = "#FFFFFF",
	base08 = "#FF5370",
	base09 = "#F76D47",
	base0A = "#FFB62C",
	base0B = "#91B859",
	base0C = "#39ADB5",
	base0D = "#6182B8",
	base0E = "#7C4DFF",
	base0F = "#E53935",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-material-lighter"
end
