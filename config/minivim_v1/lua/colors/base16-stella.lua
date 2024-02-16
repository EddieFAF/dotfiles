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
	base00 = "#2B213C",
	base01 = "#362B48",
	base02 = "#4D4160",
	base03 = "#655978",
	base04 = "#7F7192",
	base05 = "#998BAD",
	base06 = "#B4A5C8",
	base07 = "#EBDCFF",
	base08 = "#C79987",
	base09 = "#8865C6",
	base0A = "#C7C691",
	base0B = "#ACC79B",
	base0C = "#9BC7BF",
	base0D = "#A5AAD4",
	base0E = "#C594FF",
	base0F = "#C7AB87",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-stella"
end
