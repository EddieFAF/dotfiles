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
	base00 = "#18262F",
	base01 = "#222E38",
	base02 = "#586875",
	base03 = "#667581",
	base04 = "#85939E",
	base05 = "#A6AFB8",
	base06 = "#E8E9ED",
	base07 = "#F5F7FA",
	base08 = "#EF5253",
	base09 = "#E66B2B",
	base0A = "#E4B51C",
	base0B = "#7CC844",
	base0C = "#52CBB0",
	base0D = "#33B5E1",
	base0E = "#A363D5",
	base0F = "#D73C9A",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-solarflare"
end
