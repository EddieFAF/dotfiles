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
      float = {
        padding = 5,
      },
    },
    keys = {
      { "<Leader>o", ":lua require('oil').open_float()<CR>" },
    },
  },
}
