# gruvbox dark hard qutebrowser theme by Florian Bruhin <me@the-compiler.org>
#
# Originally based on:
#   base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
#   Base16 qutebrowser template by theova and Daniel Mulford
#   Gruvbox dark, hard scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)


base00 = "#1C1F24"
base01 = "#FF6C6B"
base02 = "#98BE65"
base03 = "#DA8548"
base04 = "#51AFEF"
base05 = "#C678DD"
base06 = "#5699AF"
base07 = "#ABB2BF"
base08 = "#5B6268"
base09 = "#DA8548"
base10 = "#4DB5BD"
base11 = "#ECBE7B"
base12 = "#3071DB"
base13 = "#A9A1E1"
base14 = "#46D9FF"
base15 = "#DFDFDF"

basefg = "#BBC2CF"
basebg = "#282C34"
basebg2 = "#181C24"

bg1 = "#3c3836"
bg2 = "#504945"
bg3 = "#665c54"
bg4 = "#7c6f64"

fg0 = "#fbf1c7"
fg2 = "#d5c4a1"
fg3 = "#bdae93"

bright_gray = "#928374"
bright_orange = "#fe8019"


### Completion

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = [basefg, base14, base11]

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = basebg

# Background color of the completion widget for even rows.
#c.colors.completion.even.bg = c.colors.completion.odd.bg
c.colors.completion.even.bg = basebg2

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base02

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base00

# Top border color of the completion widget category headers.
#c.colors.completion.category.border.top = c.colors.completion.category.bg
c.colors.completion.category.border.top = base02

# Bottom border color of the completion widget category headers.
#c.colors.completion.category.border.bottom = c.colors.completion.category.bg
c.colors.completion.category.border.bottom = base02

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base15

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = base00

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = basebg

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = c.colors.completion.item.selected.border.top

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = basebg

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base09

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base00

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = basebg

### Context menu

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = basebg

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = base07

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = basebg

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg = base12

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = base12

#Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = basebg

### Downloads

# Background color for the download bar.
c.colors.downloads.bar.bg = basebg

# Color gradient start for download text.
c.colors.downloads.start.fg = basebg

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base02

# Color gradient end for download text.
c.colors.downloads.stop.fg = basebg

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base02

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

### Hints

# Font color for hints.
c.colors.hints.fg = basefg

# Background color for hints.
c.colors.hints.bg = basebg

# Font color for the matched part of hints.
c.colors.hints.match.fg = basebg

### Keyhint widget

# Text color for the keyhint widget.
c.colors.keyhint.fg = base11

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = basefg

# Background color of the keyhint widget.
c.colors.keyhint.bg = basebg

### Messages

# Foreground color of an error message.
c.colors.messages.error.fg = basebg

# Background color of an error message.
c.colors.messages.error.bg = base01

# Border color of an error message.
c.colors.messages.error.border = base01

# Foreground color of a warning message.
c.colors.messages.warning.fg = basebg

# Background color of a warning message.
c.colors.messages.warning.bg = base03

# Border color of a warning message.
c.colors.messages.warning.border = base03

# Foreground color of an info message.
c.colors.messages.info.fg = basefg

# Background color of an info message.
c.colors.messages.info.bg = basebg

# Border color of an info message.
c.colors.messages.info.border = basebg

### Prompts

# Foreground color for prompts.
c.colors.prompts.fg = basefg

# Border used around UI elements in prompts.
c.colors.prompts.border = basebg

# Background color for prompts.
c.colors.prompts.bg = basebg

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base07

### Statusbar

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = basefg

# Background color of the statusbar.
c.colors.statusbar.normal.bg = basebg

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = base01

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = basebg

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base11

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = basebg

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base04

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = basebg

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = basefg

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = basebg

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = basebg

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base02

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = basebg

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base05

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = basebg

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base04

# Background color of the progress bar.
c.colors.statusbar.progress.bg = base01

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = base07

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = base01

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = bright_orange

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = base09

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = base02

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = base01

### tabs

# Background color of the tab bar.
c.colors.tabs.bar.bg = basebg

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base04

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base06

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base01

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = basefg

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = basebg

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = basefg

# Background color of unselected even tabs.
c.colors.tabs.even.bg = basebg

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = basefg

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base08

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = basefg

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base08

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = base06

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = basefg

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = base06

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = basefg

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = base08

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = basebg

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = base08

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = basebg

# Background color for webpages if unset (or empty to use the theme's
# color).
c.colors.webpage.bg = bg4
