--[[

******************************************************************************
* init.lua                                                                   *
* Neovim config mostly based on mini.nvim from echasnovski                   *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.3                                                                *
* initial release                                                            *
******************************************************************************

--]]
--
--
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
local mini_deps = require("mini.deps")

local add, now, later = mini_deps.add, mini_deps.now, mini_deps.later

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

--
-- Keymaps
--
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

--
-- Autocommands
--
local function augroup(name)
  return vim.api.nvim_create_augroup("kick_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

_G.event = {
  augroup = augroup,
  autocmd = autocmd,
}
-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

now(function()
  -- [[ Keymappings ]] ---------------------------------------------------------
  vim.keymap.set("n", "<esc>", ":noh<cr><esc>", { desc = "Remove Search Highlight" })
  vim.keymap.set("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
  vim.keymap.set("n", "<S-h>", ":bprevious<cr>", { desc = "Previous Buffer" })
  vim.keymap.set("n", "<leader>M", ":Mason<cr>", { desc = "Mason" })
  -- increment/decrement
  vim.keymap.set("n", "-", "<C-x>", { desc = "decrement" })
  vim.keymap.set("n", "+", "<C-a>", { desc = "increment" })
  -- Split window
  vim.keymap.set("n", "<leader>ws", ":split<CR>", { desc = "Split horizontal" })
  vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split vertical" })
  -- Move window
  vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
  vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
  vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
  vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
  vim.keymap.set("n", "<Leader>p", function()
    vim.ui.select({
      "buf_lines",
      "buffers",
      "cli",
      "commands",
      "colorschemes",
      "diagnostic",
      "explorer",
      "files",
      "git_branches",
      "git_commits",
      "git_files",
      "hit_hunks",
      "grep",
      "grep_live",
      "help",
      "hipatterns",
      "history",
      "hl_groups",
      "keymaps",
      "list",
      "lsp",
      "markers",
      "oldfiles",
      "options",
      "registers",
      "resume",
      "spellsuggest",
      "treesitter",
    }, { prompt = "Pick " }, function(choice)
      return vim.cmd({ cmd = "Pick", args = { choice } })
    end)
  end, { desc = "Pick something" })
end)
-- Numbers on the left
map("n", ",n", toggle("number"), "Toggle line number")
map("n", ",r", toggle("relativenumber"), "Toggle relative line number")

map("n", ",c", toggle("cursorline"), "Toggle cursorline")
map("n", ",l", toggle("list"), "Toggle list characters")

-- Wrap lines that are longer than 'textwidth'
map("n", ",w", toggle("wrap"), "Toggle line wrapping")

-- Spelling errors and suggestions
map("n", ",s", toggle("spell"), "Toggle spell checking")
map("n", "<leader>uu", ":lua MiniDeps.update()<CR>", "MiniDeps Update")

-- [[ Autocommands ]] --------------------------------------------------------
now(function()
  -- go to last location
  --  vim.api.nvim_create_autocmd("BufReadPost", {
  --    group = augroup("last_loc"),
  --    callback = function()
  --      local mark = vim.api.nvim_buf_get_mark(0, '"')
  --      local lcount = vim.api.nvim_buf_line_count(0)
  --      if mark[1] > 0 and mark[1] <= lcount then
  --        pcall(vim.api.nvim_win_set_cursor, 0, mark)
  --      end
  --    end,
  --  })

  -- close some filetypes with <q>
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "man",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "checkhealth",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { desc = "close", buffer = event.buf, silent = true })
    end,
  })

  -- disable statusline in starter window
  vim.api.nvim_create_autocmd("User", {
    group = augroup("disable_statusbar_on_starter"),
    pattern = { "MiniStarterOpened" },
    callback = function()
      vim.b.ministatusline_disable = true
    end,
  })
end)

now(function()
  -- [[ Settings options ]] ----------------------------------------------------
  vim.opt.scrolloff = 5
  vim.opt.title = true
  vim.opt.titlelen = 0
  vim.opt.titlestring = '%{expand("%:p")} [%{mode()}]'
  vim.opt.completeopt = "menuone,noinsert,noselect"
  --vim.opt.completeopt = { "menu", "menuone", "noselect" }
  vim.opt.splitright = true
  vim.opt.splitbelow = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 4
  vim.opt.softtabstop = -1
  vim.opt.expandtab = true
  vim.opt.termguicolors = true

  vim.opt.relativenumber = false
  vim.o.cursorline = true
  vim.o.autoindent = true -- Use auto indent
  vim.o.expandtab = true -- Convert tabs to spaces
  vim.o.formatoptions = "rqnl1j" -- Improve comment editing
  vim.o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
  vim.o.incsearch = true -- Show search results while typing
  vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
  vim.o.smartcase = true -- Don't ignore case when searching if pattern has upper case
  vim.o.smartindent = true -- Make indenting smart
  vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

  vim.opt.cmdheight = 0

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  --vim.opt.wildmode       = "list:longest,list:full"
  vim.opt.wildmode = "longest:full,full"

  -- Global
  vim.opt.fillchars = {
    fold = "╌",
    foldopen = "▾",
    foldclose = "▸",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  }
  vim.opt.list = true

  vim.opt.listchars = {
    -- tab = ">>>",
    -- space = '⋅',
    tab = "▸ ",
    trail = "·",
    --  precedes = "←",
    --  extends = "→",
    extends = "›",
    precedes = "‹",
    eol = "↲",
    nbsp = "␣",
  }
  -- Folds ======================================================================
  -- vim.o.foldmethod = "indent" -- Set 'indent' folding method
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 1 -- Display all folds except top ones
  vim.opt.foldnestmax = 10 -- Create folds only for some number of nested levels
  vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

  if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.foldtext = "" -- Use underlying text with its highlighting
  end
end)

