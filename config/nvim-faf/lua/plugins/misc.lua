return {
  {
    'romgrk/barbar.nvim',
    version = false,
    enabled = false,
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      --    'nvim-tree/nvim-web-devicons',
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
    'nvim-tree/nvim-web-devicons',
    enabled = false,
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    lazy = false,
    keys = {
      { '<leader>uu', '<cmd>UndotreeToggle<CR>', desc = 'Undo Tree' },
    },
  },
}
