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
	base00 = "#1B2B34",
	base01 = "#343D46",
	base02 = "#4F5B66",
	base03 = "#65737E",
	base04 = "#A7ADBA",
	base05 = "#C0C5CE",
	base06 = "#CDD3DE",
	base07 = "#D8DEE9",
	base08 = "#EC5f67",
	base09 = "#F99157",
	base0A = "#FAC863",
	base0B = "#99C794",
	base0C = "#5FB3B3",
	base0D = "#6699CC",
	base0E = "#C594C5",
	base0F = "#AB7967",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-oceanicnext"
end
