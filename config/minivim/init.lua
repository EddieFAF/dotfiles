--[[

******************************************************************************
* init.lua                                                                   *
* Neovim config mostly based on mini.nvim from echasnovski                   *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.2                                                                *
* initial release                                                            *
******************************************************************************

--]]

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -- Install package manager
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
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
      { '<leader>/gf', function() require('fzf-lua').git_files() end,       desc = 'Find git files', },
      { '<leader>/gb', function() require('fzf-lua').git_branches() end,    desc = 'Search git branches', },
      { '<leader>/gc', function() require('fzf-lua').git_commits() end,     desc = 'Search git commits', },
      { '<leader>/gC', function() require('fzf-lua').git_bcommits() end,    desc = 'Search git buffer commits', },
      { '<leader>//',  function() require('fzf-lua').resume() end,          desc = 'Resume FZF', },
    },
    config = function()
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
        "<Leader>ub",
        function()
          local off = vim.b["barbecue_entries"] == nil
          require("barbecue.ui").toggle(off and true or nil)
        end,
        desc = "Breadcrumbs toggle",
      },
    },
    opts = {
      -- configurations go here
      show_dirname = false,
      show_modified = true,
      show_basename = false,
      theme = "tokyonight",
    },
  },
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Additional lua configuration, makes nvim stuff amazing!
      --"folke/neodev.nvim",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        hide_inactive_statusline = false,
        dim_inactive = true,
        lualine_bold = true,
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
      --      vim.cmd 'colorscheme tokyonight'
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    enabled = false,
    lazy = false,
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        styles = {
          comment = "bold,italic",
        },
        options = {
          cursorline = true,
          highlight_inactive_windows = true,
        },
      })
      vim.cmd("colorscheme onedark")
    end,
  },
  {
    -- show gitstatus in statuscolumn and more
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
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
        map({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gx", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gA", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gX", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
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
}, {
  checker = { enabled = true },
  ui = { border = 'single' },
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
vim.opt.completeopt = "menuone,noinsert,noselect"
--vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 8
vim.opt.softtabstop = -1
vim.opt.expandtab = true
--vim.opt.foldmethod = "syntax"
vim.opt.termguicolors = true

vim.o.autoindent = true        -- Use auto indent
vim.o.expandtab = true         -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.ignorecase = true        -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true         -- Show search results while typing
vim.o.infercase = true         -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true         -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true       -- Make indenting smart
vim.o.virtualedit = "block"    -- Allow going past the end of line in visual block mode

vim.opt.cmdheight = 0

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.wildmode = "list:longest,list:full"

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
vim.cmd('colorscheme catppuccin')

------------------------------------------------------------------------------
-- Configuration of all parts of mini.nvim                                  --
------------------------------------------------------------------------------

-- [[ AI ]] ------------------------------------------------------------------
require("mini.ai").setup()

-- [[ Align ]] ---------------------------------------------------------------
require("mini.align").setup()

-- [[ Animate ]] -------------------------------------------------------------
require("mini.animate").setup({
  scroll = { enable = false },
})

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

    { mode = "n", keys = "<Leader>b", desc = " Buffer" },
    { mode = "n", keys = "<Leader>c", desc = "+Code" },
    { mode = "n", keys = "<Leader>d", desc = "+Document" },
    { mode = "n", keys = "<Leader>e", desc = "+Explorer" },
    { mode = "n", keys = "<Leader>v", desc = "+Workspace" },
    { mode = "n", keys = "<Leader>f", desc = "+Find" },
    { mode = "n", keys = "<Leader>g", desc = "+Git" },
    { mode = "n", keys = "<Leader>l", desc = "+LSP" },
    { mode = "n", keys = "<Leader>m", desc = "+Minimap" },
    { mode = "n", keys = "<Leader>w", desc = "+Windows" },
    { mode = "n", keys = "<Leader>s", desc = "+Session" },
    { mode = "n", keys = "<Leader>u", desc = "+UI" },
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
require("mini.completion").setup({
  lsp_completion = {
    source_func = "omnifunc",
    auto_setup = false,
    process_items = function(items, base)
      -- Don't show 'Text' and 'Snippet' suggestions
      items = vim.tbl_filter(function(x)
        return x.kind ~= 1 and x.kind ~= 15
      end, items)
      return MiniCompletion.default_process_items(items, base)
    end,
  },
  window = {
    info = { height = 25, width = 80, border = "rounded" },
    signature = { height = 25, width = 80, border = "rounded" },
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
    preview = true,
    width_focus = 30,
    width_preview = 40,
    height_focus = 20,
    max_number = math.huge,
  },
})

vim.keymap.set("n", "<leader>ed", "<cmd>lua MiniFiles.open()<cr>", { desc = "Find Manual" })
vim.keymap.set("n", "<leader>ef", [[<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>]],
  { desc = "File directory" })
vim.keymap.set("n", "<leader>em", [[<Cmd>lua MiniFiles.open('~/.config/nvim')<CR>]], { desc = "Mini.nvim directory" })

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

-- if vim.fn.hostname() == "blackhole" then
--   --  vim.cmd [[colorscheme onedark]]
--   require("colors.base16-onedark")
-- elseif vim.fn.hostname() == "atomium" then
--   require("colors.base16-everforest")
-- else
--   require("colors.base16-tokyo-night-storm")
--   --  vim.cmd [[colorscheme tokyonight]]
-- end

-- require('mini.base16').setup({
--   palette = {
--     base00 = "#1A1B26",
--     base01 = "#16161E",
--     base02 = "#2F3549",
--     base03 = "#444B6A",
--     base04 = "#787C99",
--     base05 = "#A9B1D6",
--     base06 = "#CBCCD1",
--     base07 = "#D5D6DB",
--     base08 = "#C0CAF5",
--     base09 = "#A9B1D6",
--     base0A = "#0DB9D7",
--     base0B = "#9ECE6A",
--     base0C = "#B4F9F8",
--     base0D = "#2AC3DE",
--     base0E = "#BB9AF7",
--     base0F = "#F7768E",
--   }
  -- palette = {
  --     base00 = '#1d2021',
  --     base01 = '#3c3836',
  --     base02 = '#504945',
  --     base03 = '#665c54',
  --     base04 = '#bdae93',
  --     base05 = '#d5c4a1',
  --     base06 = '#ebdbb2',
  --     base07 = '#fbf1c7',
  --     base08 = '#fb4934',
  --     base09 = '#fe8019',
  --     base0A = '#fabd2f',
  --     base0B = '#b8bb26',
  --     base0C = '#8ec07c',
  --     base0D = '#83a598',
  --     base0E = '#d3869b',
  --     base0F = '#d65d0e',
  -- }
--})
--require("mini.hues").setup({ background = "#282c34", foreground = "#c8ccd4" }) -- blue

-- [[ Animated indentation guide ]] ------------------------------------------
require("mini.indentscope").setup({
  draw = {
    animation = function() return 1 end,
  },
  symbol = "│",
  --symbol = "▏",
  options = {
    try_as_border = true,
    border = "both",
    indent_at_cursor = true,
  },
})

-- [[ Jump2d ]] --------------------------------------------------------------
require("mini.jump2d").setup({
  view = {
    dim = true,
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
  "gm",
  "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<cr>",
  { desc = "Jump2d Word Start" }
)
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

-- [[ Misc ]] ----------------------------------------------------------------
require("mini.misc").setup()

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
vim.notify = require("mini.notify").make_notify()

-- [[ Operators ]] -----------------------------------------------------------
require("mini.operators").setup()

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
require('mini.pick').setup({
  mappings = {
    choose_in_vsplit = '<C-CR>',
  },
  options = {
    use_cache = true
  },
  window = {
    config = win_config
  }
})

vim.ui.select = MiniPick.ui_select

vim.keymap.set("n", "<leader><space>", MiniPick.builtin.buffers, { desc = "Find existing buffers" })

vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Find by Grep" })
--vim.keymap.set("n", "<leader>fr", MiniPick.builtin.resume, { desc = "Resume" })
vim.keymap.set("n", "<leader>fe", MiniExtra.pickers.explorer, { desc = "Explorer" })
vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fr", MiniExtra.pickers.oldfiles, { desc = "Find Recent Files" })
vim.keymap.set("n", "<leader>f/", [[<Cmd>Pick history scope='/'<CR>]], { desc = '"/" history' })
vim.keymap.set("n", "<leader>f:", [[<Cmd>Pick history scope=':'<CR>]], { desc = '":" history' })
vim.keymap.set("n", "<leader>fa", [[<Cmd>Pick git_hunks scope='staged'<CR>]], { desc = "Added hunks (all)" })
vim.keymap.set("n", "<leader>fA", [[<Cmd>Pick git_hunks path='%' scope='staged'<CR>]], { desc = "Added hunks (current)" })
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
vim.keymap.set("n", "<leader>fS", [[<Cmd>Pick lsp scope='workspace_symbol'<CR>]], { desc = "Symbols workspace (LSP)" })
vim.keymap.set("n", "<leader>fs", [[<Cmd>Pick lsp scope='document_symbol'<CR>]], { desc = "Symbols buffer (LSP)" })
vim.keymap.set("n", "<leader>fV", [[<Cmd>Pick visit_paths cwd=''<CR>]], { desc = "Visit paths (all)" })
vim.keymap.set("n", "<leader>fv", [[<Cmd>Pick visit_paths<CR>]], { desc = "Visit paths (cwd)" })

-- [[ Session ]] -------------------------------------------------------------
require('mini.sessions').setup({ autowrite = true })
-- Session Related Keymaps
vim.keymap.set("n", "<leader>ss", function()
  vim.cmd('wa')
  MiniSessions.write()
  MiniSessions.select()
end, { noremap = true, silent = true, desc = 'Switch Session' })
vim.keymap.set("n", "<leader>sw", function() MiniSessions.write() end,
  { noremap = true, silent = true, desc = 'Save Session' })
vim.keymap.set("n", "<leader>sf", function() MiniSessions.select() end,
  { noremap = true, silent = true, desc = 'Load Session' })

-- [[ Starter ]] -------------------------------------------------------------
local logo = table.concat({
  "     _____  .__       .______   ____.__             ",
  "    /     \\ |__| ____ |__\\   \\ /   /|__| _____   ",
  "   /  \\ /  \\|  |/    \\|  |\\   Y   / |  |/     \\  ",
  "  /    Y    \\  |   |  \\  | \\     /  |  |  Y Y  \\ ",
  "  \\____|__  /__|___|  /__|  \\___/   |__|__|_|  / ",
  "          \\/        \\/                       \\/  ",
}, "\n")
local plugin_count = #require("lazy").plugins()
require("mini.starter").setup({
  autoopen = true,
  evaluate_single = true,
  header = logo,
  items = {
    require("mini.starter").sections.builtin_actions(),
    require("mini.starter").sections.pick(),
    require("mini.starter").sections.recent_files(5, false),
    require('mini.starter').sections.sessions(5, true),
    { action = "Lazy",  name = "Lazy",  section = "Plugin Actions" },
    { action = "Mason", name = "Mason", section = "Plugin Actions" },
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
      --local navic         = require 'nvim-navic'.get_location()
      -- local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local location2     = "%7(%l/%3L%):%-2c %P"
      local lazy_updates  = require("lazy.status").updates
      local spaces        = function()
        local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
        return "SPC:" .. shiftwidth
      end

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode, spell, wrap } },
        { hl = 'MiniStatuslineDevinfo', strings = { git } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        -- { hl = 'MiniStatuslineFilename', strings = { navic } },
        '%=',
        { hl = 'MiniStatuslineFilename', strings = { lsp_client(), diagnostics } },
        { hl = 'Special',                strings = { lazy_updates() } },
        { hl = 'MiniStatuslineFileinfo', strings = { spaces(), fileinfo } },
        { hl = mode_hl,                  strings = { searchcount } },
        { hl = mode_hl,                  strings = { location2 } },
      })
    end,
  },
  use_icons = true,
  set_vim_settings = true,
})

-- [[ Surround ]] ------------------------------------------------------------
require("mini.surround").setup()

-- [[ Tabline ]] -------------------------------------------------------------
require("mini.tabline").setup()

-- [[ Trailspace ]] ----------------------------------------------------------
require("mini.trailspace").setup()

-- [[ Visits ]] --------------------------------------------------------------
require("mini.visits").setup()

------------------------------------------------------------------------------
-- [[ END OF MINI CONFIG ]] --------------------------------------------------
------------------------------------------------------------------------------

-- [[ Configure Treesitter ]] ------------------------------------------------
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
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
end, 0)

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
    mode = mode or "n"
    -- if desc then
    --   desc = "LSP: " .. desc
    -- end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>lD", "<cmd>:Pick lsp scope='definition'<cr>", "Goto Definition")
  nmap("<leader>fR", "<cmd>:Pick lsp scope='references'<cr>", "References")
  nmap("<leader>lI", "<cmd>:Pick lsp scope='implementation'<cr>", "Goto Implementation")
  nmap("<leader>lt", "<cmd>:Pick lsp scope='type_definition'<cr>", "Type Definition")
  --nmap("<leader>ds", "<cmd>:Pick lsp scope='document_symbol'<cr>", "[D]ocument [S]ymbols")
  nmap("<leader>la", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], "Arguments popup")
  nmap("<leader>ld", [[<Cmd>lua vim.diagnostic.open_float()<CR>]], "Diagnostics popup")
  nmap("<leader>lf", [[<Cmd>:Format<cr>]], "Format")
  nmap("<leader>li", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], "Information")
  nmap("<leader>lR", [[<Cmd>lua vim.lsp.buf.references()<CR>]], "References")
  nmap("<leader>ls", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], "Source definition")

  client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local float_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " ",
      }

      if not vim.b.diagnostics_pos then
        vim.b.diagnostics_pos = { nil, nil }
      end

      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      if
          (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
          and #vim.diagnostic.get() > 0
      then
        vim.diagnostic.open_float(nil, float_opts)
      end

      vim.b.diagnostics_pos = cursor_pos
    end,
  })

  -- only if capeable
  if client.supports_method(methods.textDocument_rename) then
    nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

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

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  --nmap("<leader>ws", "<cmd>:Pick lsp scope='workspace_symbol'<cr>", "[W]orkspace [S]ymbols")
  nmap("<leader>va", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>vr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>vl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

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
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
        disable = { "need-check-nil" },
        workspaceDelay = -1,
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
        --library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
--require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()

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

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- vim: ts=2 sts=2 sw=2 et
