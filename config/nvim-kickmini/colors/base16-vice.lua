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
	base00 = "#17191E",
	base01 = "#22262d",
	base02 = "#3c3f4c",
	base03 = "#383a47",
	base04 = "#555e70",
	base05 = "#8b9cbe",
	base06 = "#B2BFD9",
	base07 = "#f4f4f7",
	base08 = "#ff29a8",
	base09 = "#85ffe0",
	base0A = "#f0ffaa",
	base0B = "#0badff",
	base0C = "#8265ff",
	base0D = "#00eaff",
	base0E = "#00f6d9",
	base0F = "#ff3d81",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-vice"
end
