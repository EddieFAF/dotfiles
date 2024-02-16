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
	base00 = "#100510",
	base01 = "#302030",
	base02 = "#403040",
	base03 = "#605060",
	base04 = "#bbb0bb",
	base05 = "#ddd0dd",
	base06 = "#eee0ee",
	base07 = "#fff0ff",
	base08 = "#FF1D0D",
	base09 = "#CCAE14",
	base0A = "#F000A0",
	base0B = "#14CC64",
	base0C = "#0075B0",
	base0D = "#00A0F0",
	base0E = "#B000D0",
	base0F = "#6A2A3C",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-purpledream"
end
