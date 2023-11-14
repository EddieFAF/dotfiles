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
	base00 = "#262626",
	base01 = "#3a3a3a",
	base02 = "#4e4e4e",
	base03 = "#8a8a8a",
	base04 = "#949494",
	base05 = "#dab997",
	base06 = "#d5c4a1",
	base07 = "#ebdbb2",
	base08 = "#d75f5f",
	base09 = "#ff8700",
	base0A = "#ffaf00",
	base0B = "#afaf00",
	base0C = "#85ad85",
	base0D = "#83adad",
	base0E = "#d485ad",
	base0F = "#d65d0e",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-gruvbox-dark-pale"
end
