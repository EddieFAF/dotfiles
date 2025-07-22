--[[

--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Options
local function set(name, value)
  vim.opt[name] = value
end

local function setlocal(name, value)
  vim.opt_local[name] = value
end

local function setglobal(name, value)
  vim.g[name] = value
end

_G.opt = {
  set = set,
  setlocal = setlocal,
  setglobal = setglobal,
}

-- Keymaps
local function map(modes, keys, action, description)
  local opts = { desc = description }
  return vim.keymap.set(modes, keys, action, opts)
end

local function maplocal(modes, keys, action, description, buffer)
  local opts = { desc = description, buffer = buffer }
  return vim.keymap.set(modes, keys, action, opts)
end

local function toggle(option)
  return function()
    local opt = vim.opt_local[option]:get()
    vim.opt_local[option] = not opt
  end
end

_G.keys = {
  map = map,
  maplocal = maplocal,
  toggle = toggle,
}

-- Autocommands
local function augroup(name)
  return vim.api.nvim_create_augroup('kick_' .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

_G.event = {
  augroup = augroup,
  autocmd = autocmd,
}
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  --space = '⋅',
  extends = '›',
  precedes = '‹',
  eol = '↲',
}
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.confirm = true

-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous Buffer' })

-- increment/decrement
vim.keymap.set('n', '-', '<C-x>', { desc = 'decrement' })
vim.keymap.set('n', '+', '<C-a>', { desc = 'increment' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'checkhealth',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { desc = 'close', buffer = event.buf, silent = true })
  end,
})
-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- [[ AI ]] ------------------------------------------------------------
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
          basic = true,
          -- Set 'relativenumber' only in linewise and blockwise Visual mode
          relnum_in_visual_mode = true,
        },
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

      -- [[ Diff ]] ----------------------------------------------------------------
      require('mini.diff').setup()

      vim.keymap.set('n', '<Leader>go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', { desc = 'toggle overlay' })

      -- [[ Extras ]] --------------------------------------------------------------
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

        windows = {
          preview = true,
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

      -- [[ Git ]] -----------------------------------------------------------------
      require('mini.git').setup()
      local rhs = '<Cmd>lua MiniGit.show_at_cursor()<CR>'
      vim.keymap.set({ 'n', 'x' }, '<Leader>gs', rhs, { desc = 'Show at cursor' })

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

      -- [[ Icons ]] --------------------------------------------------------------
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
      local minipick = require 'mini.pick'
      local miniextra = require 'mini.extra'
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
      minipick.setup {
        mappings = {
          choose_in_vsplit = '<C-CR>',
        },
        options = {
          use_cache = true,
        },
        window = {
          config = win_config,
        },
      }

      vim.ui.select = minipick.ui_select

      MiniPick.registry.buffers = function(local_opts)
        local wipeout_buffer = function()
          MiniBufremove.delete(MiniPick.get_picker_matches().current.bufnr, false)
        end
        MiniPick.builtin.buffers(local_opts, { mappings = { wipeout = { char = '<C-d>', func = wipeout_buffer } } })
      end
      vim.keymap.set('n', '<leader>fb', function()
        MiniPick.registry.buffers { include_current = false }
      end, { desc = 'Find Buffers' })
      vim.keymap.set('n', '<leader><space>', minipick.builtin.buffers, { desc = 'Find existing buffers' })

      -- vim.keymap.set("n", "<leader>fb", [[<Cmd>Pick buffers<CR>]], { desc = "Buffers" })
      vim.keymap.set('n', '<leader>ff', minipick.builtin.files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fh', minipick.builtin.help, { desc = 'Find Help' })
      vim.keymap.set('n', '<leader>fg', minipick.builtin.grep_live, { desc = 'Find by Grep' })
      --vim.keymap.set("n", "<leader>fr", MiniPick.builtin.resume, { desc = "Resume" })
      vim.keymap.set('n', '<leader>fe', miniextra.pickers.explorer, { desc = 'Explorer' })
      vim.keymap.set('n', '<leader>fk', miniextra.pickers.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>fr', miniextra.pickers.oldfiles, { desc = 'Find Recent Files' })
      vim.keymap.set('n', '<leader>f/', [[<Cmd>Pick history scope='/'<CR>]], { desc = '"/" history' })
      vim.keymap.set('n', '<leader>f:', [[<Cmd>Pick history scope=':'<CR>]], { desc = '":" history' })
      vim.keymap.set('n', '<leader>gg', function()
        MiniExtra.pickers.git_files()
      end, { desc = 'Search Git files' })
      vim.keymap.set('n', '<leader>ga', [[<Cmd>Pick git_hunks scope='staged'<CR>]], { desc = 'Added hunks (all)' })
      vim.keymap.set('n', '<leader>gA', [[<Cmd>Pick git_hunks path='%' scope='staged'<CR>]], { desc = 'Added hunks (current)' })
      vim.keymap.set('n', '<leader>gb', miniextra.pickers.git_branches, { desc = 'Git branches' })
      vim.keymap.set('n', '<leader>gC', [[<Cmd>Pick git_commits<CR>]], { desc = 'Commits (all)' })
      vim.keymap.set('n', '<leader>gc', [[<Cmd>Pick git_commits path='%'<CR>]], { desc = 'Commits (current)' })
      vim.keymap.set('n', '<leader>fD', [[<Cmd>Pick diagnostic scope='all'<CR>]], { desc = 'Diagnostic workspace' })
      vim.keymap.set('n', '<leader>fd', [[<Cmd>Pick diagnostic scope='current'<CR>]], { desc = 'Diagnostic buffer' })
      vim.keymap.set('n', '<leader>fG', function()
        MiniPick.builtin.grep { pattern = vim.fn.expand '<cword>' }
      end, { desc = 'Grep Current Word' })
      vim.keymap.set('n', '<leader>fH', [[<Cmd>Pick hl_groups<CR>]], { desc = 'Highlight groups' })
      vim.keymap.set('n', '<leader>fL', [[<Cmd>Pick buf_lines scope='all'<CR>]], { desc = 'Lines (all)' })
      vim.keymap.set('n', '<leader>fl', [[<Cmd>Pick buf_lines scope='current'<CR>]], { desc = 'Lines (current)' })
      vim.keymap.set('n', '<leader>gM', [[<Cmd>Pick git_hunks<CR>]], { desc = 'Modified hunks (all)' })
      vim.keymap.set('n', '<leader>gm', [[<Cmd>Pick git_hunks path='%'<CR>]], { desc = 'Modified hunks (current)' })
      vim.keymap.set('n', '<leader>fR', [[<Cmd>Pick lsp scope='references'<CR>]], { desc = 'References (LSP)' })
      vim.keymap.set('n', '<leader>fS', [[<Cmd>Pick lsp scope='workspace_symbol'<CR>]], { desc = 'Symbols workspace (LSP)' })
      vim.keymap.set('n', '<leader>fs', [[<Cmd>Pick lsp scope='document_symbol'<CR>]], { desc = 'Symbols buffer (LSP)' })
      vim.keymap.set('n', '<leader>fV', [[<Cmd>Pick visit_paths cwd=''<CR>]], { desc = 'Visit paths (all)' })
      vim.keymap.set('n', '<leader>fv', [[<Cmd>Pick visit_paths<CR>]], { desc = 'Visit paths (cwd)' })

      -- Picker pre- and post-hooks ===============================================

      -- Keys should be a picker source.name. Value is a callback function that
      -- accepts same arguments as User autocommand callback.
      local hooks = {
        pre_hooks = {},
        post_hooks = {},
      }

      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = 'MiniPickStart',
        group = vim.api.nvim_create_augroup('minipick-pre-hooks', { clear = true }),
        desc = 'Invoke pre_hook for specific picker based on source.name.',
        callback = function(...)
          local opts = minipick.get_picker_opts() or {}
          local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
          pre_hook(...)
        end,
      })

      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = 'MiniPickStop',
        group = vim.api.nvim_create_augroup('minipick-post-hooks', { clear = true }),
        desc = 'Invoke post_hook for specific picker based on source.name.',
        callback = function(...)
          local opts = minipick.get_picker_opts() or {}
          local post_hook = hooks.post_hooks[opts.source.name] or function(...) end
          post_hook(...)
        end,
      })

      -- Colorscheme picker =======================================================

      local selected_colorscheme -- Currently selected or original colorscheme

      hooks.pre_hooks.colorschemes = function()
        selected_colorscheme = vim.g.colors_name
      end

      hooks.post_hooks.colorschemes = function()
        vim.cmd('colorscheme ' .. selected_colorscheme)
      end

      minipick.registry.colorschemes = function()
        local colorschemes = vim.fn.getcompletion('', 'color')
        return minipick.start {
          source = {
            name = 'colorschemes',
            items = colorschemes,
            choose = function(item)
              selected_colorscheme = item
            end,
            preview = function(buf_id, item)
              vim.cmd('colorscheme ' .. item)
              vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
            end,
          },
        }
      end

      -- [[ Surround ]] ----------------------------------------------------------
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
          require('mini.starter').sections.pick(),
          require('mini.starter').sections.builtin_actions(),
          -- require('mini.starter').sections.sessions(5, true),
          -- { action = 'Mason', name = 'Mason', section = 'Plugin Actions' },
          -- { action = 'DepsUpdate', name = 'Update deps', section = 'Plugin Actions' },
        },
      }

      -- [[ Statusline ]] ----------------------------------------------------------
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%7(%l/%3L%):%2c %P'
      end

      -- [[ Tabline ]] ----------------------------------------------------------
      require('mini.tabline').setup()

      -- [[ Trailspace ]] ----------------------------------------------------------
      local minitrailspace = require 'mini.trailspace'
      minitrailspace.setup()
      vim.keymap.set('n', '<leader>ts', minitrailspace.trim, { desc = 'trim space' })
      vim.keymap.set('n', '<leader>te', minitrailspace.trim_last_lines, { desc = 'trim end-line' })
    end,
  },
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  -- {
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     on_attach = function(bufnr)
  --       local gitsigns = require 'gitsigns'
  --
  --       local function map(mode, l, r, opts)
  --         opts = opts or {}
  --         opts.buffer = bufnr
  --         vim.keymap.set(mode, l, r, opts)
  --       end
  --
  --       -- Navigation
  --       map('n', ']c', function()
  --         if vim.wo.diff then
  --           vim.cmd.normal { ']c', bang = true }
  --         else
  --           gitsigns.nav_hunk 'next'
  --         end
  --       end, { desc = 'Jump to next git [c]hange' })
  --
  --       map('n', '[c', function()
  --         if vim.wo.diff then
  --           vim.cmd.normal { '[c', bang = true }
  --         else
  --           gitsigns.nav_hunk 'prev'
  --         end
  --       end, { desc = 'Jump to previous git [c]hange' })
  --
  --       -- Actions
  --       -- visual mode
  --       map('v', '<leader>hs', function()
  --         gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  --       end, { desc = 'git [s]tage hunk' })
  --       map('v', '<leader>hr', function()
  --         gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  --       end, { desc = 'git [r]eset hunk' })
  --       -- normal mode
  --       map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
  --       map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
  --       map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
  --       map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
  --       map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
  --       map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
  --       map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
  --       map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
  --       map('n', '<leader>hD', function()
  --         gitsigns.diffthis '@'
  --       end, { desc = 'git [D]iff against last commit' })
  --       -- Toggles
  --       map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
  --       map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
  --     end,
  --   },
  -- },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
          severity = {
            max = vim.diagnostic.severity.WARN,
          },
        },
        virtual_lines = {
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'lua' },

      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      {
        '<leader>.',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>ew',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}, {
  checker = { enabled = true },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
