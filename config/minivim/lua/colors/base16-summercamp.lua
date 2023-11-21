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
	base00 = "#1c1810",
	base01 = "#2a261c",
	base02 = "#3a3527",
	base03 = "#504b38",
	base04 = "#5f5b45",
	base05 = "#736e55",
	base06 = "#bab696",
	base07 = "#f8f5de",
	base08 = "#e35142",
	base09 = "#fba11b",
	base0A = "#f2ff27",
	base0B = "#5ceb5a",
	base0C = "#5aebbc",
	base0D = "#489bf0",
	base0E = "#FF8080",
	base0F = "#F69BE7",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-summercamp"
end
