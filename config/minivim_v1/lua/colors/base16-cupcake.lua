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
	base00 = "#fbf1f2",
	base01 = "#f2f1f4",
	base02 = "#d8d5dd",
	base03 = "#bfb9c6",
	base04 = "#a59daf",
	base05 = "#8b8198",
	base06 = "#72677E",
	base07 = "#585062",
	base08 = "#D57E85",
	base09 = "#EBB790",
	base0A = "#DCB16C",
	base0B = "#A3B367",
	base0C = "#69A9A7",
	base0D = "#7297B9",
	base0E = "#BB99B4",
	base0F = "#BAA58C",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-cupcake"
end
