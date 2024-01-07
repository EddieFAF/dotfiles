--[[

******************************************************************************
* init.lua                                                                   *
* Neovim config mostly based on mini.nvim from echasnovski                   *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.1                                                                *
* initial release                                                            *
******************************************************************************

--]]

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Starting setup of plugins
require("lazy").setup({
    -- The star of the show
    {
      "echasnovski/mini.nvim",
      version = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
      },
    },
    { "gelguy/wilder.nvim", build = ":UpdateRemotePlugins" }, -- : autocomplete
    {
      'ibhagwan/fzf-lua',
      event = 'VeryLazy',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      -- stylua: ignore
      keys = {
        { '<leader>/c',  function() require('fzf-lua').commands() end,        desc = 'Search commands', },
        { '<leader>/C',  function() require('fzf-lua').command_history() end, desc = 'Search command history', },
        { '<leader>/b',  function() require('fzf-lua').buffers() end,         desc = 'Find buffers', },
        { '<leader>/f',  function() require('fzf-lua').files() end,           desc = 'Find files', },
        { '<leader>/o',  function() require('fzf-lua').oldfiles() end,        desc = 'Find recent files', },
        { '<leader>/h',  function() require('fzf-lua').highlights() end,      desc = 'Search highlights', },
        { '<leader>/M',  function() require('fzf-lua').marks() end,           desc = 'Search marks', },
        { '<leader>/k',  function() require('fzf-lua').keymaps() end,         desc = 'Search keymaps', },
        { '<leader>/t',  function() require('fzf-lua').treesitter() end,      desc = 'Search treesitter', },
        { '<leader>/gf', function() require('fzf-lua').git_files() end,       desc = 'Find git files', },
        { '<leader>/gb', function() require('fzf-lua').git_branches() end,    desc = 'Search git branches', },
        { '<leader>/gc', function() require('fzf-lua').git_commits() end,     desc = 'Search git commits', },
        { '<leader>/gC', function() require('fzf-lua').git_bcommits() end,    desc = 'Search git buffer commits', },
        { '<leader>//',  function() require('fzf-lua').resume() end,          desc = 'Resume FZF', },
        { '<leader>/d',  '<cmd>FzfLua lsp_document_diagnostics<cr>',          desc = 'Document diagnostics' },
      },
      config = function()
        local fzf = require 'fzf-lua'
        local actions = require 'fzf-lua.actions'
        fzf.setup {
          keymap = {
            builtin = {
              ['<C-/>'] = 'toggle-help',
              ['<C-a>'] = 'toggle-fullscreen',
              ['<C-i>'] = 'toggle-preview',
              ['<C-f>'] = 'preview-page-down',
              ['<C-b>'] = 'preview-page-up',
            },
            fzf = {
              ['CTRL-Q'] = 'select-all+accept',
            },
          },
          fzf_colors = {
            bg = { 'bg', 'Normal' },
            gutter = { 'bg', 'Normal' },
            info = { 'fg', 'Conditional' },
            scrollbar = { 'bg', 'Normal' },
            separator = { 'fg', 'Comment' },
          },
          winopts = {
            height = 0.7,
            width = 0.55,
            preview = {
              scrollbar = false,
              layout = 'vertical',
              vertical = 'up:40%',
            },
          },
          files = {
            winopts = {
              preview = { hidden = 'hidden' },
            },
            actions = {
              ['ctrl-g'] = actions.toggle_ignore,
            },
          },
        }
        fzf.register_ui_select()
      end,
    },
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      keys = {
        {
          '<Leader>ub',
          function()
            local off = vim.b['barbecue_entries'] == nil
            require('barbecue.ui').toggle(off and true or nil)
          end,
          desc = 'Breadcrumbs toggle',
        },
      },
      opts = {
        -- configurations go here
        show_dirname = false,
        show_modified = true,
        show_basename = false,
        theme = 'tokyonight',
      },
    },
    {
      -- LSP Configuration & Plugins
      "neovim/nvim-lspconfig",
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        -- {
        --   "j-hui/fidget.nvim",
        --   opts = {
        --     progress = {
        --       display = {
        --         progress_icon = { pattern = "dots", period = 1 },
        --       },
        --       ignore = {
        --         "null-ls",
        --         "tailwindcss",
        --       },
        --     },
        --     notification = {
        --       override_vim_notify = true,
        --       window = {
        --         winblend = 150,
        --         max_width = 200,
        --       },
        --     },
        --   },
        -- },

        -- Additional lua configuration, makes nvim stuff amazing!
        "folke/neodev.nvim",
      },
    },
    {
      'folke/tokyonight.nvim',
      enabled = true,
      lazy = false,
      config = function()
        require('tokyonight').setup {
          style = 'night',
          light_style = 'day',
          transparent = true,
          styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = 'dark',
            floats = 'dark',
          },
          hide_inactive_statusline = false,
          dim_inactive = true,
          lualine_bold = true,
        }
        --      vim.cmd 'colorscheme tokyonight'
      end,
    },
    {
      'navarasu/onedark.nvim',
      enabled = true,
      lazy = false,
      priority = 1000, -- Ensure it loads first
      config = function()
        require('onedark').setup {
          transparent = true,
          term_colors = true,
          ending_tildes = false,
          code_style = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'bold',
            strings = 'none',
            variables = 'italic',
          },
          diagnostics = {
            darker = true,
            undercurl = true,
            background = true,
          },
        }
      end,
    },

    {
      -- show gitstatus in statuscolumn and more
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        signs = {
          -- add = { text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          -- change = { text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          -- delete = { text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          -- topdelete = { text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          add = { text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          untracked = { text = "│" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,
        linehl = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },

        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      },
    },

    {
      -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      build = ":TSUpdate",
    },

  },
  {
    checker = { enabled = true },
  })

-- [[ Keymappings ]] ---------------------------------------------------------
vim.keymap.set("n", "<esc>", ":noh<cr><esc>", { desc = "Remove Search Highlight" })
vim.keymap.set("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>L", ":Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>M", ":Mason<cr>", { desc = "Mason" })
-- increment/decrement
vim.keymap.set("n", "-", "<C-x>", { desc = "decrement" })
vim.keymap.set("n", "+", "<C-a>", { desc = "increment" })
-- Split window
vim.keymap.set("n", "<leader>ss", ":split<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
-- Move window
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<Leader>p", function()
  vim.ui.select({
    "buf_lines",
    "buffers",
    "cli",
    "commands",
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
    "makrs",
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

-- [[ Autocommands ]] --------------------------------------------------------
local function augroup(name)
  return vim.api.nvim_create_augroup("kick_" .. name, { clear = true })
end

-- go to last location
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

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

-- [[ Settings options ]] ----------------------------------------------------
vim.opt.scrolloff = 5
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = '%{expand("%:p")} [%{mode()}]'
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
--vim.opt.foldmethod = "syntax"
vim.opt.termguicolors = true


-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.wildmode = "list:longest,list:full"

-- [[ Setup Wilder Menu ]] ---------------------------------------------------
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

local popupmenu_renderer = wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border = 'rounded',
    highlighter = wilder.basic_highlighter(),
    highlights = { default = "WilderMenu", accent = "WilderAccent" },
    left = {
      ' ',
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = ' a + ',
        icons = { ['+'] = '', a = '', h = '' },
      }),
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar({ thumb_char = ' ' }),
    },
  })
)

local wildmenu_renderer = wilder.wildmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  highlights = { default = "WilderMenu", accent = "WilderAccent" },
  separator = ' · ',
  left = { ' ', wilder.wildmenu_spinner(), ' ' },
  right = { ' ', wilder.wildmenu_index() },
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = popupmenu_renderer,
  ['/'] = wildmenu_renderer,
}))



