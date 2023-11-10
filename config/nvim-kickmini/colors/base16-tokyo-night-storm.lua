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
	base00 = "#24283B",
	base01 = "#16161E",
	base02 = "#343A52",
	base03 = "#444B6A",
	base04 = "#787C99",
	base05 = "#A9B1D6",
	base06 = "#CBCCD1",
	base07 = "#D5D6DB",
	base08 = "#C0CAF5",
	base09 = "#A9B1D6",
	base0A = "#0DB9D7",
	base0B = "#9ECE6A",
	base0C = "#B4F9F8",
	base0D = "#2AC3DE",
	base0E = "#BB9AF7",
	base0F = "#F7768E",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tokyo-night-storm"
end
