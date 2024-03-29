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
    'echasnovski/mini.base16',
    enabled = false,
    version = false,
    config = function()
      require('mini.base16').setup {
        palette = {
          base00 = '#1E2127',
          base01 = '#BE5046',
          base02 = '#98C379',
          base03 = '#D19A66',
          base04 = '#61AFEF',
          base05 = '#8A3FA0',
          base06 = '#2B6F77',
          base07 = '#ABB2BF',
          base08 = '#5C6370',
          base09 = '#E06C75',
          base0A = '#BAE59B',
          base0B = '#E5C07B',
          base0C = '#83CFFF',
          base0D = '#C678DD',
          base0E = '#56B6C2',
          base0F = '#FFFFFF',
        },
        use_cterm = true,
      }
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
      symbol = '▏',
      --symbol = "│",
      --symbol = '┊', -- default ╎, -- alts: ┊│┆ ┊  ▎││ ▏▏
      options = {
        try_as_border = true,
        border = 'both',
        indent_at_cursor = true,
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
      -- Colors
      -- vim.cmd 'hi MiniTablineCurrent gui=underline guifg=#83a598'
      -- vim.cmd 'hi MiniTablineVisible guifg=#83a598'
      -- vim.cmd 'hi MiniTablineModifiedCurrent gui=underline guifg=#af6f81'
      -- vim.cmd 'hi MiniTablineModifiedHidden gui=underline guifg=#af6f81'
    end,
  },
}

return M
