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
	base00 = "#010409",
	base01 = "#21262d",
	base02 = "#30363d",
	base03 = "#484f58",
	base04 = "#8b949e",
	base05 = "#b1bac4",
	base06 = "#c9d1d9",
	base07 = "#f0f6fc",
	base08 = "#ff7b72",
	base09 = "#f0883e",
	base0A = "#d29922",
	base0B = "#3fb950",
	base0C = "#a5d6ff",
	base0D = "#58a6ff",
	base0E = "#f778ba",
	base0F = "#bd561d",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-primer-dark"
end