--vim.cmd('colorscheme randomhue')

now(function()
  add({
    source = "saghen/blink.cmp",
    depends = {
      -- Snippets
      "rafamadriz/friendly-snippets",
      -- Sources
      "moyiz/blink-emoji.nvim",
      "Saghen/blink.compat",
    },
    checkout = "v0.10.0", -- check releases for latest tag
  })
end)

-- ╒═══════════════════╕
-- │ `blink.cmp` Setup │
-- ╘═══════════════════╛
later(function()
  require("blink.cmp").setup({
    completion = {
      menu = {
        border = "rounded",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
      ghost_text = { enabled = true },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "crates",
        "buffer",
        "emoji",
      },
      providers = {
        crates = {
          name = "crates",
          module = "blink.compat.source",
        },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  })
end)

now(function()
  add({
    source = "stevearc/conform.nvim",
    checkout = "v8.3.0",
  })

  -- Assign keymaps
  map("n", "<leader>F", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, "[F]ormat Buffer")
end)

later(function()
  add({
    source = "ibhagwan/fzf-lua",
    --    depends = { "nvim-tree/nvim-web-devicons" }
  })
  -- stylua: ignore
  --    keys = {
  map('n', '<leader>/c', function() require('fzf-lua').commands() end, 'Search commands')
  map("n", "<leader>/C", function()
    require("fzf-lua").command_history()
  end, "Search command history")
  map("n", "<leader>/b", function()
    require("fzf-lua").buffers()
  end, "Find buffers")
  map("n", "<leader>/f", function()
    require("fzf-lua").files()
  end, "Find files")
  map("n", "<leader>/o", function()
    require("fzf-lua").oldfiles()
  end, "Find recent files")
  map("n", "<leader>/h", function()
    require("fzf-lua").highlights()
  end, "Search highlights")
  map("n", "<leader>/M", function()
    require("fzf-lua").marks()
  end, "Search marks")
  map("n", "<leader>/k", function()
    require("fzf-lua").keymaps()
  end, "Search keymaps")
  map("n", "<leader>gf", function()
    require("fzf-lua").git_files()
  end, "Find git files")
  map("n", "<leader>gb", function()
    require("fzf-lua").git_branches()
  end, "Search git branches")
  map("n", "<leader>gc", function()
    require("fzf-lua").git_commits()
  end, "Search git commits")
  map("n", "<leader>gC", function()
    require("fzf-lua").git_bcommits()
  end, "Search git buffer commits")
  map("n", "<leader>//", function()
    require("fzf-lua").resume()
  end, "Resume FZF")
  --    },
  local fzf = require("fzf-lua")
  local actions = require("fzf-lua.actions")
  fzf.setup({
    keymap = {
      builtin = {
        ["<C-/>"] = "toggle-help",
        ["<C-a>"] = "toggle-fullscreen",
        ["<C-i>"] = "toggle-preview",
        ["<C-f>"] = "preview-page-down",
        ["<C-b>"] = "preview-page-up",
      },
      fzf = {
        ["CTRL-Q"] = "select-all+accept",
      },
    },
    fzf_colors = {
      bg = { "bg", "Normal" },
      gutter = { "bg", "Normal" },
      info = { "fg", "Conditional" },
      scrollbar = { "bg", "Normal" },
      separator = { "fg", "Comment" },
    },
    winopts = {
      height = 0.7,
      width = 0.55,
      preview = {
        scrollbar = false,
        layout = "vertical",
        vertical = "up:40%",
      },
    },
    files = {
      winopts = {
        preview = { hidden = "hidden" },
      },
      actions = {
        ["ctrl-g"] = actions.toggle_ignore,
      },
    },
  })
  fzf.register_ui_select()
end)
------------------------------------------------------------------------------
-- Configuration of all parts of mini.nvim                                  --
------------------------------------------------------------------------------

-- [[ AI ]] ------------------------------------------------------------------
later(function()
  require("mini.ai").setup()
end)

-- [[ Align ]] ---------------------------------------------------------------
later(function()
  require("mini.align").setup()
end)

-- [[ Animate ]] -------------------------------------------------------------
later(function()
  -- This is needed for mini.animate to work with mouse scrolling
  vim.opt.mousescroll = "ver:1,hor:1"
  local animate = require("mini.animate")
  animate.setup({
    scroll = {
      -- Disable Scroll Animations, as the can interfere with mouse Scrolling
      enable = false,
    },
    cursor = {
      timing = animate.gen_timing.cubic({ duration = 50, unit = "total" }),
    },
  })
end)

-- [[ Collection of basic options ]] -----------------------------------------
later(function()
  require("mini.basics").setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = "rounded",
    },
    mappings = {
      basic = true,
      -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
      -- Supply empty string to not create these mappings.
      --option_toggle_prefix = [[\]],
      option_toggle_prefix = "",
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
end)

-- [[ Bracketed ]] -----------------------------------------------------------
later(function()
  require("mini.bracketed").setup()
end)

-- [[ Bufremove ]] -----------------------------------------------------------
later(function()
  require("mini.bufremove").setup()
  vim.keymap.set("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })
  vim.keymap.set("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(0,  true)<CR>", { desc = "Delete! buffer" })

  vim.keymap.set("n", "<leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", { desc = "Wipeout buffer" })
  vim.keymap.set("n", "<leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", { desc = "Wipeout! buffer" })
end)
-- [[ Clues (Whichkey replacement) ]] ----------------------------------------
local hints = {}
local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

    -- mini.basics
    { mode = "n", keys = [[\]] },

    -- mini.bracketed
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "x", keys = "[" },
    { mode = "x", keys = "]" },

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

    { mode = "n", keys = "s" },
    { mode = "x", keys = "s" },
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
    { mode = "n", keys = "<Leader>f", desc = "+Find" },
    { mode = "n", keys = "<Leader>g", desc = "+Git" },
    { mode = "n", keys = "<Leader>l", desc = "+LSP" },
    { mode = "n", keys = "<Leader>m", desc = "+Minimap" },
    { mode = "n", keys = "<Leader>s", desc = "+Session" },
    { mode = "n", keys = "<Leader>t", desc = "+TrailSpace" },
    { mode = "n", keys = "<Leader>u", desc = "+UI" },
    { mode = "n", keys = "<Leader>v", desc = "+Workspace" },
    { mode = "n", keys = "<Leader>w", desc = "+Windows" },
    { mode = "n", keys = "<Leader>/", desc = "+FZF" },
  },
  window = {
    config = {
      anchor = "SE",
      row = "auto",
      col = "auto",
      width = "auto",
      border = "rounded",
    },
    delay = 0,
  },
})

