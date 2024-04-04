--[[

******************************************************************************
* options.lua                                                                *
* All the options go here                                                    *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.1                                                                *
* initial release                                                            *
******************************************************************************

--]]

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Settings options ]] ----------------------------------------------------
vim.opt.scrolloff     = 5
vim.opt.title         = true
vim.opt.titlelen      = 0
vim.opt.titlestring   = '%{expand("%:p")} [%{mode()}]'
vim.opt.completeopt   = 'menuone,noinsert,noselect'
--vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.splitright    = true
vim.opt.splitbelow    = true
vim.opt.shiftwidth    = 2
vim.opt.tabstop       = 8
vim.opt.softtabstop   = -1
vim.opt.expandtab     = true
--vim.opt.foldmethod = "syntax"
vim.opt.termguicolors = true
vim.opt.showmode      = false
vim.opt.laststatus    = 3

vim.o.autoindent      = true     -- Use auto indent
vim.o.expandtab       = true     -- Convert tabs to spaces
vim.o.formatoptions   = 'rqnl1j' -- Improve comment editing
vim.o.ignorecase      = true     -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch       = true     -- Show search results while typing
vim.o.infercase       = true     -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase       = true     -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent     = true     -- Make indenting smart
vim.o.virtualedit     = 'block'  -- Allow going past the end of line in visual block mode


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
vim.opt.list      = true

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
vim.opt.cmdheight = 0

--vim.cmd 'colorscheme onedark'

-- vim: ts=2 sts=2 sw=2 et
