return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function(_, _)
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
      }
    end,
  },
}
