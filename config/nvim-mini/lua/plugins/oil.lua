return {
  {
    "stevearc/oil.nvim",
    lazy = false,
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
        ["q"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 5,
        max_width = 90,
        max_height = 0,
        border = "single",
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}
