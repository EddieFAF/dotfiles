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
	base00 = "#161b1d",
	base01 = "#1f292e",
	base02 = "#516d7b",
	base03 = "#5a7b8c",
	base04 = "#7195a8",
	base05 = "#7ea2b4",
	base06 = "#c1e4f6",
	base07 = "#ebf8ff",
	base08 = "#d22d72",
	base09 = "#935c25",
	base0A = "#8a8a0f",
	base0B = "#568c3b",
	base0C = "#2d8f6f",
	base0D = "#257fad",
	base0E = "#6b6bb8",
	base0F = "#b72dd2",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-atelier-lakeside"
end
