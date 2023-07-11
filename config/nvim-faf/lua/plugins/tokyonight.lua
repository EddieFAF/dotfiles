-- Tokyonight Theme
return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    config = function()
    require("tokyonight").setup({
      transparent = false,
      styles = {
        comments = { italic = true },
        sidebars = "dark",
        floats = "transparent",
      },
    })
    vim.cmd('colorscheme tokyonight-moon')
    end,
  },

}

