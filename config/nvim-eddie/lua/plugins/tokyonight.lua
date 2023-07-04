-- Tokyonight Theme
return {
  {
    "folke/tokyonight.nvim",
    -- enabled = false,
    config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        comments = { italic = false },
        sidebars = "dark",
        floats = "transparent",
      },
    })
    vim.cmd('colorscheme tokyonight-moon')
    end,
  },

}

