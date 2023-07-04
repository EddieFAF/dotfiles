local opts = {
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  wrap = false,
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  breakindent = true,
  mouse = "a",
  undofile = true,
  laststatus = 3,
  termguicolors = true,
  number = true,
  relativenumber = true,
  cursorline = true,
  list = true,
  cmdheight = 0,
  scrolloff = 5,
}

-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.listchars = {
  eol = "↲",
  tab = "▸ ",
  trail = "·",
  nbsp = "_",
  extends = "›",
  precedes = "‹",
}

-- Settings from nvim-normal
vim.g.autoformat_enabled = false -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
vim.g.autopairs_enabled = true -- enable autopairs at start
vim.g.cmp_enabled = true -- enable completion at start
vim.g.codelens_enabled = true -- enable or disable automatic codelens refreshing for lsp that support it
vim.g.diagnostics_mode = 3 -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
vim.g.highlighturl_enabled = true -- highlight URLs by default
vim.g.icons_enabled = true -- disable icons in the UI (disable if no nerd font is available)
vim.g.lsp_handlers_enabled = true -- enable or disable default vim.lsp.handlers (hover and signatureHelp)
vim.g.ui_notifications_enabled = true -- disable notifications when toggling UI elements

-- Set other options
local colorscheme = require("helpers.colorscheme")
--vim.cmd.colorscheme(colorscheme)
--vim.cmd[[colorscheme tokyonight]]
