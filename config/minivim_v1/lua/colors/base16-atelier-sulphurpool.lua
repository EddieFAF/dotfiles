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
	base00 = "#202746",
	base01 = "#293256",
	base02 = "#5e6687",
	base03 = "#6b7394",
	base04 = "#898ea4",
	base05 = "#979db4",
	base06 = "#dfe2f1",
	base07 = "#f5f7ff",
	base08 = "#c94922",
	base09 = "#c76b29",
	base0A = "#c08b30",
	base0B = "#ac9739",
	base0C = "#22a2c9",
	base0D = "#3d8fd1",
	base0E = "#6679cc",
	base0F = "#9c637a",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-atelier-sulphurpool"
end
