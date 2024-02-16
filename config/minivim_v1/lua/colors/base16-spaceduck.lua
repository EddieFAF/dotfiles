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
	base00 = "#16172d",
	base01 = "#1b1c36",
	base02 = "#30365F",
	base03 = "#686f9a",
	base04 = "#818596",
	base05 = "#ecf0c1",
	base06 = "#c1c3cc",
	base07 = "#ffffff",
	base08 = "#e33400",
	base09 = "#e39400",
	base0A = "#f2ce00",
	base0B = "#5ccc96",
	base0C = "#00a3cc",
	base0D = "#7a5ccc",
	base0E = "#b3a1e6",
	base0F = "#ce6f8f",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-spaceduck"
end
