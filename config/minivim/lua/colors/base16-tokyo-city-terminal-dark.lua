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
	base00 = "#171D23",
	base01 = "#1D252C",
	base02 = "#28323A",
	base03 = "#526270",
	base04 = "#B7C5D3",
	base05 = "#D8E2EC",
	base06 = "#F6F6F8",
	base07 = "#FBFBFD",
	base08 = "#D95468",
	base09 = "#FF9E64",
	base0A = "#EBBF83",
	base0B = "#8BD49C",
	base0C = "#70E1E8",
	base0D = "#539AFC",
	base0E = "#B62D65",
	base0F = "#DD9D82",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tokyo-city-terminal-dark"
end
