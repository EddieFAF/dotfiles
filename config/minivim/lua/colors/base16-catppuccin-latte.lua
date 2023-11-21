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
	base00 = "#eff1f5",
	base01 = "#e6e9ef",
	base02 = "#ccd0da",
	base03 = "#bcc0cc",
	base04 = "#acb0be",
	base05 = "#4c4f69",
	base06 = "#dc8a78",
	base07 = "#7287fd",
	base08 = "#d20f39",
	base09 = "#fe640b",
	base0A = "#df8e1d",
	base0B = "#40a02b",
	base0C = "#179299",
	base0D = "#1e66f5",
	base0E = "#8839ef",
	base0F = "#dd7878",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-catppuccin-latte"
end
