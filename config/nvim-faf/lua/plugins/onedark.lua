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
        ending_tildes = false,
        code_style = {
          comments = 'italic',
          keywords = 'bold',
          functions = 'bold',
          strings = 'none',
          variables = 'italic',
        },
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      }
      --      vim.cmd 'colorscheme tokyonight'
    end,
  },
}
