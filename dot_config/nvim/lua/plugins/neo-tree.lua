return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
        },
      },
    },
    window = {
      position = "left",
      width = 35,
    },
  },
}
