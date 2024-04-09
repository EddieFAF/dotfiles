return {
  {
    "rebelot/heirline.nvim",
    lazy = false,
    dependencies = {
      "linrongbin16/lsp-progress.nvim",
    },
    config = function()
      require("heirline").setup({
      --  winbar = require("config.heirline.winbar"),
        statusline = require("config.heirline.statusline"),
        statuscolumn = require("config.heirline.statuscolumn"),
        opts = {
          disable_winbar_cb = function(args)
            local conditions = require("heirline.conditions")

            return conditions.buffer_matches({
              buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
              filetype = { "alpha", "oil", "lspinfo", "toggleterm" },
            }, args.buf)
          end,
        },
      })
    end,
  },
  {
    "linrongbin16/lsp-progress.nvim",
    lazy = true,
    config = function()
      require("lsp-progress").setup({})
    end,
  },

}