-- [[ 'gc' to toggle comment ]] ----------------------------------------------
later(function()
  require("mini.comment").setup()
end)

-- [[ Completion ]] ----------------------------------------------------------
-- later(function()
--   require("mini.completion").setup({
--     lsp_completion = {
--       source_func = "omnifunc",
--       auto_setup = false,
--       process_items = function(items, base)
--         -- Don't show 'Text' and 'Snippet' suggestions
--         items = vim.tbl_filter(function(x)
--           return x.kind ~= 1 and x.kind ~= 15
--         end, items)
--         return MiniCompletion.default_process_items(items, base)
--       end,
--     },
--     fallback_action = function() end,
--     set_vim_settings = false,
--     window = {
--       info = { height = 25, width = 80, border = "rounded" },
--       signature = { height = 25, width = 80, border = "rounded" },
--     },
--   })
-- end)

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
later(function()
  require("mini.cursorword").setup()
end)

-- [[ Mini Diff ]] -----------------------------------------------------------
later(function()
  require("mini.diff").setup({
    -- view = {
    --   style = 'sign',
    --   signs = { add = '+', change = '~', delete = '-' },
    -- }
  })
end)

-- [[ Mini.Extras ]] ---------------------------------------------------------
later(function()
  require("mini.extra").setup()
end)

-- [[ Files ]] ---------------------------------------------------------------
later(function()
  require("mini.files").setup({
    mappings = {
      close = "q",
      go_in = "L",
      go_in_plus = "l",
      go_out = "H",
      go_out_plus = "h",
      reset = ",",
      show_help = "?",
    },

    -- Only automated preview is possible
    windows = {
      preview = true,
      width_focus = 40,
      width_preview = 75,
      height_focus = 20,
      max_number = math.huge,
    },
  })
  local minifiles_augroup = vim.api.nvim_create_augroup("ec-mini-files", {})
  vim.api.nvim_create_autocmd("User", {
    group = minifiles_augroup,
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
      vim.api.nvim_win_set_config(args.data.win_id, { border = "single" })
    end,
  })
end)

vim.keymap.set("n", "<leader>ed", "<cmd>lua MiniFiles.open()<cr>", { desc = "Find Manual" })
vim.keymap.set(
  "n",
  "<leader>ef",
  [[<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>]],
  { desc = "File directory" }
)
vim.keymap.set("n", "<leader>em", [[<Cmd>lua MiniFiles.open('~/.config/nvim')<CR>]], { desc = "Mini.nvim directory" })

-- [[ Fuzzy ]] ---------------------------------------------------------------
later(function()
  require("mini.fuzzy").setup()
end)

