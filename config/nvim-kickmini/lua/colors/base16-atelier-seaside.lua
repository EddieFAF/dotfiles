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
	base00 = "#131513",
	base01 = "#242924",
	base02 = "#5e6e5e",
	base03 = "#687d68",
	base04 = "#809980",
	base05 = "#8ca68c",
	base06 = "#cfe8cf",
	base07 = "#f4fbf4",
	base08 = "#e6193c",
	base09 = "#87711d",
	base0A = "#98981b",
	base0B = "#29a329",
	base0C = "#1999b3",
	base0D = "#3d62f5",
	base0E = "#ad2bee",
	base0F = "#e619c3",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-atelier-seaside"
end
