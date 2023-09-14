-- Tokyonight Theme
return {
  {
    'folke/tokyonight.nvim',
    enabled = false,
    lazy = false,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        light_style = 'day',
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = 'dark',
          floats = 'dark',
        },
        hide_inactive_statusline = false,
        dim_inactive = true,
        lualine_bold = true,
      }
      vim.cmd 'colorscheme tokyonight'
    end,
  },
}
