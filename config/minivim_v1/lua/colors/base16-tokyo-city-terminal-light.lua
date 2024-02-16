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
	base00 = "#FBFBFD",
	base01 = "#F6F6F8",
	base02 = "#D8E2EC",
	base03 = "#B7C5D3",
	base04 = "#526270",
	base05 = "#28323A",
	base06 = "#1D252C",
	base07 = "#171D23",
	base08 = "#8C4351",
	base09 = "#965027",
	base0A = "#8f5E15",
	base0B = "#33635C",
	base0C = "#0F4B6E",
	base0D = "#34548A",
	base0E = "#5A4A78",
	base0F = "#7E5140",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tokyo-city-terminal-light"
end
