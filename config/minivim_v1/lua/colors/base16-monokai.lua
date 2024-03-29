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
	base00 = "#272822",
	base01 = "#383830",
	base02 = "#49483e",
	base03 = "#75715e",
	base04 = "#a59f85",
	base05 = "#f8f8f2",
	base06 = "#f5f4f1",
	base07 = "#f9f8f5",
	base08 = "#f92672",
	base09 = "#fd971f",
	base0A = "#f4bf75",
	base0B = "#a6e22e",
	base0C = "#a1efe4",
	base0D = "#66d9ef",
	base0E = "#ae81ff",
	base0F = "#cc6633",
}

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = "base16-monokai"
end
