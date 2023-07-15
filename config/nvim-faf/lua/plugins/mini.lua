-- Miscelaneous fun stuff
return {

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

  -- Indentscope
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- symbol = "▏",
      --symbol = "│",
      symbol = '┊', -- default ╎, -- alts: ┊│┆ ┊  ▎││ ▏▏
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
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
    'echasnovski/mini.statusline',
    version = false,
    lazy = false,
    enabled = true,
    config = function()
      require('mini.statusline').setup {
        content = {
          active = function()
            -- stylua: ignore start
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local spell         = vim.wo.spell and
                (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or ''
            local wrap          = vim.wo.wrap and
                (MiniStatusline.is_truncated(120) and 'W' or 'WRAP') or ''
            local git           = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({
              trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local searchcount   = MiniStatusline.section_searchcount({
              trunc_width = 75 })
            local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local location2     = "%7(%l/%3L%):%2c %P"
            local lazy_updates  = require("lazy.status").updates



            return MiniStatusline.combine_groups({
              { hl = mode_hl,                 strings = { mode, spell, wrap } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = mode_hl,                  strings = { lazy_updates() } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = 'MoreMsg',                strings = { searchcount } },
              { hl = mode_hl,                  strings = { location2 } },
            })
          end,
        },
        use_icons = true,
        set_vim_settings = false,
      }
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'LazyGit',
    keys = {
      {
        '<leader>gg',
        '<cmd>LazyGit<CR>',
        desc = 'LazyGit',
      },
    },
  },
}
