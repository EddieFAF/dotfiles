-- Themes
return {
  -- {
  --   "typicode/bg.nvim",
  -- },
  {
    'folke/tokyonight.nvim',
  },
  {
    "ellisonleao/gruvbox.nvim",
  },
  {
    'joshdick/onedark.vim'
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },

  {
    "rose-pine/nvim",
    name = "rose-pine",
  },
  {
    "sainnhe/everforest",
  },
  {
    "savq/melange-nvim"
  },
  {
    'romgrk/doom-one.vim'
  },
  -- Kanagawa Theme
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require("kanagawa").setup({
        commentStyle = { italic = true },
      })
    end,
  },
}