-- [[ Git ]] -----------------------------------------------------------------
later(function()
  require("mini.git").setup()
end)
local rhs = "<Cmd>lua MiniGit.show_at_cursor()<CR>"
vim.keymap.set({ "n", "x" }, "<Leader>gs", rhs, { desc = "Show at cursor" })
vim.keymap.set("n", "<Leader>go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "toggle overlay" })

-- [[ HiPatterns ]] ----------------------------------------------------------
later(function()
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
end)

-- [[ Icons ]] ---------------------------------------------------------------
later(function()
  local miniicons = require("mini.icons")
  miniicons.setup({
    style = "glyph",
  })
  miniicons.mock_nvim_web_devicons()
  miniicons.tweak_lsp_kind()
end)

-- [[ Animated indentation guide ]] ------------------------------------------
later(function()
  require("mini.indentscope").setup({
    draw = {
      animation = function()
        return 1
      end,
    },
    symbol = "│",
    --symbol = "▏",
    options = {
      try_as_border = true,
      border = "both",
      indent_at_cursor = true,
    },
  })
end)

-- [[ Jump2d ]] --------------------------------------------------------------
later(function()
  local minijump2d = require("mini.jump2d")
  minijump2d.setup({
    labels = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
    view = {
      dim = true,
      n_steps_ahead = 2,
    },
  })
  vim.keymap.set(
    "n",
    "gl",
    "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<cr>",
    { desc = "Jump2d Line Start" }
  )
  vim.keymap.set(
    "n",
    "gz",
    "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<cr>",
    { desc = "Jump2d Word Start" }
  )
  vim.keymap.set("n", "g!", function()
    minijump2d.start({
      spotter = minijump2d.gen_pattern_spotter("['\"`]"),
    })
  end, { desc = "Jump2d Quote" })
  vim.keymap.set(
    { "o", "x", "n" },
    "<Cr>",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
    { desc = "Jump anywhere" }
  )
end)

-- [[ Jump ]] --------------------------------------------------------------
later(function()
  require("mini.jump").setup({})
end)

-- [[ MiniMap ]] -------------------------------------------------------------
later(function()
  local minimap = require("mini.map")
  local encode_symbols = minimap.gen_encode_symbols.block("3x2")
  -- Use dots in `st` terminal because it can render them as blocks
  if vim.startswith(vim.fn.getenv("TERM"), "st") then
    encode_symbols = minimap.gen_encode_symbols.dot("4x2")
  end
  minimap.setup({
    symbols = { encode = encode_symbols },
    integrations = {
      minimap.gen_integration.builtin_search(),
      minimap.gen_integration.diff(),
      minimap.gen_integration.diagnostic({
        error = "DiagnosticFloatingError",
        warn = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
      }),
    },
    window = {
      width = 20,
    },
  })
  vim.keymap.set("n", "<Leader>mc", minimap.close, { desc = "Minimap Close" })
  vim.keymap.set("n", "<Leader>mf", minimap.toggle_focus, { desc = "Minimap Focus" })
  vim.keymap.set("n", "<Leader>mo", minimap.open, { desc = "Minimap Open" })
  vim.keymap.set("n", "<Leader>mr", minimap.refresh, { desc = "Minimap Refresh" })
  vim.keymap.set("n", "<Leader>ms", minimap.toggle_side, { desc = "Minimap Swap Side" })
  vim.keymap.set("n", "<Leader>mt", minimap.toggle, { desc = "Minimap Toggle" })
  vim.keymap.set("n", "<F5>", minimap.toggle, { desc = "Minimap Toggle" })
  vim.keymap.set("n", [[\h]], ":let v:hlsearch = 1 - v:hlsearch<CR>", { desc = "Toggle hlsearch" })
  for _, key in ipairs({ "n", "N", "*" }) do
    vim.keymap.set("n", key, key .. "zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>")
  end
end)

-- [[ Misc ]] ----------------------------------------------------------------
now(function()
  local minimisc = require("mini.misc")
  minimisc.setup({ make_global = { "put", "put_text", "stat_summary", "bench_time" } })
  minimisc.setup_auto_root({ ".git", "Makefile", ".forceignore", "sfdx-project.json" }, function()
    vim.notify("Mini find_root failed.", vim.log.levels.WARN)
  end)
  minimisc.setup_restore_cursor({
    ignore_filetype = { "gitcommit", "gitrebase", "SFTerm", "fzf" },
  })
end)

-- [[ Move ]] ----------------------------------------------------------------
later(function()
  require("mini.move").setup()
end)

-- [[ Notify ]] --------------------------------------------------------------
now(function()
  local mininotify = require("mini.notify")
  local filterout_lua_diagnosing = function(notif_arr)
    local not_diagnosing = function(notif)
      return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
    end
    notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
    return MiniNotify.default_sort(notif_arr)
  end
  mininotify.setup({
    content = { sort = filterout_lua_diagnosing },
    window = { config = { row = 2, border = "rounded" } },
  })

  -- later(function()
  --   require("mini.notify").setup({
  --     -- Notifications about LSP progress
  --     lsp_progress = {
  --       -- Whether to enable showing
  --       enable = true,
  --       -- Duration (in ms) of how long last message should be shown
  --       duration_last = 1000,
  --     },
  --   })
  vim.notify = require("mini.notify").make_notify()
end)

-- [[ Operators ]] -----------------------------------------------------------
-- later(function() require("mini.operators").setup() end)

-- [[ Pairs ]] ---------------------------------------------------------------
later(function()
  require("mini.pairs").setup({
    mappings = {
      ["("] = { neigh_pattern = "[^\\%w]." },
      ["["] = { neigh_pattern = "[^\\%w]." },
      ["{"] = { neigh_pattern = "[^\\%w]." },
      ['"'] = { neigh_pattern = "[^\\%w]." },
      ["'"] = { neigh_pattern = "[^\\%w]." },
      ["`"] = { neigh_pattern = "[^\\%w]." },
    },
  })
end)

-- [[ Configure Mini.pick ]] -------------------------------------------------
later(function()
  local minipick = require("mini.pick")
  local miniextra = require("mini.extra")
  local win_config = function()
    height = math.floor(0.618 * vim.o.lines)
    width = math.floor(0.618 * vim.o.columns)
    return {
      anchor = "NW",
      height = height,
      width = width,
      border = "rounded",
      row = math.floor(0.5 * (vim.o.lines - height)),
      col = math.floor(0.5 * (vim.o.columns - width)),
    }
  end
  minipick.setup({
    mappings = {
      choose_in_vsplit = "<C-CR>",
    },
    options = {
      use_cache = true,
    },
    window = {
      config = win_config,
    },
  })

  vim.ui.select = minipick.ui_select

  vim.keymap.set("n", "<leader><space>", minipick.builtin.buffers, { desc = "Find existing buffers" })

  vim.keymap.set("n", "<leader>ff", minipick.builtin.files, { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fh", minipick.builtin.help, { desc = "Find Help" })
  vim.keymap.set("n", "<leader>fg", minipick.builtin.grep_live, { desc = "Find by Grep" })
  --vim.keymap.set("n", "<leader>fr", MiniPick.builtin.resume, { desc = "Resume" })
  vim.keymap.set("n", "<leader>fe", miniextra.pickers.explorer, { desc = "Explorer" })
  vim.keymap.set("n", "<leader>fk", miniextra.pickers.keymaps, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fr", miniextra.pickers.oldfiles, { desc = "Find Recent Files" })
  vim.keymap.set("n", "<leader>f/", [[<Cmd>Pick history scope='/'<CR>]], { desc = '"/" history' })
  vim.keymap.set("n", "<leader>f:", [[<Cmd>Pick history scope=':'<CR>]], { desc = '":" history' })
  vim.keymap.set("n", "<leader>fa", [[<Cmd>Pick git_hunks scope='staged'<CR>]], { desc = "Added hunks (all)" })
  vim.keymap.set(
    "n",
    "<leader>fA",
    [[<Cmd>Pick git_hunks path='%' scope='staged'<CR>]],
    { desc = "Added hunks (current)" }
  )
  vim.keymap.set("n", "<leader>fb", [[<Cmd>Pick buffers<CR>]], { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fC", [[<Cmd>Pick git_commits<CR>]], { desc = "Commits (all)" })
  vim.keymap.set("n", "<leader>fc", [[<Cmd>Pick git_commits path='%'<CR>]], { desc = "Commits (current)" })
  vim.keymap.set("n", "<leader>fD", [[<Cmd>Pick diagnostic scope='all'<CR>]], { desc = "Diagnostic workspace" })
  vim.keymap.set("n", "<leader>fd", [[<Cmd>Pick diagnostic scope='current'<CR>]], { desc = "Diagnostic buffer" })
  vim.keymap.set("n", "<leader>fG", [[<Cmd>Pick grep pattern='<cword>'<CR>]], { desc = "Grep current word" })
  vim.keymap.set("n", "<leader>fH", [[<Cmd>Pick hl_groups<CR>]], { desc = "Highlight groups" })
  vim.keymap.set("n", "<leader>fL", [[<Cmd>Pick buf_lines scope='all'<CR>]], { desc = "Lines (all)" })
  vim.keymap.set("n", "<leader>fl", [[<Cmd>Pick buf_lines scope='current'<CR>]], { desc = "Lines (current)" })
  vim.keymap.set("n", "<leader>fM", [[<Cmd>Pick git_hunks<CR>]], { desc = "Modified hunks (all)" })
  vim.keymap.set("n", "<leader>fm", [[<Cmd>Pick git_hunks path='%'<CR>]], { desc = "Modified hunks (current)" })
  vim.keymap.set("n", "<leader>fR", [[<Cmd>Pick lsp scope='references'<CR>]], { desc = "References (LSP)" })
  vim.keymap.set(
    "n",
    "<leader>fS",
    [[<Cmd>Pick lsp scope='workspace_symbol'<CR>]],
    { desc = "Symbols workspace (LSP)" }
  )
  vim.keymap.set("n", "<leader>fs", [[<Cmd>Pick lsp scope='document_symbol'<CR>]], { desc = "Symbols buffer (LSP)" })
  vim.keymap.set("n", "<leader>fV", [[<Cmd>Pick visit_paths cwd=''<CR>]], { desc = "Visit paths (all)" })
  vim.keymap.set("n", "<leader>fv", [[<Cmd>Pick visit_paths<CR>]], { desc = "Visit paths (cwd)" })

  pattern =
    "MiniPickStop", vim.keymap.set("n", "<leader>fv", [[<Cmd>Pick visit_paths<CR>]], { desc = "Visit paths (cwd)" })

  -- Picker pre- and post-hooks ===============================================

  -- Keys should be a picker source.name. Value is a callback function that
  -- accepts same arguments as User autocommand callback.
  local hooks = {
    pre_hooks = {},
    post_hooks = {},
  }

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "MiniPickStart",
    group = vim.api.nvim_create_augroup("minipick-pre-hooks", { clear = true }),
    desc = "Invoke pre_hook for specific picker based on source.name.",
    callback = function(...)
      local opts = minipick.get_picker_opts() or {}
      local pre_hook = hooks.pre_hooks[opts.source.name] or function(...) end
      pre_hook(...)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "MiniPickStop",
    group = vim.api.nvim_create_augroup("minipick-post-hooks", { clear = true }),
    desc = "Invoke post_hook for specific picker based on source.name.",
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
    vim.cmd("colorscheme " .. selected_colorscheme)
  end

  minipick.registry.colorschemes = function()
    local colorschemes = vim.fn.getcompletion("", "color")
    return minipick.start({
      source = {
        name = "colorschemes",
        items = colorschemes,
        choose = function(item)
          selected_colorscheme = item
        end,
        preview = function(buf_id, item)
          vim.cmd("colorscheme " .. item)
          vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
        end,
      },
    })
  end
end)

-- [[ Session ]] -------------------------------------------------------------
now(function()
  local minisessions = require("mini.sessions")
  minisessions.setup({ autowrite = true })
  --- Wrapper around mini.sessions functions. Returns a function that
  --- behaves differently based on the given scope.
  ---
  ---@param scope "local"|"write"|"read"|"delete"
  ---@return function
  local function session(scope)
    return function()
      if scope == "local" then
        minisessions.write("Session.vim")
      else
        minisessions.select(scope)
      end
    end
  end

  -- Mappings
  map("n", "<Leader>sl", session("local"), "Write a local session")
  map("n", "<Leader>sw", session("write"), "Write a session")
  map("n", "<Leader>sr", session("read"), "Read a session")
  map("n", "<Leader>sd", session("delete"), "Delete a session")
end)

-- [[ Starter ]] -------------------------------------------------------------
now(function()
  local logo = table.concat({
    "     _____  .__       .______   ____.__             ",
    "    /     \\ |__| ____ |__\\   \\ /   /|__| _____   ",
    "   /  \\ /  \\|  |/    \\|  |\\   Y   / |  |/     \\  ",
    "  /    Y    \\  |   |  \\  | \\     /  |  |  Y Y  \\ ",
    "  \\____|__  /__|___|  /__|  \\___/   |__|__|_|  / ",
    "          \\/        \\/                       \\/  ",
    "",
    "Pwd: " .. vim.fn.getcwd(),
  }, "\n")
  require("mini.starter").setup({
    autoopen = true,
    evaluate_single = true,
    header = logo,
    items = {
      require("mini.starter").sections.builtin_actions(),
      require("mini.starter").sections.pick(),
      require("mini.starter").sections.recent_files(5, false),
      require("mini.starter").sections.sessions(5, true),
      { action = "Mason", name = "Mason", section = "Plugin Actions" },
      { action = "DepsUpdate", name = "Update deps", section = "Plugin Actions" },
    },
  })
end)

-- [[ Statusline ]] ----------------------------------------------------------
now(function()
  -- local lsp_client = function(msg)
  --   msg = msg or ""
  --   local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  --
  --   if next(buf_clients) == nil then
  --     if type(msg) == "boolean" or #msg == 0 then
  --       return ""
  --     end
  --     return msg
  --   end
  --
  --   local buf_client_names = {}
  --
  --   -- add client
  --   for _, client in pairs(buf_clients) do
  --     if client.name ~= "null-ls" then
  --       table.insert(buf_client_names, client.name)
  --     end
  --   end
  --
  --   local hash = {}
  --   local client_names = {}
  --   for _, v in ipairs(buf_client_names) do
  --     if not hash[v] then
  --       client_names[#client_names + 1] = v
  --       hash[v] = true
  --     end
  --   end
  --   table.sort(client_names)
  --   return "LSP:" .. table.concat(client_names, ", ")
  -- end

  --- This functions checks if a macro is being recorded in Neovim.
  -- @return string El estado de la grabación, ya sea una cadena vacía o una cadena con el icono de grabación y el nombre del registro.
  local function isRecording()
    local reg = vim.fn.reg_recording()
    if reg == "" then
      return ""
    end -- not recording
    return " " .. reg
  end

  --- Esta función verifica si el texto en la ventana actual de Neovim está ajustado.
  -- @return string El estado del ajuste de texto, ya sea una cadena vacía o una cadena con el icono de ajuste.
  local function isWrapped()
    local wrap = vim.wo.wrap and "WR" or ""
    return wrap
  end

  local function isLspHintsActive()
    local hints_enabled = vim.lsp.inlay_hint.is_enabled() and " " or ""
    return hints_enabled
  end

  local get_lsp_names = function()
    local lsp_names_list = vim.tbl_map(function(lsp)
      return lsp.config.name
    end, vim.lsp.get_clients({ bufnr = 0 }))

    if vim.tbl_isempty(lsp_names_list) then
      return ""
    end

    return " " .. table.concat(lsp_names_list, ",")
  end

  local ministatusline = require("mini.statusline")
  ministatusline.setup({
    content = {
      active = function()
        -- stylua: ignore start
        local mode, mode_hl = ministatusline.section_mode({ trunc_width = 120 })
        local spell         = vim.wo.spell and (ministatusline.is_truncated(120) and 'S' or 'SPELL') or ''
        local wrap          = vim.wo.wrap and (ministatusline.is_truncated(120) and 'W' or 'WRAP') or ''
        local git           = ministatusline.section_git({ trunc_width = 40 })
        local diff          = ministatusline.section_diff({ trunc_width = 75, icon = "" })
        -- local diff          = vim.b.minidiff_summary_string or ''
        -- local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
        local diagnostics   = ministatusline.section_diagnostics({ trunc_width = 75, icon = "" })
        local filename      = ministatusline.section_filename({ trunc_width = 140 })
        if filename:sub(1, 2) == "%F" or filename:sub(1, 2) == "%f" then
          filename = filename:sub(1, 2) .. " " .. filename:sub(3, -1)
        end
        local fileinfo      = ministatusline.section_fileinfo({ trunc_width = 120 })
        local searchcount   = ministatusline.section_searchcount({ trunc_width = 75 })
        --local navic         = require 'nvim-navic'.get_location()
        local location      = ministatusline.section_location({ trunc_width = 75 })
        local location2     = "%7(%l/%3L%):%-2c %P"
        local spaces        = function()
          local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
          return "SPC:" .. shiftwidth
        end
        local lsp           = get_lsp_names()
        local recording     = isRecording()
        --        local wrapped       = isWrapped()
        --        local spell         = spellOn()
        local hints_enabled = isLspHintsActive()
        local git_and_diff  = string.format("%s %s", git, diff and diff:sub(2) or "")

        return ministatusline.combine_groups({
          { hl = mode_hl,                 strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
          '%<',
          { hl = 'MiniStatuslineFilename',                      strings = { filename } },
          -- { hl = 'MiniStatuslineFilename', strings = { navic } },
          '%=',
          { strings = { hints_enabled, recording, wrap, spell } },
          --      { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics, lsp } },
          { hl = 'MiniStatuslineFileinfo',                      strings = { spaces(), fileinfo } },
          { hl = mode_hl,                                       strings = { searchcount } },
          { hl = mode_hl,                                       strings = { location2 } },
        })
      end,
    },
    use_icons = true,
    set_vim_settings = true,
  })
end)

-- [[ Surround ]] ------------------------------------------------------------
later(function()
  require("mini.surround").setup({})
end)
vim.keymap.set({ "n", "x" }, "s", "<Nop>")
vim.keymap.set({ "n", "x" }, "S", "<Nop>")

-- [[ Tabline ]] -------------------------------------------------------------
now(function()
  require("mini.tabline").setup()
end)

-- [[ Trailspace ]] ----------------------------------------------------------
now(function()
  local minitrailspace = require("mini.trailspace")
  minitrailspace.setup()
  map("n", "<leader>ts", minitrailspace.trim, "trim space")
  map("n", "<leader>te", minitrailspace.trim_last_lines, "trim end-line")
end)

-- [[ Visits ]] --------------------------------------------------------------
later(function()
  require("mini.visits").setup()
end)

------------------------------------------------------------------------------
-- [[ END OF MINI CONFIG ]] --------------------------------------------------
------------------------------------------------------------------------------
now(function()
  add("rmagatti/alternate-toggler")

  require("alternate-toggler").setup({
    alternates = {
      ["true"] = "false",
      ["top"] = "bottom",
      ["left"] = "right",
      ["True"] = "False",
      ["TRUE"] = "FALSE",
      ["Yes"] = "No",
      ["YES"] = "NO",
      ["1"] = "0",
      ["<"] = ">",
      ["("] = ")",
      ["["] = "]",
      ["{"] = "}",
      ['"'] = "'",
      ['""'] = "''",
      ["+"] = "-",
      ["==="] = "!==",
    },
  })
  vim.keymap.set(
    "n",
    "<leader>i", -- <space><space>
    "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>",
    { desc = "Toggle value" }
  )
end)

now(function()
  add("catppuccin/nvim")
  require("catppuccin").setup({
    integrations = {
      cmp = false,
      gitsigns = true,
      nvimtree = false,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  })
end)
vim.cmd.colorscheme("catppuccin-macchiato")

-- [[ Configure Treesitter ]] ------------------------------------------------
later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "master",
    monitor = "main",
    -- Perform action after every checkout
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "javascript",
      "vimdoc",
      "vim",
      "bash",
    },
    sync_install = false,
    ignore_install = {},

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  })
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>lj", [[<Cmd>lua vim.diagnostic.goto_next()<CR>]], { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>lk", [[<Cmd>lua vim.diagnostic.goto_prev()<CR>]], { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
--vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>ds", function()
  require("fzf-lua").lsp_document_symbols()
end, { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>dd", function()
  require("fzf-lua").lsp_document_diagnostics()
end, { desc = "Document Diagnostics" })

vim.diagnostic.config({ update_in_insert = true })

-- LSP Configuration & Plugins
now(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      --      { "j-hui/fidget.nvim" },
      "folke/lazydev.nvim",
    },
  })

  -- Set up Mason before anything else
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
    },
    automatic_installation = true,
  })
  -- Quick access via keymap
  vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Show Mason" })

  -- Neodev setup before LSP config
  require("lazydev").setup()

  -- Set up cool signs for diagnostics
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Diagnostic config
  local config = {
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
      severity = { min = "ERROR", max = "ERROR" },
      --  format = function(d) return "" end
    },
    signs = {
      active = signs,
      -- With highest priority
      priority = 9999,
      -- Only for warnings and errors
      severity = { min = "WARN", max = "ERROR" },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
  vim.diagnostic.config(config)

  -- This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(client, bufnr)
    local methods = vim.lsp.protocol.Methods
    local nmap = function(keys, func, desc, mode)
      mode = mode or "n"
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>lD", "<cmd>:Pick lsp scope='definition'<cr>", "[G]oto [D]efinition")
    nmap("<leader>lR", "<cmd>:Pick lsp scope='references'<cr>", "References")
    nmap("<leader>lI", "<cmd>:Pick lsp scope='implementation'<cr>", "[G]oto [I]mplementation")
    nmap("<leader>lt", "<cmd>:Pick lsp scope='type_definition'<cr>", "Type Definition")
    --nmap("<leader>ds", "<cmd>:Pick lsp scope='document_symbol'<cr>", "Document Symbols")
    nmap("<leader>la", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], "Arguments popup")
    nmap("<leader>ld", [[<Cmd>lua vim.diagnostic.open_float()<CR>]], "Diagnostics popup")
    --    nmap('<leader>lf', [[<Cmd>:Format<cr>]], 'Format')
    nmap("<leader>li", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], "Information")
    --    nmap('<leader>lR', [[<Cmd>lua vim.lsp.buf.references()<CR>]], 'References')
    nmap("<leader>ls", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], "Source definition")

    nmap("<c-j>", "<cmd>lua vim.diagnostic.goto_next({float={source=true}})<cr>")
    nmap("<c-k>", "<cmd>lua vim.diagnostic.goto_prev({float={source=true}})<cr>")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    nmap("<leader>lf", "<cmd>Format<cr>", "Format")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

    -- only if capeable
    if client.supports_method(methods.textDocument_rename) then
      nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
    end

    -- if client.server_capabilities.documentSymbolProvider then
    --   navic.attach(client, bufnr)
    -- end

    if client.supports_method(methods.textDocument_codeAction) then
      nmap("<leader>ca", function()
        require("fzf-lua").lsp_code_actions({
          winopts = {
            relative = "cursor",
            width = 0.6,
            height = 0.6,
            row = 1,
            preview = { vertical = "up:70%" },
          },
        })
      end, "Code actions", { "n", "v" })
    end

    local status_ok, highlight_supported = pcall(function()
      return client.supports_method("textDocument/documentHighlight")
    end)
    if not status_ok or not highlight_supported then
      return
    end

    local group_name = "lsp_document_highlight"
    local ok, hl_autocmds = pcall(vim.api.nvim_get_autocmds, {
      group = group_name,
      buffer = bufnr,
      event = "CursorHold",
    })

    if ok and #hl_autocmds > 0 then
      return
    end

    vim.api.nvim_create_augroup(group_name, { clear = false })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group_name,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group_name,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  --local capabilities = vim.lsp.protocol.make_client_capabilities()
  --local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- Lua
  require("lspconfig")["lua_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

  -- Python
  require("lspconfig")["pylsp"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          flake8 = {
            enabled = true,
            maxLineLength = 88, -- Black's line length
          },
          -- Disable plugins overlapping with flake8
          pycodestyle = {
            enabled = false,
          },
          mccabe = {
            enabled = false,
          },
          pyflakes = {
            enabled = false,
          },
          -- Use Black as the formatter
          autopep8 = {
            enabled = false,
          },
        },
      },
    },
  })
  --
end)

-- vim: ts=2 sts=2 sw=2 et
