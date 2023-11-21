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
	base00 = "#000000",
	base01 = "#231a40",
	base02 = "#432d59",
	base03 = "#593380",
	base04 = "#00ff00",
	base05 = "#b08ae6",
	base06 = "#9045e6",
	base07 = "#a366ff",
	base08 = "#a82ee6",
	base09 = "#bb66cc",
	base0A = "#f29df2",
	base0B = "#4595e6",
	base0C = "#40dfff",
	base0D = "#4136d9",
	base0E = "#7e5ce6",
	base0F = "#a886bf",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-darkviolet"
end
