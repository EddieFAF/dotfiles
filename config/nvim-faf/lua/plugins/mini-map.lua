local M = {
  {
    'echasnovski/mini.map',
    config = function()
      local map = require 'mini.map'
      map.setup {
        symbols = {
          encode = require('mini.map').gen_encode_symbols.dot '4x2',
        },
        integrations = {
          require('mini.map').gen_integration.builtin_search(),
          require('mini.map').gen_integration.gitsigns(),
          require('mini.map').gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        },
      }
    end,
    keys = {
      { '<leader>mm', '<Cmd>lua MiniMap.toggle()<CR>',       desc = 'MiniMap toggle' },
      { '<leader>mf', '<Cmd>lua MiniMap.toggle_focus()<CR>', desc = 'MiniMap Focus' },
      { '<leader>ms', '<Cmd>lua MiniMap.toggle_side()<CR>',  desc = 'MiniMap Side' },
    },
  },
}

return M
