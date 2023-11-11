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
	base00 = "#232629",
	base01 = "#333b3d",
	base02 = "#484e54",
	base03 = "#60615d",
	base04 = "#c0c0bd",
	base05 = "#f8f8f2",
	base06 = "#fcfcf6",
	base07 = "#fcfcfc",
	base08 = "#f11235",
	base09 = "#ff9505",
	base0A = "#ffb627",
	base0B = "#02d849",
	base0C = "#0dd9d6",
	base0D = "#00a6fb",
	base0E = "#f15ee3",
	base0F = "#b27701",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-humanoid-dark"
end
