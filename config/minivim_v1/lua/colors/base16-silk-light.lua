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
	base00 = "#E9F1EF",
	base01 = "#CCD4D3",
	base02 = "#90B7B6",
	base03 = "#5C787B",
	base04 = "#4B5B5F",
	base05 = "#385156",
	base06 = "#0e3c46",
	base07 = "#D2FAFF",
	base08 = "#CF432E",
	base09 = "#D27F46",
	base0A = "#CFAD25",
	base0B = "#6CA38C",
	base0C = "#329CA2",
	base0D = "#39AAC9",
	base0E = "#6E6582",
	base0F = "#865369",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-silk-light"
end
