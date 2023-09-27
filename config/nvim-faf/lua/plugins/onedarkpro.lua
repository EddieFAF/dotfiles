return {
  -- Lazy
  {
    'olimorris/onedarkpro.nvim',
    enabled = false,
    lazy = false,
    priority = 1000, -- Ensure it loads first
    config = function()
      require('onedarkpro').setup {
        styles = {
          comment = 'bold,italic',
        },
        options = {
          cursorline = true,
          highlight_inactive_windows = true,
        },
      }
      vim.cmd 'colorscheme onedark'
    end,
  },
}
