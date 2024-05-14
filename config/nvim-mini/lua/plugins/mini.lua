--[[

******************************************************************************
* mini.lua                                                                   *
* mini.nvim configuration based on plugin from echasnovski                   *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.1                                                                *
* initial release                                                            *
******************************************************************************

--]]


-- Starting setup of plugins
return {
  -- The star of the show
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- [[ AI ]] ------------------------------------------------------------------
      require("mini.ai").setup()

      -- [[ Animate ]] -------------------------------------------------------------
      require("mini.animate").setup {
        scroll = {
          enable = false,
        },
      }

      -- [[ Collection of basic options ]] -----------------------------------------
      require("mini.basics").setup({
        options = {
          basic = true,
          extra_ui = true,
          win_borders = "single",
        },
        mappings = {
          basic = true,
          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          --option_toggle_prefix = [[\]],
          option_toggle_prefix = ",",
          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = true,
          -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
          move_with_alt = false,
        },
        autocommands = {
          -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
          basic = true,
          -- Set 'relativenumber' only in linewise and blockwise Visual mode
          relnum_in_visual_mode = true,
        },
        -- Whether to disable showing non-error feedback
        silent = false,
      })

      -- [[ Bracketed ]] -----------------------------------------------------------
      require("mini.bracketed").setup()
      -- [[ Bufremove ]] -----------------------------------------------------------
      require("mini.bufremove").setup()
      vim.keymap.set("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })
      vim.keymap.set("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(0,  true)<CR>", { desc = "Delete! buffer" })

      vim.keymap.set("n", "<leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", { desc = "Wipeout buffer" })
      vim.keymap.set("n", "<leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", { desc = "Wipeout! buffer" })

      -- [[ Clues (Whichkey replacement) ]] ----------------------------------------
      local hints = {}
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- mini.basics
          { mode = 'n', keys = [[\]] },

          -- mini.bracketed
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
          { mode = 'x', keys = '[' },
          { mode = 'x', keys = ']' },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.z(),

          hints,

          miniclue.gen_clues.windows({
            submode_move = true,
            submode_navigate = true,
            submode_resize = true,
          }),

          { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
          { mode = "n", keys = "<Leader>c", desc = "+Code" },
          { mode = "n", keys = "<Leader>d", desc = "+Document" },
          { mode = "n", keys = "<Leader>e", desc = "+Explorer" },
          --{ mode = "n", keys = "<Leader>w", desc = "+Workspace" },
          { mode = "n", keys = "<Leader>f", desc = "+Find" },
          { mode = "n", keys = "<Leader>g", desc = "+Git" },
          { mode = "n", keys = "<Leader>l", desc = "+LSP" },
          --{ mode = "n", keys = "<Leader>m", desc = "+Minimap" },
          { mode = "n", keys = "<Leader>s", desc = "+Windows" },
          --{ mode = "n", keys = "<Leader>u", desc = "+UI" },
          { mode = "n", keys = "<Leader>x", desc = "+Trouble" },
          { mode = "n", keys = "<Leader>/", desc = "+FZF" },
        },
        window = {
          config = {
            anchor = "SE",
            row = "auto",
            col = "auto",
            width = "auto",
            border = "single",
          },
          delay = 0,
        },
      })

      -- [[ 'gc' to toggle comment ]] ----------------------------------------------
      require("mini.comment").setup()

      -- [[ Completion ]] ----------------------------------------------------------

      -- require("mini.completion").setup({
      --   lsp_completion = {
      --     source_func = 'omnifunc',
      --     auto_setup = false,
      --     process_items = function(items, base)
      --       -- Don't show 'Text' and 'Snippet' suggestions
      --       items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
      --       return MiniCompletion.default_process_items(items, base)
      --     end,
      --   },
      --   window = {
      --     info = { height = 25, width = 80, border = "rounded" },
      --     signature = { height = 25, width = 80, border = "rounded" },
      --   },
      -- })
      --
      -- vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
      -- vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
      -- local keys = {
      --   ["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
      --   ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
      --   ["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
      -- }
      --
      -- _G.cr_action = function()
      --   if vim.fn.pumvisible() ~= 0 then
      --     -- If popup is visible, confirm selected item or add new line otherwise
      --     local item_selected = vim.fn.complete_info()["selected"] ~= -1
      --     return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
      --   else
      --     -- If popup is not visible, use plain `<CR>`. You might want to customize
      --     -- according to other plugins. For example, to use 'mini.pairs', replace
      --     -- next line with `return require('mini.pairs').cr()`
      --     return keys["cr"]
      --   end
      -- end
      --
      -- vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

      -- [[ Mini Cursorword ]] -----------------------------------------------------
      require("mini.cursorword").setup()

      -- [[ Mini.Extras ]] ---------------------------------------------------------
      require("mini.extra").setup()

      -- [[ Files ]] ---------------------------------------------------------------
      require("mini.files").setup({
        mappings = {
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
          reset = "",
          show_help = "?",
        },

        -- Only automated preview is possible
        windows = {
          preview = true, width_focus = 30, width_preview = 60, height_focus = 20, max_number = math.huge
        },
      })


      vim.keymap.set("n", "<leader>.", function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ':p')

          if path and vim.uv.fs_stat(path) then
            require('mini.files').open(bufname, false)
          end
        end,
        { desc = 'File Explorer' })

      vim.keymap.set("n", "<leader>ed", "<cmd>lua MiniFiles.open()<cr>", { desc = "Find Manual" })
      vim.keymap.set('n', '<leader>ef', [[<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>]],
        { desc = 'File directory' })
      vim.keymap.set('n', '<leader>em', [[<Cmd>lua MiniFiles.open('~/.config/nvim')<CR>]],
        { desc = 'Mini.nvim directory' })

      -- [[ Fuzzy ]] ---------------------------------------------------------------
      require("mini.fuzzy").setup()

      -- [[ HiPatterns ]] ----------------------------------------------------------
      local hi = require("mini.hipatterns")
      hi.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          hex_color = hi.gen_highlighter.hex_color(),
        },
      })

      -- [[ Color Palette ]] -------------------------------------------------------
      --require('mini.hues').setup({ background = '#282c34', foreground = '#c8ccd4' }) -- blue

      -- [[ Animated indentation guide ]] ------------------------------------------
      require("mini.indentscope").setup({
        symbol = "│",
        --symbol = "▏",
        options = {
          try_as_border = true,
          border = "both",
          indent_at_cursor = true,
        },
        draw = {
          animation = function() return 1 end,
        },
      })

      -- [[ Jump2d ]] --------------------------------------------------------------
      require("mini.jump2d").setup({
        view = {
          dim = true,
        },
      })
      vim.keymap.set("n", "gl", "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<cr>",
        { desc = "Jump2d Line Start" })
      vim.keymap.set("n", "gm", "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<cr>",
        { desc = "Jump2d Word Start" })
      vim.keymap.set("n", "g!", function()
        MiniJump2d.start({
          spotter = MiniJump2d.gen_pattern_spotter("['\"`]"),
        })
      end, { desc = "Jump2d Quote" })

      -- [[ Jump ]] --------------------------------------------------------------
      require("mini.jump").setup({})

      -- [[ Move ]] ----------------------------------------------------------------
      require("mini.move").setup()

      -- [[ Notify ]] --------------------------------------------------------------
      require("mini.notify").setup({
        -- Notifications about LSP progress
        lsp_progress = {
          -- Whether to enable showing
          enable = true,
          -- Duration (in ms) of how long last message should be shown
          duration_last = 1000,
        },
      })
      vim.notify = require('mini.notify').make_notify()

      -- [[ Pairs ]] ---------------------------------------------------------------
      require("mini.pairs").setup()

      -- [[ Configure Mini.pick ]] -------------------------------------------------
      local win_config = function()
        height = math.floor(0.618 * vim.o.lines)
        width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW',
          height = height,
          width = width,
          border = 'rounded',
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end
      require("mini.pick").setup({
        mappings = {
          choose_in_vsplit = '<C-CR>',
        },
        options = {
          use_cache = true,
        },
        window = {
          config = win_config,
        },
      })
      vim.ui.select = MiniPick.ui_select

      vim.keymap.set("n", "<leader><space>", MiniPick.builtin.buffers, { desc = "Find existing buffers" })

      vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Find Help" })
      vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Find by Grep" })
      vim.keymap.set("n", "<leader>fr", MiniPick.builtin.resume, { desc = "Resume" })
      vim.keymap.set("n", "<leader>fe", MiniExtra.pickers.explorer, { desc = "Explorer" })
      vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps, { desc = "Keymaps" })
      --vim.keymap.set("n", "<leader>fr", MiniExtra.pickers.oldfiles, { desc = "Find Recent Files" })
      vim.keymap.set('n', '<leader>f/', [[<Cmd>Pick history scope='/'<CR>]], { desc = '"/" history' })
      vim.keymap.set('n', '<leader>f:', [[<Cmd>Pick history scope=':'<CR>]], { desc = '":" history' })
      vim.keymap.set('n', '<leader>fA', [[<Cmd>Pick git_hunks scope='staged'<CR>]], { desc = 'Added hunks (all)' })
      vim.keymap.set('n', '<leader>fa', [[<Cmd>Pick git_hunks path='%' scope='staged'<CR>]],
        { desc = 'Added hunks (current)' })
      vim.keymap.set('n', '<leader>fb', [[<Cmd>Pick buffers<CR>]], { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fC', [[<Cmd>Pick git_commits<CR>]], { desc = 'Commits (all)' })
      vim.keymap.set('n', '<leader>fc', [[<Cmd>Pick git_commits path='%'<CR>]], { desc = 'Commits (current)' })
      vim.keymap.set('n', '<leader>fD', [[<Cmd>Pick diagnostic scope='all'<CR>]], { desc = 'Diagnostic workspace' })
      vim.keymap.set('n', '<leader>fd', [[<Cmd>Pick diagnostic scope='current'<CR>]], { desc = 'Diagnostic buffer' })
      vim.keymap.set('n', '<leader>fG', [[<Cmd>Pick grep pattern='<cword>'<CR>]], { desc = 'Grep current word' })
      vim.keymap.set('n', '<leader>fH', [[<Cmd>Pick hl_groups<CR>]], { desc = 'Highlight groups' })
      vim.keymap.set('n', '<leader>fL', [[<Cmd>Pick buf_lines scope='all'<CR>]], { desc = 'Lines (all)' })
      vim.keymap.set('n', '<leader>fl', [[<Cmd>Pick buf_lines scope='current'<CR>]], { desc = 'Lines (current)' })
      vim.keymap.set('n', '<leader>fM', [[<Cmd>Pick git_hunks<CR>]], { desc = 'Modified hunks (all)' })
      vim.keymap.set('n', '<leader>fm', [[<Cmd>Pick git_hunks path='%'<CR>]], { desc = 'Modified hunks (current)' })
      vim.keymap.set('n', '<leader>fR', [[<Cmd>Pick lsp scope='references'<CR>]], { desc = 'References (LSP)' })
      vim.keymap.set('n', '<leader>fS', [[<Cmd>Pick lsp scope='workspace_symbol'<CR>]],
        { desc = 'Symbols workspace (LSP)' })
      vim.keymap.set('n', '<leader>fs', [[<Cmd>Pick lsp scope='document_symbol'<CR>]], { desc = 'Symbols buffer (LSP)' })
      vim.keymap.set('n', '<leader>fV', [[<Cmd>Pick visit_paths cwd=''<CR>]], { desc = 'Visit paths (all)' })
      vim.keymap.set('n', '<leader>fv', [[<Cmd>Pick visit_paths<CR>]], { desc = 'Visit paths (cwd)' })


      -- [[ Starter ]] -------------------------------------------------------------
      --      require("mini.starter").setup()

      -- [[ Tabline ]] -------------------------------------------------------------
      --require("mini.tabline").setup()

      -- [[ Trailspace ]] ----------------------------------------------------------
      require("mini.trailspace").setup()

      -- [[ Visits ]] --------------------------------------------------------------
      require("mini.visits").setup()
    end,
  }
}

-- vim: ts=2 sts=2 sw=2 et