-- Global
vim.opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.list = true
vim.opt.listchars = {
  --  tab = ">>>",
  tab = "▸ ",
  trail = "·",
  --  precedes = "←",
  --  extends = "→",
  extends = "›",
  precedes = "‹",
  eol = "↲",
  nbsp = "␣",
}
vim.o.foldnestmax = 4
--vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

------------------------------------------------------------------------------
-- Configuration of all parts of mini.nvim                                  --
------------------------------------------------------------------------------

-- [[ AI ]] ------------------------------------------------------------------
require("mini.ai").setup()

-- [[ Animate ]] -------------------------------------------------------------
require("mini.animate").setup()

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

-- [[ Color Palette ]] -------------------------------------------------------
-- local use_cterm, palette
--
-- palette = {
-- 	base00 = "#282c34",
-- 	base01 = "#353b45",
-- 	base02 = "#3e4451",
-- 	base03 = "#545862",
-- 	base04 = "#565c64",
-- 	base05 = "#abb2bf",
-- 	base06 = "#b6bdca",
-- 	base07 = "#c8ccd4",
-- 	base08 = "#e06c75",
-- 	base09 = "#d19a66",
-- 	base0A = "#e5c07b",
-- 	base0B = "#98c379",
-- 	base0C = "#56b6c2",
-- 	base0D = "#61afef",
-- 	base0E = "#c678dd",
-- 	base0F = "#be5046",
-- }
--
-- use_cterm = true
--
-- if palette then
-- 	require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
-- 	vim.g.colors_name = "base16-onedark"
-- end

