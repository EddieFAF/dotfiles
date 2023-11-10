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
	base00 = "#11121d",
	base01 = "#1A1B2A",
	base02 = "#212234",
	base03 = "#282c34",
	base04 = "#4a5057",
	base05 = "#a0a8cd",
	base06 = "#a0a8cd",
	base07 = "#a0a8cd",
	base08 = "#ee6d85",
	base09 = "#f6955b",
	base0A = "#d7a65f",
	base0B = "#95c561",
	base0C = "#38a89d",
	base0D = "#7199ee",
	base0E = "#a485dd",
	base0F = "#773440",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-tokyodark-terminal"
end
