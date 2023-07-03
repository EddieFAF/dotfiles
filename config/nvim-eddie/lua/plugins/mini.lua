-- Miscelaneous fun stuff
return {
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup()
    end,
  },

  {
    "echasnovski/mini.bufremove",
    event = "VeryLazy",
    config = function()
      require("mini.bufremove").setup()
    end,
  },

  -- Better buffer closing actions. Available via the buffers helper.
--  {
--    "kazhala/close-buffers.nvim",
--    opts = {
--      preserve_window_layout = { "this", "nameless" },
--    },
--  },

  -- Comment with haste
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {},
  },

  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  -- Indentscope
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      --symbol = "│",
      symbol = '┊', -- default ╎, -- alts: ┊│┆ ┊  ▎││ ▏▏
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Move stuff with <M-j> and <M-k> in both normal and visual mode
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    -- config = function()
    --   require("mini.move").setup()
    -- end,
    opts = {
      mappings = {
        line_left = '<M-h>',
        line_right = '<M-l>',
      },
    },
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  {
    'echasnovski/mini.surround',
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        add = 'gza', -- Add surrounding in Normal and Visual modes
        delete = 'gzd', -- Delete surrounding
        find = 'gzf', -- Find surrounding (to the right)
        find_left = 'gzF', -- Find surrounding (to the left)
        highlight = 'gzh', -- Highlight surrounding
        replace = 'gzr', -- Replace surrounding
        update_n_lines = 'gzn', -- Update `n_lines`
      },
    },
  },
--  { 'echasnovski/mini.surround', version = false,
--    config = function()
--      require("mini.surround").setup()
--    end,
--  },
  { 'echasnovski/mini.trailspace', version = false,
    event = "VeryLazy",
    keys = {
      {
        "<leader>uz", ":lua MiniTrailspace.trim()<cr>", desc = "Trail spaces",
      },
    },
    config = function()
      require("mini.trailspace").setup()
    end,
  },


  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "LazyGit",
    keys = {
      {
        "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit",
      },
    },
  },
}