--require("colors.base16-dracula")
if vim.fn.hostname() == "blackhole" then
--  vim.cmd [[colorscheme onedark]]
  require("colors.base16-onedark")
elseif vim.fn.hostname() == "atomium" then
  require("colors.base16-everforest")
else
  require("colors.base16-tokyo-night-storm")
--  vim.cmd [[colorscheme tokyonight]]
end


-- [[ Bracketed ]] -----------------------------------------------------------
require("mini.bracketed").setup()

-- [[ Bufremove ]] -----------------------------------------------------------
require("mini.bufremove").setup()
vim.keymap.set("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(0,  true)<CR>", { desc = "Delete! buffer" })

vim.keymap.set("n", "<leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", { desc = "Wipeout buffer" })
vim.keymap.set("n", "<leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", { desc = "Wipeout! buffer" })

-- [[ 'gc' to toggle comment ]] ----------------------------------------------
require("mini.comment").setup()

-- [[ Mini Cursorword ]] -----------------------------------------------------
require("mini.cursorword").setup()

-- [[ Files ]] ---------------------------------------------------------------
require("mini.files").setup({
  mappings = {
    -- Here 'L' will also close explorer after opening file.
    -- Switch to `go_in` if you want to not close explorer.
    go_in = "",
    go_in_plus = "L",
    go_out = "H",
    go_out_plus = "",
    -- Will be overriden by manual `<BS>`, which seems wasteful
    reset = "",
    -- Overrides built-in `?` for backward search
    show_help = "?",
  },

  -- Only automated preview is possible
  windows = {
    preview = true,
  },
})

local go_in_plus = function()
  for _ = 1, vim.v.count1 - 1 do
    MiniFiles.go_in()
  end
  local fs_entry = MiniFiles.get_fs_entry()
  local is_at_file = fs_entry ~= nil and fs_entry.fs_type == "file"
  MiniFiles.go_in()
  if is_at_file then
    MiniFiles.close()
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local map_buf = function(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id })
    end

    map_buf("<CR>", go_in_plus)
    map_buf("<Right>", go_in_plus)

    map_buf("<BS>", MiniFiles.go_out)
    map_buf("<Left>", MiniFiles.go_out)

    map_buf("<Esc>", MiniFiles.close)

    -- Add extra mappings from *MiniFiles-examples*
  end,
})
vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open()<cr>", { desc = "Find Manual" })

-- [[ Fuzzy ]] ---------------------------------------------------------------
require("mini.fuzzy").setup()

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

-- [[ MiniMap ]] -------------------------------------------------------------
local map = require("mini.map")
map.setup({
  symbols = {
    encode = require("mini.map").gen_encode_symbols.dot("4x2"),
  },
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.gitsigns(),
    map.gen_integration.diagnostic(),
  },
  window = {
    width = 20,
  },
})
vim.keymap.set("n", "<Leader>mc", MiniMap.close, { desc = "Minimap Close" })
vim.keymap.set("n", "<Leader>mf", MiniMap.toggle_focus, { desc = "Minimap Focus" })
vim.keymap.set("n", "<Leader>mo", MiniMap.open, { desc = "Minimap Open" })
vim.keymap.set("n", "<Leader>mr", MiniMap.refresh, { desc = "Minimap Refresh" })
vim.keymap.set("n", "<Leader>ms", MiniMap.toggle_side, { desc = "Minimap Swap Side" })
vim.keymap.set("n", "<Leader>mt", MiniMap.toggle, { desc = "Minimap Toggle" })
vim.keymap.set("n", "<F5>", MiniMap.toggle, { desc = "Minimap Toggle" })

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

