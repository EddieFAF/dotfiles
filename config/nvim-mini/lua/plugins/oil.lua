return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<Esc>"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 5,
        max_width = 0,
        max_height = 0,
        border = "single",
        win_options = {
          winblend = 0,
        },
      },
    },
    keys = {
      { "<Leader>o", ":lua require('oil').open_float()<CR>" },
    },
  },
}
