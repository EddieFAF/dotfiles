return {
  -- Lazy
  {
    'navarasu/onedark.nvim',
    enabled = true,
    lazy = false,
    priority = 1000, -- Ensure it loads first
    config = function()
      require('onedark').setup {
        transparent = false,
        term_colors = true,
        code_style = {
          comments = 'bold,italic',
        },
        diagnostics = {
          darker = true,
          undercurl = true,
        },
      }
      vim.cmd 'colorscheme onedark'
    end,
  },
}
