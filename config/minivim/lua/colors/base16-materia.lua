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
	base00 = "#263238",
	base01 = "#2C393F",
	base02 = "#37474F",
	base03 = "#707880",
	base04 = "#C9CCD3",
	base05 = "#CDD3DE",
	base06 = "#D5DBE5",
	base07 = "#FFFFFF",
	base08 = "#EC5F67",
	base09 = "#EA9560",
	base0A = "#FFCC00",
	base0B = "#8BD649",
	base0C = "#80CBC4",
	base0D = "#89DDFF",
	base0E = "#82AAFF",
	base0F = "#EC5F67",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-materia"
end
