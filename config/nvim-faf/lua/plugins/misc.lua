return {
  {
    'romgrk/barbar.nvim',
    version = false,
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      auto_hide = true,
      icons = {
        -- Configure the base icons on the bufferline.
        -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
        buffer_index = false,
        buffer_number = false,
        button = '',
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
        gitsigns = {
          added = { enabled = false, icon = '+' },
          changed = { enabled = false, icon = '~' },
          deleted = { enabled = false, icon = '-' },
        },
      },
      sidebar_filetypes = {
        ['neo-tree'] = { event = 'BufWipeout' },
      },
    },
  },

  {
    'folke/flash.nvim',
    enabled = true,
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      label = {
        -- format = function(opts)
        --   return { { opts.match.label:upper(), opts.hl_group } }
        -- end,
      },
      modes = {
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
            -- format = function(opts)
            --   local label = opts.match.label
            --   if opts.after then
            --     label = label .. ">"
            --   else
            --     label = "<" .. label
            --   end
            --   return { { label, opts.hl_group } }
            -- end,
          },
        },
      },
      -- search = { mode = "fuzzy" },
      -- labels = "��������������",
    },
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    lazy = false,
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Undo Tree' },
    },
  },
}
