vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

local M = {
  {
    'SmiteshP/nvim-navic',
    opts = function()
      return {
        --  separator = '  ',
        highlight = true,
        depth_limit = 4,
        icons = {
          File = '󰈙 ',
          Module = ' ',
          Namespace = '󰌗 ',
          Package = ' ',
          Class = '󰌗 ',
          Method = '󰆧 ',
          Property = ' ',
          Field = ' ',
          Constructor = ' ',
          Enum = '󰕘',
          Interface = '󰕘',
          Function = '󰊕 ',
          Variable = '󰆧 ',
          Constant = '󰏿 ',
          String = '󰀬 ',
          Number = '󰎠 ',
          Boolean = '◩ ',
          Array = '󰅪 ',
          Object = '󰅩 ',
          Key = '󰌋 ',
          Null = '󰟢 ',
          EnumMember = ' ',
          Struct = '󰌗 ',
          Event = ' ',
          Operator = '󰆕 ',
          TypeParameter = '󰊄 ',
        },
      }
    end,
  },
}

return M
