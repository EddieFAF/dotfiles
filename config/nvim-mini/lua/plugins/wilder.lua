return {

    { "gelguy/wilder.nvim", build = ":UpdateRemotePlugins",
  config = function()
-- [[ Setup Wilder Menu ]] ---------------------------------------------------
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

local popupmenu_renderer = wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border = 'rounded',
    highlighter = wilder.basic_highlighter(),
    highlights = { default = "WilderMenu", accent = "WilderAccent" },
    left = {
      ' ',
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = ' a + ',
        icons = { ['+'] = '', a = '', h = '' },
      }),
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar({ thumb_char = ' ' }),
    },
  })
)

local wildmenu_renderer = wilder.wildmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  highlights = { default = "WilderMenu", accent = "WilderAccent" },
  separator = ' · ',
  left = { ' ', wilder.wildmenu_spinner(), ' ' },
  right = { ' ', wilder.wildmenu_index() },
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = popupmenu_renderer,
  ['/'] = wildmenu_renderer,
}))
    end
  }, -- : autocomplete
}
