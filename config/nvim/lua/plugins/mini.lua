return {
  { "echasnovski/mini.move", version = false },
  {
    "echasnovski/mini.map",
    event = "VeryLazy",
    keys = { { "<leader>um", "<cmd>lua MiniMap.toggle()<cr>", desc = "Toggle Minimap" } },
    config = function(_, opts)
      require("mini.map").setup(opts)
    end,
  },
  { "echasnovski/mini.bracketed", version = false },
}
