local now, later = MiniDeps.now, MiniDeps.later
local function map(modes, keys, action, description)
  local opts = { desc = description }
  return vim.keymap.set(modes, keys, action, opts)
end

-- An example helper to create a Normal mode mapping
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end

local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end
------------------------------------------------------------------------------
-- starting with STEP01: now()
------------------------------------------------------------------------------

-- [[ Basics ]] --------------------------------------------------------------
now(function()
  require('mini.basics').setup {
    options = { extra_ui = true, win_borders = 'bold' },
    mappings = { windows = true, move_with_alt = true },
    autocommands = { relnum_in_visual_mode = true },
  }
end)

-- [[ Clues ]] ---------------------------------------------------------------
now(function()
  local clue = require 'mini.clue'

  clue.setup {
    clues = {
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers { show_contents = true },
      clue.gen_clues.windows { submode_resize = true },
      clue.gen_clues.z(),
      { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
      { mode = 'n', keys = '<Leader>s', desc = '+Session' },
      { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
      { mode = 'n', keys = '<Leader>f', desc = '+Find' },
      { mode = 'n', keys = '<Leader>g', desc = '+Git' },
      { mode = 'n', keys = '<Leader>l', desc = '+Language' },
      { mode = 'n', keys = '<Leader>m', desc = '+Map' },
      { mode = 'n', keys = '<Leader>o', desc = '+Other' },
      { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
      { mode = 'n', keys = 'gr', desc = '+LSP' },
    },
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = [[\]] }, -- mini.basics
      { mode = 'n', keys = '[' }, -- mini.bracketed
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'i', keys = '<C-x>' }, -- built-in completion
      { mode = 'n', keys = 'g' }, -- `g` key
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" }, -- marks
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' }, -- registers
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = 's' }, -- surround
      { mode = 'n', keys = '<C-w>' }, -- windows
      { mode = 'n', keys = 'z' }, -- folds
      { mode = 'x', keys = 'z' },
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
end)

-- [[ Files ]] ---------------------------------------------------------------
now(function()
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

  nmap_leader('ed', '<cmd>lua MiniFiles.open()<cr>', 'Directory')
  nmap_leader('ef', [[<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>]], 'File directory')
  nmap_leader('em', [[<Cmd>lua MiniFiles.open('~/.config/nvim')<CR>]], 'Mini.nvim directory')
end)

-- [[ Icons ]] ---------------------------------------------------------------
-- Icon provider. Usually no need to use manually. It is used by plugins like
-- 'mini.pick', 'mini.files', 'mini.statusline', and others.
now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require('mini.icons').setup {
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  }

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  -- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
  later(MiniIcons.mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(MiniIcons.tweak_lsp_kind)
end)

-- [[ Notify ]] --------------------------------------------------------------
now(function()
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
    window = { config = { row = 1, border = 'rounded' } },
  }

  vim.notify = require('mini.notify').make_notify()
end)

-- [[ Session ]] -------------------------------------------------------------
-- Session management. A thin wrapper around `:h mksession` that consistently
-- manages session files. Example usage:
-- - `<Leader>sn` - start new session
-- - `<Leader>sr` - read previously started session
-- - `<Leader>sd` - delete previously started session
now(function()
  require('mini.sessions').setup()
  local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'

  nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
  nmap_leader('sn', '<Cmd>lua ' .. session_new .. '<CR>', 'New')
  nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>', 'Read')
  nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>', 'Write current')
end)

-- [[ Starter ]] -------------------------------------------------------------
now(function()
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
    footer = 'config powered by mini.nvim',
    items = {
      require('mini.starter').sections.builtin_actions(),
      require('mini.starter').sections.recent_files(3, false),
      require('mini.starter').sections.pick(),
      require('mini.starter').sections.sessions(3, true),
      { action = 'Mason', name = 'Mason', section = 'Plugin Actions' },
      { action = 'DepsUpdate', name = 'Update deps', section = 'Plugin Actions' },
    },
  }
end)

