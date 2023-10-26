--[[

=====================================================================
========================== KICKSTART.MINI  ==========================
=====================================================================

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

require("lazy").setup({

  -- The star of the show
  {
    "echasnovski/mini.nvim",
    version = false,
  },

  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
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
}, {})

-- [[ Keymappings ]]
vim.keymap.set("n", "<esc>", ':noh<cr><esc>', { desc = "Remove Search Highlight" })
vim.keymap.set("n", "<S-l>", ':bnext<cr>', { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", ':bprevious<cr>', { desc = "Previous Buffer" })

-- [[ Autocommands ]]
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


-- [[ Configure Mini.nvim ]]
-- Collection of basic options
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

-- 'gc' to toggle comment
require("mini.comment").setup()

require("mini.cursorword").setup()

require("mini.files").setup()
vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open()<cr>", { desc = "Find Manual" })

require("mini.move").setup()

local hi = require 'mini.hipatterns'
hi.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

    hex_color = hi.gen_highlighter.hex_color(),
  }
})

-- Animated indentation guide
require("mini.indentscope").setup({
  symbol = "▏",
  options = {
    try_as_border = true,
    border = "both",
    indent_at_cursor = true,
  },
})

require("mini.starter").setup({
  autoopen = true,
  evaluate_single = true,
})

-- Statusline
local lsp_client = function(msg)
  msg = msg or ''
  local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

  if next(buf_clients) == nil then
    if type(msg) == 'boolean' or #msg == 0 then
      return ''
    end
    return msg
  end

  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= 'null-ls' then
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
  return 'LSP:' .. table.concat(client_names, ', ')
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
      -- local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local location2     = "%7(%l/%3L%):%2c %P"
      local lazy_updates  = require("lazy.status").updates
      local spaces        = function()
        local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
        return "SPC:" .. shiftwidth
      end
      --            vim.api.nvim_set_hl(0, "Update", { fg = 0, bg = "bg" })

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
    end
  }
}
)
require("mini.tabline").setup()

require("mini.fuzzy").setup()
require("mini.pairs").setup()

require("mini.completion").setup()
vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

require("mini.hues").setup({ background = "#002734", foreground = "#c0c8cc" }) -- azure
--vim.cmd.colo("randomhue")

-- [[ Settings options ]]

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- [[ Configure Mini.pick ]]
require("mini.pick").setup()

vim.keymap.set("n", "<leader><space>", MiniPick.builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>sf", MiniPick.builtin.files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", MiniPick.builtin.help, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sg", MiniPick.builtin.grep_live, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sr", MiniPick.builtin.resume, { desc = "[S]earch [R]esume" })

-- [[ Configure Treesitter ]]
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
      "tsx",
      "javascript",
      "typescript",
      "vimdoc",
      "vim",
      "bash",
    },

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
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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
    { mode = "n", keys = "<Leader>c", desc = "+[C]ode" },
    { mode = "n", keys = "<Leader>d", desc = "+[D]ocument" },
    { mode = "n", keys = "<Leader>w", desc = "+[W]orkspace" },
    { mode = "n", keys = "<Leader>s", desc = "+[S]earch" },
  },
  window = {
    config = {
      anchor = "SW",
      row = "auto",
      col = "auto",
      width = "auto",
    },
  },
})

-- document existing key chains
--require('which-key').register {
--  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
--}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
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
