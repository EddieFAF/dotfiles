-- Themes
return {
  -- {
  --   "typicode/bg.nvim",
  -- },
  {
    'joshdick/onedark.vim'
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },

  {
    "sainnhe/everforest",
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
