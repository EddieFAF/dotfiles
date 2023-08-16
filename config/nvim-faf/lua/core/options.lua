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
  mouse = 'a',
  undofile = true,
  --  laststatus = 2,
  termguicolors = true,
  number = true,
  relativenumber = true,
  cursorline = true,
  list = true,
  --  cmdheight = 0,
  scrolloff = 5,
}

-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end

-- true color support
vim.g.colorterm = os.getenv 'COLORTERM'
if vim.fn.exists '+termguicolors' == 1 then
  vim.o.termguicolors = true
end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.listchars = {
  eol = '↲',
  tab = '▸ ',
  trail = '·',
  nbsp = '_',
  extends = '›',
  precedes = '‹',
}

if vim.fn.hostname() == 'blackhole' then
  vim.opt.list = true
else
  vim.opt.list = false
end

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Settings from nvim-normal
vim.g.autoformat_enabled = true       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
vim.g.autopairs_enabled = true        -- enable autopairs at start
vim.g.cmp_enabled = true              -- enable completion at start
vim.g.diagnostics_mode = 3            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
vim.g.highlighturl_enabled = true     -- highlight URLs by default
vim.g.icons_enabled = false           -- disable icons in the UI (disable if no nerd font is available)
vim.g.ui_notifications_enabled = true -- disable notifications when toggling UI elements

vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = '%{expand("%:p")} [%{mode()}]'

vim.o.timeout = true
vim.o.timeoutlen = 300
