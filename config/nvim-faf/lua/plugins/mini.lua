-- Miscelaneous fun stuff
local M = {

  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup()
    end,
  },

  {
    'echasnovski/mini.animate',
    event = 'VeryLazy',
    config = function()
      require('mini.animate').setup()
    end,
  },

  {
    'echasnovski/mini.bracketed',
    event = 'VeryLazy',
    config = function()
      require('mini.bracketed').setup()
    end,
  },

  {
    'echasnovski/mini.bufremove',
    opts = {},
    keys = {
      {
        '<leader>bd',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
    },
  },

  -- Comment with haste
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'echasnovski/mini.cursorword',
    event = 'VeryLazy',
    config = function()
      require('mini.cursorword').setup()
    end,
  },

  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local hi = require 'mini.hipatterns'
      return {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
    end,
  },

  -- Indentscope
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- symbol = "▏",
      --symbol = "│",
      symbol = '┊', -- default ╎, -- alts: ┊│┆ ┊  ▎││ ▏▏
      options = {
        try_as_border = true,
        border = 'both',
        indent_at_cursor = false,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'NvimTree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Move stuff with <M-j> and <M-k> in both normal and visual mode
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    -- config = function()
    --   require("mini.move").setup()
    -- end,
    opts = {
      mappings = {
        line_left = '<M-h>',
        line_right = '<M-l>',
      },
    },
  },

  {
    'echasnovski/mini.tabline',
    event = 'VeryLazy',
    enabled = false,
    config = function()
      require('mini.tabline').setup()
    end,
  },
}

return M
