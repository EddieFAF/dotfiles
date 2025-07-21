return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- [[ AI ]] ------------------------------------------------------------
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- [[ Basics ]] ----------------------------------------------------------
      require('mini.basics').setup {
        options = {
          basic = true,
          extra_ui = true,
          win_borders = 'rounded',
        },
        mappings = {
          basic = true,
          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          --option_toggle_prefix = [[\]],
          option_toggle_prefix = '',
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
      }

      -- [[ Bufremove ]] ----------------------------------------------------------
      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>bd', '<Cmd>lua MiniBufremove.delete()<CR>', { desc = 'Delete buffer' })
      vim.keymap.set('n', '<leader>bD', '<Cmd>lua MiniBufremove.delete(0,  true)<CR>', { desc = 'Delete! buffer' })

      vim.keymap.set('n', '<leader>bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', { desc = 'Wipeout buffer' })
      vim.keymap.set('n', '<leader>bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', { desc = 'Wipeout! buffer' })

      -- [[ Clues (Whichkey replacement) ]] ----------------------------------------
      local hints = {}
      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- mini.basics
          { mode = 'n', keys = [[\]] },

          -- mini.bracketed
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
          { mode = 'x', keys = '[' },
          { mode = 'x', keys = ']' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          { mode = 'n', keys = 's' },
          { mode = 'x', keys = 's' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.z(),

          hints,

          miniclue.gen_clues.windows {
            submode_move = true,
            submode_navigate = true,
            submode_resize = true,
          },

          { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
          { mode = 'n', keys = '<Leader>s', desc = '+Search' },
          { mode = 'n', keys = '<Leader>h', desc = '+Git' },
          { mode = 'v', keys = '<Leader>h', desc = '+Git' },
          { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
          { mode = 'n', keys = '<Leader>e', desc = '+Explorer' },
          { mode = 'n', keys = '<Leader>u', desc = '+UI' },
          -- { mode = "n", keys = "<Leader>/", desc = "+FZF" },
          { mode = 'n', keys = 'gr', desc = '+LSP' },
        },
        window = {
          config = {
            anchor = 'SE',
            row = 'auto',
            col = 'auto',
            width = 'auto',
            border = 'rounded',
          },
          delay = 0,
        },
      }
      -- [[ Cursorword ]] ----------------------------------------------------------
      require('mini.cursorword').setup()

      require('mini.extra').setup()
      -- [[ Files ]] ---------------------------------------------------------------
      require('mini.files').setup {
        mappings = {
          close = 'q',
          go_in = 'L',
          go_in_plus = 'l',
          go_out = 'H',
          go_out_plus = 'h',
          reset = ',',
          show_help = '?',
          synchronize = 'w',
        },

        -- Only automated preview is possible
        windows = {
          --          preview = true,
          width_focus = 40,
          width_preview = 75,
          height_focus = 20,
          max_number = math.huge,
        },
      }
      local show_dotfiles = true

      local filter_show = function(fs_entry)
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      local gio_open = function()
        local fs_entry = require('mini.files').get_fs_entry()
        vim.notify(vim.inspect(fs_entry))
        vim.fn.system(string.format("gio open '%s'", fs_entry.path))
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require('mini.files').refresh { content = { filter = new_filter } }
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
          vim.keymap.set('n', '-', require('mini.files').close, { buffer = buf_id })
          vim.keymap.set('n', 'o', gio_open, { buffer = buf_id })
        end,
      })

      -- Preview toggle
      local show_preview = false

      local toggle_preview = function()
        show_preview = not show_preview
        require('mini.files').refresh { windows = { preview = show_preview } }
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', '<M-p>', toggle_preview, { buffer = buf_id })
        end,
      })

      local minifiles_augroup = vim.api.nvim_create_augroup('ec-mini-files', {})
      vim.api.nvim_create_autocmd('User', {
        group = minifiles_augroup,
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
          vim.api.nvim_win_set_config(args.data.win_id, { border = 'single' })
        end,
      })

      vim.keymap.set('n', '<leader>ed', '<cmd>lua MiniFiles.open()<cr>', { desc = 'Find Manual' })
      vim.keymap.set('n', '<leader>ef', [[<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>]], { desc = 'File directory' })
      vim.keymap.set('n', '<leader>em', [[<Cmd>lua MiniFiles.open('~/.config/nvim')<CR>]], { desc = 'Mini.nvim directory' })

      -- [[ Fuzzy ]] ---------------------------------------------------------------
      require('mini.fuzzy').setup()

      -- [[ Hipatterns ]] ----------------------------------------------------------
      local hi = require 'mini.hipatterns'
      hi.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          hex_color = hi.gen_highlighter.hex_color(),
        },
      }

      local miniicons = require 'mini.icons'
      miniicons.setup {
        style = 'glyph',
      }
      miniicons.mock_nvim_web_devicons()
      miniicons.tweak_lsp_kind()

      -- Indentscope Plugin
      require('mini.indentscope').setup {
        draw = {
          animation = function()
            return 1
          end,
        },
        symbol = '│',
        --symbol = "▏",
        options = {
          try_as_border = true,
          border = 'both',
          indent_at_cursor = true,
        },
      }

      -- [[ Jump2d ]] ----------------------------------------------------------
      require('mini.jump2d').setup {
        labels = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        view = {
          dim = true,
          n_steps_ahead = 2,
        },
      }

      -- [[ Move ]] ------------------------------------------------------------
      require('mini.move').setup()

      -- [[ Notify ]] ----------------------------------------------------------
      local mininotify = require 'mini.notify'
      local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif)
          return not vim.startswith(notif.msg, 'lua_ls: Diagnosing')
        end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return mininotify.default_sort(notif_arr)
      end
      mininotify.setup {
        content = { sort = filterout_lua_diagnosing },
        window = { config = { row = 2, border = 'rounded' } },
      }

      vim.notify = require('mini.notify').make_notify()

      -- [[ Pairs ]] ----------------------------------------------------------
      require('mini.pairs').setup()

      -- [[ Picker ]] ----------------------------------------------------------
      -- local minipick = require 'mini.pick'
      -- local miniextra = require 'mini.extra'
      -- local win_config = function()
      --   height = math.floor(0.618 * vim.o.lines)
      --   width = math.floor(0.618 * vim.o.columns)
      --   return {
      --     anchor = 'NW',
      --     height = height,
      --     width = width,
      --     border = 'rounded',
      --     row = math.floor(0.5 * (vim.o.lines - height)),
      --     col = math.floor(0.5 * (vim.o.columns - width)),
      --   }
      -- end
      -- minipick.setup {
      --   mappings = {
      --     choose_in_vsplit = '<C-CR>',
      --   },
      --   options = {
      --     use_cache = true,
      --   },
      --   window = {
      --     config = win_config,
      --   },
      -- }
      --
      -- vim.ui.select = minipick.ui_select
      --
      -- [[ Surround ]] ----------------------------------------------------------
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- [[ Starter ]] -------------------------------------------------------------
      local logo = table.concat({
        '     _____  .__       .______   ____.__             ',
        '    /     \\ |__| ____ |__\\   \\ /   /|__| _____   ',
        '   /  \\ /  \\|  |/    \\|  |\\   Y   / |  |/     \\  ',
        '  /    Y    \\  |   |  \\  | \\     /  |  |  Y Y  \\ ',
        '  \\____|__  /__|___|  /__|  \\___/   |__|__|_|  / ',
        '          \\/        \\/                       \\/  ',
        '',
        'Pwd: ' .. vim.fn.getcwd(),
      }, '\n')
      require('mini.starter').setup {
        autoopen = true,
        evaluate_single = true,
        header = logo,
        footer = 'config powered by kickstart.nvim and mini.nvim',
        items = {
          require('mini.starter').sections.recent_files(5, false),
          -- require('mini.starter').sections.pick(),
          require('mini.starter').sections.builtin_actions(),
          -- require('mini.starter').sections.sessions(5, true),
          -- { action = 'Mason', name = 'Mason', section = 'Plugin Actions' },
          -- { action = 'DepsUpdate', name = 'Update deps', section = 'Plugin Actions' },
        },
      }

      -- [[ Statusline ]] ----------------------------------------------------------
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        --return '%2l:%-2v'
        return '%7(%l/%3L%):%2c %P'
      end

      -- [[ Tabline ]] ----------------------------------------------------------
      require('mini.tabline').setup()

      -- [[ Trailspace ]] ----------------------------------------------------------
      local minitrailspace = require 'mini.trailspace'
      minitrailspace.setup()
      vim.keymap.set('n', '<leader>ts', minitrailspace.trim, { desc = 'trim space' })
      vim.keymap.set('n', '<leader>te', minitrailspace.trim_last_lines, { desc = 'trim end-line' })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
