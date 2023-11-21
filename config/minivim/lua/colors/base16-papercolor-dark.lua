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
	base00 = "#1c1c1c",
	base01 = "#af005f",
	base02 = "#5faf00",
	base03 = "#d7af5f",
	base04 = "#5fafd7",
	base05 = "#808080",
	base06 = "#d7875f",
	base07 = "#d0d0d0",
	base08 = "#585858",
	base09 = "#5faf5f",
	base0A = "#afd700",
	base0B = "#af87d7",
	base0C = "#ffaf00",
	base0D = "#ff5faf",
	base0E = "#00afaf",
	base0F = "#5f8787",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-papercolor-dark"
end
