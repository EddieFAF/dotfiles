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
	base00 = "#2b303b",
	base01 = "#343d46",
	base02 = "#4f5b66",
	base03 = "#65737e",
	base04 = "#a7adba",
	base05 = "#c0c5ce",
	base06 = "#dfe1e8",
	base07 = "#eff1f5",
	base08 = "#bf616a",
	base09 = "#d08770",
	base0A = "#ebcb8b",
	base0B = "#a3be8c",
	base0C = "#96b5b4",
	base0D = "#8fa1b3",
	base0E = "#b48ead",
	base0F = "#ab7967",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-ocean"
end
