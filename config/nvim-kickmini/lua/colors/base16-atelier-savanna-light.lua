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
	base00 = "#ecf4ee",
	base01 = "#dfe7e2",
	base02 = "#87928a",
	base03 = "#78877d",
	base04 = "#5f6d64",
	base05 = "#526057",
	base06 = "#232a25",
	base07 = "#171c19",
	base08 = "#b16139",
	base09 = "#9f713c",
	base0A = "#a07e3b",
	base0B = "#489963",
	base0C = "#1c9aa0",
	base0D = "#478c90",
	base0E = "#55859b",
	base0F = "#867469",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-atelier-savanna-light"
end
