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
	base00 = "#f7f9fb",
	base01 = "#e5ebf1",
	base02 = "#cbd6e2",
	base03 = "#aabcce",
	base04 = "#627e99",
	base05 = "#405c79",
	base06 = "#223b54",
	base07 = "#0b1c2c",
	base08 = "#bf8b56",
	base09 = "#bfbf56",
	base0A = "#8bbf56",
	base0B = "#56bf8b",
	base0C = "#568bbf",
	base0D = "#8b56bf",
	base0E = "#bf568b",
	base0F = "#bf5656",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-harmonic16-light"
end
