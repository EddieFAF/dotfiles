-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--vim.opt.listchars = {
--  eol = "↲",
--  tab = "→ ",
--  extends = "›",
--  precedes = "‹",
--  trail = "•",
--}

vim.opt.ai = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false -- creates a backup file
vim.opt.breakindent = true
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.laststatus = 3
vim.opt.listchars = { trail = "", tab = "", nbsp = "_", extends = ">", precedes = "<" } -- highlight
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.scrolloff = 10 -- is one of my fav
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.opt.shell = "zsh"
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- always show tabs
vim.opt.si = true
vim.opt.smarttab = true
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.updatetime = 50 -- faster completion (4000ms default)
vim.opt.wildmenu = true -- wildmenu
vim.opt.writebackup = false -- do not edit backups
