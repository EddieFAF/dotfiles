-- Telescope fuzzy finding (all the things)
return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          mappings = {
            n = {
              ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
            },
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<esc>"] = require("telescope.actions").close,
              ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      require('telescope').load_extension 'file_browser'

      local map = require("helpers.keys").map
      map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
      map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
      map("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, "Search in current buffer")

      map("n", "<leader>ff", require("telescope.builtin").find_files, "Find Files")
      map("n", "<leader>fF", "<cmd>Telescope find_files hidden=true cwd=$HOME prompt_title=<~><CR>", "Find Files HOME")
      map("n", "<leader>sh", require("telescope.builtin").help_tags, "Show Help Tags")
      map("n", "<leader>fc", require("telescope.builtin").grep_string, "Current word")
      map("n", "<leader>fs", require("telescope.builtin").live_grep, "Grep all files")
      map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")

      map("n", "gb", require("telescope.builtin").buffers, "Goto Buffer")
      -- telescope git commands
      map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", "Git Commits") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
      map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", "Commits Current") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
      map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", "List Branches") -- list git branches (use <cr> to checkout) ["gb" for git branch]
      map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", "Changes") -- list current changes per file with diff preview ["gs" for git status]

      map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")
      map("n", "<leader>sk", require("telescope.builtin").keymaps, "Search keymaps")
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>fb', '<cmd>Telescope file_browser<CR>', desc = 'Filebrowser' },
      { '<leader>fB', '<cmd>Telescope file_browser hidden=true cwd="$HOME"<CR>', desc ="Filebrowser (Home Dir)" },
    },
  },
}