-- [[ Statusline ]] ----------------------------------------------------------
now(function()
  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%7(%l/%3L%):%2c %P'
  end
end)

-- [[ Tabline ]] -------------------------------------------------------------
now(function()
  require('mini.tabline').setup()
end)

------------------------------------------------------------------------------
-- going to STEP02: later()
-------------------------------------------------------------------------------
later(function()
  require('mini.bracketed').setup()
end)

-- [[ bufremove ]] -----------------------------------------------------------
later(function()
  require('mini.bufremove').setup()
  local new_scratch_buffer = function()
    vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
  end
  nmap_leader('ba', '<Cmd>b#<CR>', 'Alternate')
  nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>', 'Delete buffer')
  nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0,  true)<CR>', 'Delete! buffer')
  nmap_leader('bs', new_scratch_buffer, 'Scratch')
  nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', 'Wipeout buffer')
  nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout! buffer')
end)

-- [[ Commandline ]] ---------------------------------------------------------
later(function()
  require('mini.cmdline').setup()
end)

-- [[ Comment ]] -------------------------------------------------------------
later(function()
  require('mini.comment').setup()
end)

-- [[ Completion ]] ----------------------------------------------------------
later(function()
  require('mini.completion').setup {
    lsp_completion = { source_func = 'omnifunc', auto_setup = false },
  }
  local on_attach = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- [[ Cursorword ]] ----------------------------------------------------------
later(function()
  require('mini.cursorword').setup()
end)

-- [[ Diff ]] ----------------------------------------------------------------
later(function()
  require('mini.diff').setup()
end)

-- [[ Extras ]] --------------------------------------------------------------
later(function()
  require('mini.extra').setup()
end)

-- [[ Fuzzy ]] ---------------------------------------------------------------
later(function()
  require('mini.fuzzy').setup()
end)

-- [[ Git ]] -----------------------------------------------------------------
later(function()
  require('mini.git').setup()
  local rhs = '<Cmd>lua MiniGit.show_at_cursor()<CR>'
  vim.keymap.set({ 'n', 'x' }, '<Leader>gs', rhs, { desc = 'Show at cursor' })
end)

-- [[ HiPatterns ]] ----------------------------------------------------------
later(function()
  local hipatterns = require 'mini.hipatterns'

  local censor_extmark_opts = function(_, match, _)
    local mask = string.rep('x', vim.fn.strchars(match))
    return {
      virt_text = { { mask, 'Comment' } },
      virt_text_pos = 'overlay',
      priority = 2000,
      right_gravity = false,
    }
  end

  hipatterns.setup {
    highlighters = {
      -- Hide passwords
      censor = {
        pattern = 'password: ()%S+()',
        group = '',
        extmark_opts = censor_extmark_opts,
      },
      -- Hex colors
      hex_color = hipatterns.gen_highlighter.hex_color {
        style = 'inline',
        inline_text = ' ',
      },
      -- TODO/FIXME/HACK/NOTE
      -- stylua: ignore start
      fixme       = { pattern = "() FIXME():",   group = "MiniHipatternsFixme" },
      hack        = { pattern = "() HACK():",    group = "MiniHipatternsHack" },
      todo        = { pattern = "() TODO():",    group = "MiniHipatternsTodo" },
      note        = { pattern = "() NOTE():",    group = "MiniHipatternsNote" },
      fixme_colon = { pattern = " FIXME():()",   group = "MiniHipatternsFixmeColon" },
      hack_colon  = { pattern = " HACK():()",    group = "MiniHipatternsHackColon" },
      todo_colon  = { pattern = " TODO():()",    group = "MiniHipatternsTodoColon" },
      note_colon  = { pattern = " NOTE():()",    group = "MiniHipatternsNoteColon" },
      fixme_body  = { pattern = " FIXME:().*()", group = "MiniHipatternsFixmeBody" },
      hack_body   = { pattern = " HACK:().*()",  group = "MiniHipatternsHackBody" },
      todo_body   = { pattern = " TODO:().*()",  group = "MiniHipatternsTodoBody" },
      note_body   = { pattern = " NOTE:().*()",  group = "MiniHipatternsNoteBody" },
      -- stylua: ignore end
    },
  }
end)

-- [[ Indentscope ]] ---------------------------------------------------------
later(function()
  require('mini.indentscope').setup {
    draw = {
      animation = require('mini.indentscope').gen_animation.none(),
    },
    symbol = '│',
    --symbol = "▏",
    options = {
      try_as_border = true,
      border = 'both',
      indent_at_cursor = true,
    },
  }
end)

-- [[ Jump2d ]] --------------------------------------------------------------
later(function()
  require('mini.jump2d').setup {
    labels = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
    view = {
      dim = true,
      n_steps_ahead = 2,
    },
    mappings = {
      start_jumping = '',
    },
  }
end)

-- [[ Keymap ]] --------------------------------------------------------------
-- Special key mappings. Provides helpers to map:
-- - Multi-step actions. Apply action 1 if condition is met; else apply
--   action 2 if condition is met; etc.
-- - Combos. Sequence of keys where each acts immediately plus execute extra
--   action if all are typed fast enough. Useful for Insert mode mappings to not
--   introduce delay when typing mapping keys without intention to execute action.
--
-- See also:
-- - `:h MiniKeymap-examples` - examples of common setups
-- - `:h MiniKeymap.map_multistep()` - map multi-step action
-- - `:h MiniKeymap.map_combo()` - map combo
later(function()
  require('mini.keymap').setup()
  -- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
  MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  -- On `<CR>` try to accept current completion item, fall back to accounting
  -- for pairs from 'mini.pairs'
  MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  -- On `<BS>` just try to account for pairs from 'mini.pairs'
  MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

-- [[ MiniMap ]] -------------------------------------------------------------
-- Window with text overview. It is displayed on the right hand side. Can be used
-- for quick overview and navigation. Hidden by default. Example usage:
-- - `<Leader>mt` - toggle map window
-- - `<Leader>mf` - focus on the map for fast navigation
-- - `<Leader>ms` - change map's side (if it covers something underneath)
--
-- See also:
-- - `:h MiniMap.gen_encode_symbols` - list of symbols to use for text encoding
-- - `:h MiniMap.gen_integration` - list of integrations to show in the map
--
-- NOTE: Might introduce lag on very big buffers (10000+ lines)
later(function()
  local minimap = require 'mini.map'
  minimap.setup {
    -- Use Braille dots to encode text
    symbols = { encode = minimap.gen_encode_symbols.dot '4x2' },
    -- Show built-in search matches, 'mini.diff' hunks, and diagnostic entries
    integrations = {
      minimap.gen_integration.builtin_search(),
      minimap.gen_integration.diff(),
      minimap.gen_integration.diagnostic(),
    },
  }

  -- Map built-in navigation characters to force map refresh
  for _, key in ipairs { 'n', 'N', '*', '#' } do
    local rhs = key
      -- Also open enough folds when jumping to the next match
      .. 'zv'
      .. '<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>'
    vim.keymap.set('n', key, rhs)
  end
  -- - `<Leader>mt` - toggle map from 'mini.map' (closed by default)
  -- - `<Leader>mf` - focus on the map for fast navigation
  -- - `<Leader>ms` - change map's side (if it covers something underneath)
  nmap_leader('mf', '<Cmd>lua MiniMap.toggle_focus()<CR>', 'Focus (toggle)')
  nmap_leader('mr', '<Cmd>lua MiniMap.refresh()<CR>', 'Refresh')
  nmap_leader('ms', '<Cmd>lua MiniMap.toggle_side()<CR>', 'Side (toggle)')
  nmap_leader('mt', '<Cmd>lua MiniMap.toggle()<CR>', 'Toggle')
end)

-- [[ Move ]] ----------------------------------------------------------------
later(function()
  require('mini.move').setup()
end)

-- [[ Pairs ]] ---------------------------------------------------------------
-- Autopairs functionality. Insert pair when typing opening character and go over
-- right character if it is already to cursor's right. Also provides mappings for
-- `<CR>` and `<BS>` to perform extra actions when inside pair.
-- Example usage in Insert mode:
-- - `(` - insert "()" and put cursor between them
-- - `)` when there is ")" to the right - jump over ")" without inserting new one
-- - `<C-v>(` - always insert a single "(" literally. This is useful since
--   'mini.pairs' doesn't provide particularly smart behavior, like auto balancing
later(function()
  -- Create pairs not only in Insert, but also in Command line mode
  require('mini.pairs').setup { modes = { command = true } }
end)

-- [[ Picker ]] ----------------------------------------------------------
later(function()
  local minipick = require 'mini.pick'
  local miniextra = require 'mini.extra'
  local win_config = function()
    height = math.floor(0.6 * vim.o.lines)
    width = math.floor(0.6 * vim.o.columns)
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

  minipick.registry.buffers = function(local_opts)
    local wipeout_buffer = function()
      MiniBufremove.delete(MiniPick.get_picker_matches().current.bufnr, false)
    end
    minipick.builtin.buffers(local_opts, { mappings = { wipeout = { char = '<C-d>', func = wipeout_buffer } } })
  end
  vim.keymap.set('n', '<leader>fb', function()
    minipick.registry.buffers { include_current = false }
  end, { desc = 'Find Buffers' })
  nmap_leader('<space>', minipick.builtin.buffers, 'Find existing buffers')
  local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'

  nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
  nmap_leader('fA', pick_added_hunks_buf, 'Added hunks (buf)')
  nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
  nmap_leader('fc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
  nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (buf)')
  nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
  nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
  nmap_leader('ff', minipick.builtin.files, 'Files')
  nmap_leader('fg', minipick.builtin.grep_live, 'Find by Grep')
  nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
  nmap_leader('fe', miniextra.pickers.explorer, 'Explorer')
  nmap_leader('fo', miniextra.pickers.oldfiles, 'Find Recent Files')
  nmap_leader('fp', [[<Cmd>Pick hipatterns<CR>]], 'Highlight Patterns')
  nmap_leader('f/', [[<Cmd>Pick history scope='/'<CR>]], '"/" history')
  nmap_leader('f:', [[<Cmd>Pick history scope=':'<CR>]], '":" history')
  -- Search related
  nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
  nmap_leader('fH', '<Cmd>Pick hl_groups<CR>', 'Highlight groups')
  nmap_leader('fk', miniextra.pickers.keymaps, 'Keymaps')
  nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
  nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Lines (all)')
  nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Lines (buf)')
  -- map('n', '<leader>s"', '<Cmd>Pick registers<CR>', 'Search registers')
  -- map('n', '<leader>sc', '<Cmd>Pick history<CR>', 'Search history')
  -- map('n', '<leader>sC', '<Cmd>Pick commands<CR>', 'Search commands')
  -- map('n', '<leader>sd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
  -- map('n', '<leader>sD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
  nmap_leader('fo', '<Cmd>Pick options<CR>', 'Search options')
  -- map('n', '<leader>ss', '<Cmd>Pick colorschemes<CR>', 'Search colorschemes')
  -- map('n', '<leader>sT', '<Cmd>Pick treesitter<CR>', 'Treesitter objects')

  -- Git related
  local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
  local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

  vim.keymap.set('n', '<leader>gf', function()
    MiniExtra.pickers.git_files()
  end, { desc = 'Search Git files' })
  nmap_leader('ga', '<Cmd>Git diff --cached<CR>', 'Added diff')
  nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>', 'Added diff buffer')
  nmap_leader('gc', '<Cmd>Git commit<CR>', 'Commit')
  nmap_leader('gC', '<Cmd>Git commit --amend<CR>', 'Commit amend')
  nmap_leader('gd', '<Cmd>Git diff<CR>', 'Diff')
  nmap_leader('gD', '<Cmd>Git diff -- %<CR>', 'Diff buffer')
  nmap_leader('gb', miniextra.pickers.git_branches, 'Git branches')
  nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>', 'Log')
  nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>', 'Log buffer')
  nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
  nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')

  -- LSP related
  -- vim.keymap.set('n', '<leader>lD', [[<Cmd>Pick diagnostic scope = 'all'<CR>]], { desc = 'Diagnostic workspace' })
  -- vim.keymap.set('n', '<leader>ld', [[<Cmd>Pick diagnostic scope = 'current'<CR>]], { desc = 'Diagnostic buffer' })
  -- vim.keymap.set('n', '<leader>le', [[<Cmd>Pick lsp scope = 'declaration'<CR>]], { desc = 'Declaration (LSP)' })
  -- vim.keymap.set('n', '<leader>lR', [[<Cmd>Pick lsp scope = 'references'<CR>]], { desc = 'References (LSP)' })

  -- vim.keymap.set('n', '<leader>ls', [[<Cmd>Pick lsp scope = 'document_symbol'<CR>]], { desc = 'Symbols buffer (LSP)' })
  -- vim.keymap.set('n', '<leader>lt', [[<Cmd>Pick lsp scope = 'type_definition'<CR>]], { desc = 'Type definition (LSP)' })
  -- vim.keymap.set('n', '<leader>li', [[<Cmd>Pick lsp scope = 'implementation'<CR>]], { desc = 'Implementation (LSP)' })
  -- vim.keymap.set('n', '<leader>lr', [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { desc = 'Rename (LSP)' })
  -- vim.keymap.set('n', '<leader>la', [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], { desc = 'Code [A]ction (LSP)' })
  vim.keymap.set('n', '<leader>fw', function()
    minipick.builtin.grep { pattern = vim.fn.expand '<cword>' }
  end, { desc = 'Grep Current Word' })
end)

-- [[ Surround ]] ------------------------------------------------------------
-- Surround actions: add/delete/replace/find/highlight. Working with surroundings
-- is surprisingly common: surround word with quotes, replace `)` with `]`, etc.
-- This module comes with many built-in surroundings, each identified by a single
-- character. It searches only for surrounding that covers cursor and comes with
-- a special "next" / "last" versions of actions to search forward or backward
-- (just like 'mini.ai'). All text editing actions are dot-repeatable (see `:h .`).
--
-- Example usage (this may feel intimidating at first, but after practice it
-- becomes second nature during text editing):
-- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
-- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
-- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
-- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
-- - `shf`   - *s*urround *h*ighlight current *f*unction call
-- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
-- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
-- - `vaWsa<Space>` - *v*isually select *a*round *W*ORD and *s*urround *a*dd
--                    spaces (`<Space>`)
--
-- See also:
-- - `:h MiniSurround-builtin-surroundings` - list of all supported surroundings
-- - `:h MiniSurround-surrounding-specification` - examples of custom surroundings
-- - `:h MiniSurround-vim-surround-config` - alternative set of action mappings
later(function()
  require('mini.surround').setup()
end)

-- [[ Trailspace ]] ----------------------------------------------------------
later(function()
  local minitrailspace = require 'mini.trailspace'
  minitrailspace.setup()
  nmap_leader('ot', minitrailspace.trim, 'trim space')
  nmap_leader('oe', minitrailspace.trim_last_lines, 'trim end-line')
end)

-- [[ Visits ]] --------------------------------------------------------------
later(function()
  require('mini.visits').setup()
  local make_pick_core = function(cwd, desc)
    return function()
      local sort_latest = MiniVisits.gen_sort.default { recency_weight = 1 }
      local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
      MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
    end
  end

  nmap_leader('vc', make_pick_core('', 'Core visits (all)'), 'Core visits (all)')
  nmap_leader('vC', make_pick_core(nil, 'Core visits (cwd)'), 'Core visits (cwd)')
  nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>', 'Add "core" label')
  nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
  nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>', 'Add label')
  nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>', 'Remove label')
end)
