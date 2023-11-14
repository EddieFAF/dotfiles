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
	base00 = "#dddfe0",
	base01 = "#cfd1d2",
	base02 = "#c1c3c4",
	base03 = "#a3a5a6",
	base04 = "#474849",
	base05 = "#28292a",
	base06 = "#1a1b1c",
	base07 = "#050608",
	base08 = "#b53b50",
	base09 = "#ea770d",
	base0A = "#c9d364",
	base0B = "#06ea61",
	base0C = "#42fff9",
	base0D = "#03aeff",
	base0E = "#ea5ce2",
	base0F = "#cd6320",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-synth-midnight-light"
end
