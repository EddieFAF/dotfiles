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
	base01 = "#1A1B26",
	base02 = "#343A52",
	base03 = "#444B6A",
	base04 = "#787C99",
	base05 = "#787C99",
	base06 = "#CBCCD1",
	base07 = "#D5D6DB",
	base08 = "#F7768E",
	base09 = "#FF9E64",
	base0A = "#E0AF68",
	base0B = "#41A6B5",
	base0C = "#7DCFFF",
	base0D = "#7AA2F7",
	base0E = "#BB9AF7",
	base0F = "#D18616",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tokyo-night-terminal-storm"
end
