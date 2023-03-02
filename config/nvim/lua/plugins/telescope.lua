return {

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  },
}
