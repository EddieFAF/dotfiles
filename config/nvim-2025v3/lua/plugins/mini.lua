local now, later = MiniDeps.now, MiniDeps.later
local function map(modes, keys, action, description)
  local opts = { desc = description }
  return vim.keymap.set(modes, keys, action, opts)
end

now(function()
  require('mini.basics').setup {
    options = { extra_ui = false, win_borders = 'bold' },
    mappings = { windows = true, move_with_alt = true },
    autocommands = { relnum_in_visual_mode = true },
  }
end)

later(function()
  require('mini.bracketed').setup()
end)

later(function()
  require('mini.bufremove').setup()
  vim.keymap.set('n', '<leader>bd', '<Cmd>lua MiniBufremove.delete()<CR>', { desc = 'Delete buffer' })
  vim.keymap.set('n', '<leader>bD', '<Cmd>lua MiniBufremove.delete(0,  true)<CR>', { desc = 'Delete! buffer' })
  vim.keymap.set('n', '<leader>bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', { desc = 'Wipeout buffer' })
  vim.keymap.set('n', '<leader>bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', { desc = 'Wipeout! buffer' })
end)

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
      { mode = 'n', keys = '<Leader>s', desc = '+Search' },
      { mode = 'n', keys = '<Leader>f', desc = '+Files' },
      { mode = 'n', keys = '<Leader>e', desc = '+Explorer' },
      { mode = 'n', keys = '<Leader>g', desc = '+Git' },
      { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
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

later(function()
  require('mini.comment').setup()
end)

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

later(function()
  require('mini.cursorword').setup()
end)

later(function()
  require('mini.extra').setup()
end)

now(function()
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
end)

later(function()
  -- [[ Fuzzy ]] ---------------------------------------------------------------
  require('mini.fuzzy').setup()
end)

later(function()
  -- [[ Git ]] -----------------------------------------------------------------
  require('mini.git').setup()
  local rhs = '<Cmd>lua MiniGit.show_at_cursor()<CR>'
  vim.keymap.set({ 'n', 'x' }, '<Leader>gs', rhs, { desc = 'Show at cursor' })
end)

now(function()
  local miniicons = require 'mini.icons'
  miniicons.setup {
    style = 'glyph',
  }
  miniicons.mock_nvim_web_devicons()
  miniicons.tweak_lsp_kind()
end)

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

later(function()
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
end)

later(function()
  require('mini.move').setup()
end)

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
    window = { config = { row = 2, border = 'rounded' } },
  }

  vim.notify = require('mini.notify').make_notify()
end)

later(function()
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

  vim.keymap.set('n', '<leader>ff', minipick.builtin.files, { desc = 'Find Files' })
  vim.keymap.set('n', '<leader>fg', minipick.builtin.grep_live, { desc = 'Find by Grep' })
  vim.keymap.set('n', '<leader>fe', miniextra.pickers.explorer, { desc = 'Explorer' })
  vim.keymap.set('n', '<leader>fo', miniextra.pickers.oldfiles, { desc = 'Find Recent Files' })
  vim.keymap.set('n', '<leader>fp', [[<Cmd>Pick hipatterns<CR>]], { desc = 'Highlight Patterns' })
  vim.keymap.set('n', '<leader>f/', [[<Cmd>Pick history scope='/'<CR>]], { desc = '"/" history' })
  vim.keymap.set('n', '<leader>f:', [[<Cmd>Pick history scope=':'<CR>]], { desc = '":" history' })
  -- Search related
  vim.keymap.set('n', '<leader>sh', minipick.builtin.help, { desc = 'Find Help' })
  vim.keymap.set('n', '<leader>sk', miniextra.pickers.keymaps, { desc = 'Keymaps' })
  vim.keymap.set('n', '<leader>sH', [[<Cmd>Pick hl_groups<CR>]], { desc = 'Highlight groups' })
  vim.keymap.set('n', '<leader>sr', MiniPick.builtin.resume, { desc = 'Resume' })
  vim.keymap.set('n', '<leader>sb', [[<Cmd>Pick buf_lines scope='all'<CR>]], { desc = 'Lines (all)' })
  vim.keymap.set('n', '<leader>sB', [[<Cmd>Pick buf_lines scope='current'<CR>]], { desc = 'Lines (current)' })
  map('n', '<leader>s"', '<Cmd>Pick registers<CR>', 'Search registers')
  map('n', '<leader>sc', '<Cmd>Pick history<CR>', 'Search history')
  map('n', '<leader>sC', '<Cmd>Pick commands<CR>', 'Search commands')
  map('n', '<leader>sd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
  map('n', '<leader>sD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
  map('n', '<leader>so', '<Cmd>Pick options<CR>', 'Search options')
  map('n', '<leader>ss', '<Cmd>Pick colorschemes<CR>', 'Search colorschemes')
  map('n', '<leader>sT', '<Cmd>Pick treesitter<CR>', 'Treesitter objects')

  -- Git related
  vim.keymap.set('n', '<leader>gf', function()
    MiniExtra.pickers.git_files()
  end, { desc = 'Search Git files' })
  vim.keymap.set('n', '<leader>ga', [[<Cmd>Pick git_hunks scope='staged'<CR>]], { desc = 'Added hunks (all)' })
  vim.keymap.set('n', '<leader>gA', [[<Cmd>Pick git_hunks path='%' scope='staged'<CR>]], { desc = 'Added hunks (current)' })
  vim.keymap.set('n', '<leader>gM', [[<Cmd>Pick git_hunks<CR>]], { desc = 'Modified hunks (all)' })
  vim.keymap.set('n', '<leader>gm', [[<Cmd>Pick git_hunks path='%'<CR>]], { desc = 'Modified hunks (current)' })
  vim.keymap.set('n', '<leader>gb', miniextra.pickers.git_branches, { desc = 'Git branches' })
  vim.keymap.set('n', '<leader>gC', miniextra.pickers.git_commits, { desc = 'Commits (all)' })
  vim.keymap.set('n', '<leader>gc', [[<Cmd>Pick git_commits path = '%'<CR>]], { desc = 'Commits (current)' })
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
    MiniPick.builtin.grep { pattern = vim.fn.expand '<cword>' }
  end, { desc = 'Grep Current Word' })
  vim.keymap.set('n', '<leader>vv', [[<Cmd>Pick visit_paths cwd=''<CR>]], { desc = 'Visit paths (all)' })
  vim.keymap.set('n', '<leader>vV', [[<Cmd>Pick visit_paths<CR>]], { desc = 'Visit paths (cwd)' })

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
end)

now(function()
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
      { action = 'Mason', name = 'Mason', section = 'Plugin Actions' },
      { action = 'DepsUpdate', name = 'Update deps', section = 'Plugin Actions' },
    },
  }
end)

now(function()
  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%7(%l/%3L%):%2c %P'
  end
end)

later(function()
  require('mini.tabline').setup()
end)

later(function()
  local minitrailspace = require 'mini.trailspace'
  minitrailspace.setup()
  vim.keymap.set('n', '<leader>ts', minitrailspace.trim, { desc = 'trim space' })
  vim.keymap.set('n', '<leader>te', minitrailspace.trim_last_lines, { desc = 'trim end-line' })
end)

later(function()
  require('mini.visits').setup()
end)