-- [[ Animated indentation guide ]] ------------------------------------------
require("mini.indentscope").setup({
  symbol = "│",
  --symbol = "▏",
  options = {
    try_as_border = true,
    border = "both",
    indent_at_cursor = true,
  },
})

-- [[ Move ]] ----------------------------------------------------------------
require("mini.move").setup()

-- [[ Notify ]] --------------------------------------------------------------
require("mini.notify").setup()
vim.notify = require('mini.notify').make_notify()

-- [[ Starter ]] -------------------------------------------------------------
local logo = table.concat({
  "     _____  .__       .______   ____.__             ",
  "    /     \\ |__| ____ |__\\   \\ /   /|__| _____   ",
  "   /  \\ /  \\|  |/    \\|  |\\   Y   / |  |/     \\  ",
  "  /    Y    \\  |   |  \\  | \\     /  |  |  Y Y  \\ ",
  "  \\____|__  /__|___|  /__|  \\___/   |__|__|_|  / ",
  "          \\/        \\/                       \\/  ",
}, "\n")
local plugin_count = #require('lazy').plugins()
require("mini.starter").setup({
  autoopen = true,
  evaluate_single = true,
  header = logo,
  items = {
    --require("mini.starter").sections.builtin_actions(),
    { action = "enew",           name = "New File",      section = "Files" },
    { action = ":Pick files",    name = "Find Files",    section = "Files" },
    { action = ":Pick oldfiles", name = "Recent Files",  section = "Files" },
    { action = ":Pick explorer", name = "File Explorer", section = "Files" },
    { action = "qa",             name = "Quit",          section = "Files" },
    require("mini.starter").sections.recent_files(7, false),
    { action = "Lazy",  name = "Lazy",  section = "Plugin Actions", },
    { action = "Mason", name = "Mason", section = "Plugin Actions", },
  },
  footer = table.concat({
    " " .. plugin_count .. " plugins installed",
    " " .. os.date(),
  }, "\n"),
})

-- [[ Statusline ]] ----------------------------------------------------------
local lsp_client = function(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  local hash = {}
  local client_names = {}
  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      client_names[#client_names + 1] = v
      hash[v] = true
    end
  end
  table.sort(client_names)
  return "LSP:" .. table.concat(client_names, ", ")
end

require("mini.statusline").setup({
  content = {
    active = function()
      -- stylua: ignore start
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local spell         = vim.wo.spell and (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or ''
      local wrap          = vim.wo.wrap and (MiniStatusline.is_truncated(120) and 'W' or 'WRAP') or ''
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local searchcount   = MiniStatusline.section_searchcount({ trunc_width = 75 })
      -- local navic         = require 'nvim-navic'.get_location()
      -- local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local location2     = "%7(%l/%3L%):%2c %P"
      local lazy_updates  = require("lazy.status").updates
      local spaces        = function()
        local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
        return "SPC:" .. shiftwidth
      end

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode, spell, wrap } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFilename', strings = { lsp_client() } },
        { hl = 'Special',                strings = { lazy_updates() } },
        { hl = 'MiniStatuslineFileinfo', strings = { spaces(), fileinfo } },
        { hl = 'MoreMsg',                strings = { searchcount } },
        { hl = mode_hl,                  strings = { location2 } },
      })
    end,
  },
  use_icons = true,
  set_vim_settings = true,
})

-- [[ Tabline ]] -------------------------------------------------------------
require("mini.tabline").setup()

-- [[ Pairs ]] ---------------------------------------------------------------
require("mini.pairs").setup()

-- [[ Completion ]] ----------------------------------------------------------
require("mini.completion").setup({
  window = {
    info = { height = 25, width = 80, border = "single" },
    signature = { height = 25, width = 80, border = "double" },
  },
})

vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
local keys = {
  ["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
  ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
  ["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
}

_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
  else
    -- If popup is not visible, use plain `<CR>`. You might want to customize
    -- according to other plugins. For example, to use 'mini.pairs', replace
    -- next line with `return require('mini.pairs').cr()`
    return keys["cr"]
  end
end

vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

--require("mini.hues").setup({ background = "#002734", foreground = "#c0c8cc" }) -- azure
--require('mini.hues').setup({ background = '#002734', foreground = '#c0c8cc', n_hues = 6 })
--vim.cmd.colo("randomhue")
--vim.cmd('hi MiniTablineCurrent gui=underline')

-- [[ Mini.Extras ]] ---------------------------------------------------------
require("mini.extra").setup()

-- [[ Configure Mini.pick ]] -------------------------------------------------
require("mini.pick").setup()
vim.ui.select = MiniPick.ui_select

vim.keymap.set("n", "<leader><space>", MiniPick.builtin.buffers, { desc = "Find existing buffers" })

vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find Files" })
--vim.keymap.set("n", "<leader>ff", ':Pick files<cr>', { noremap = true, silent = true, desc = "Find Files" })
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Find by Grep" })
vim.keymap.set("n", "<leader>sr", MiniPick.builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>fe", MiniExtra.pickers.explorer, { desc = "Explorer" })
vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fr", MiniExtra.pickers.oldfiles, { desc = "Find Recent Files" })

-- [[ Configure Treesitter ]] ------------------------------------------------
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  ---@diagnostic disable: missing-fields
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "tsx",
      "javascript",
      "typescript",
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
    ---@diagnostic disable: missing-fields
  })
end, 0)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
--vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>q", ":Pick diagnostic scope='current'<CR>", { desc = "Open diagnostics list" })

-- [[ Configure Navic ]] -----------------------------------------------------
-- require("nvim-navic").setup({
--   depth_limit = 6,
--   depth_limit_indicator = "..",
-- })

-- [[ Configure LSP ]] -------------------------------------------------------
--  This function gets run when an LSP connects to a particular buffer.
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  local methods = vim.lsp.protocol.Methods
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc, mode)
    mode = mode or 'n'
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  --nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  --nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("<leader>gd", "<cmd>:Pick lsp scope='definition'<cr>", "[G]oto [D]efinition")
  nmap("<leader>gr", "<cmd>:Pick lsp scope='references'<cr>", "[G]oto [R]eferences")
  nmap("<leader>gI", "<cmd>:Pick lsp scope='implementation'<cr>", "[G]oto [I]mplementation")
  nmap("<leader>D", "<cmd>:Pick lsp scope='type_definition'<cr>", "Type [D]efinition")
  nmap("<leader>ds", "<cmd>:Pick lsp scope='document_symbol'<cr>", "[D]ocument [S]ymbols")

  -- only if capeable
  if client.supports_method(methods.textDocument_rename) then
    nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  if client.supports_method(methods.textDocument_codeAction) then
    nmap('<leader>ca', function()
      require('fzf-lua').lsp_code_actions {
        winopts = {
          relative = 'cursor',
          width = 0.6,
          height = 0.6,
          row = 1,
          preview = { vertical = 'up:70%' },
        },
      }
    end, 'Code actions', { 'n', 'v' })
  end

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>ws", "<cmd>:Pick lsp scope='workspace_symbol'<cr>", "[W]orkspace [S]ymbols")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- [[ Clues (Whichkey replacement) ]] ----------------------------------------
local hints = {}
local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

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
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),

    hints,

    miniclue.gen_clues.windows({
      submode_move = true,
      submode_navigate = true,
      submode_resize = true,
    }),

    { mode = "n", keys = "<Leader>c", desc = "-> Code" },
    { mode = "n", keys = "<Leader>d", desc = "-> Document" },
    { mode = "n", keys = "<Leader>w", desc = "-> Workspace" },
    { mode = "n", keys = "<Leader>f", desc = "-> Find" },
    { mode = "n", keys = "<Leader>g", desc = "-> Git" },
    { mode = "n", keys = "<Leader>m", desc = "-> Minimap" },
    { mode = "n", keys = "<Leader>/", desc = "-> FZF" },
  },
  window = {
    config = {
      anchor = "SE",
      row = "auto",
      col = "auto",
      width = "auto",
      border = "solid",
    },
    delay = 0,
  },
})

-- [[ Mason Setup ]] ---------------------------------------------------------
-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
