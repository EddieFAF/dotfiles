local map = require('helpers.keys').map

-- Paste from clipboard
map('x', '<leader>p', '"+p', 'Paste from clipboard')
map('n', '<leader>p', '"+p', 'Paste from clipboard')

-- Yank from clipboard
map('n', '<leader>y', '"+y', 'Yank from clipboard')
map('v', '<leader>y', '"+y', 'Yank from clipboard')
map('n', '<leader>Y', '"+Y', 'Yank from clipboard')

-- select all
map('n', '<C-a>', 'gg<S-v>G', 'Select all')

-- Remove Search
map('n', '<esc>', ':noh<cr><esc>', 'Remove Search Highlight')
-- save file
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', 'Save file')

-- increment/decrement
map('n', '-', '<C-x>', 'decrement')
map('n', '+', '<C-a>', 'increment')

-- Blazingly fast way out of insert mode
map('i', 'jk', '<esc>')

-- Quick access to some common actions
map('n', '<leader>dw', '<cmd>close<cr>', 'Window')

-- Better window navigation
map('n', '<C-h>', '<C-w><C-h>', 'Navigate windows to the left')
map('n', '<C-j>', '<C-w><C-j>', 'Navigate windows down')
map('n', '<C-k>', '<C-w><C-k>', 'Navigate windows up')
map('n', '<C-l>', '<C-w><C-l>', 'Navigate windows to the right')

-- Move with shift-arrows
map('n', '<S-Left>', '<C-w><S-h>', 'Move window to the left')
map('n', '<S-Down>', '<C-w><S-j>', 'Move window down')
map('n', '<S-Up>', '<C-w><S-k>', 'Move window up')
map('n', '<S-Right>', '<C-w><S-l>', 'Move window to the right')

-- Resize with arrows
map('n', '<C-Up>', ':resize +2<CR>', 'Resize +2')
map('n', '<C-Down>', ':resize -2<CR>', 'Resize -2')
map('n', '<C-Left>', ':vertical resize +2<CR>', 'VResize +2')
map('n', '<C-Right>', ':vertical resize -2<CR>', 'VResize -2')

-- Navigate buffers
map('n', '<S-l>', ':BufferNext<CR>', 'Next Buffer')
map('n', '<S-h>', ':BufferPrevious<CR>', 'Previous Buffer')
map('n', ']b', ':bnext<CR>', 'Next Buffer')
map('n', '[b', ':bprevious<CR>', 'Previous Buffer')
map('n', '<leader>bp', '<Cmd>BufferPick<CR>', 'Buffer Pick')

-- Center search results for easy finding.
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Toggle Terminal
map('n', '<leader>t', ':ToggleTerm<CR>', 'Toggle Terminal')

-- FZF Keys
map('n', '<leader>sc', "<cmd>lua require('fzf-lua').colorschemes()<CR>", 'Search Colorschemes Preview (FZF)')

-- UI Toggles
local utils = require 'helpers'
local ui = require 'helpers.ui'
local is_available = utils.is_available

if is_available 'nvim-autopairs' then
  map('n', '<leader>ua', ui.toggle_autopairs, 'Toggle autopairs')
end
if is_available 'nvim-cmp' then
  map('n', '<leader>uc', ui.toggle_cmp, 'Toggle autocompletion')
end
if is_available 'nvim-colorizer.lua' then
  map('n', '<leader>uC', '<cmd>ColorizerToggle<cr>', 'Toggle color highlight')
end
map('n', '<leader>uf', ui.toggle_autoformat, 'Toggle autoformat')
map('n', '<leader>ug', ui.toggle_signcolumn, 'Toggle signcolumn')
map('n', '<leader>uh', ui.toggle_foldcolumn, 'Toggle foldcolumn')
map('n', '<leader>ui', ui.set_indent, 'Change indent setting')
map('n', '<leader>uI', '<cmd>set list!<cr>', 'Toggle [in]visible characters')
map('n', '<leader>ul', ui.toggle_statusline, 'Toggle statusline')
map('n', '<leader>un', ui.change_number, 'Change line numbering')
map('n', '<leader>uN', ui.toggle_ui_notifications, 'Toggle UI notifications')
map('n', '<leader>up', ui.toggle_paste, 'Toggle paste mode')
map('n', '<F1>', ui.toggle_paste, 'Toggle paste mode')
map('n', '<leader>us', ui.toggle_spell, 'Toggle spellcheck')
map('n', '<leader>uS', ui.toggle_conceal, 'Toggle conceal')
map('n', '<leader>ut', ui.toggle_tabline, 'Toggle tabline')
map('n', '<leader>uu', ui.toggle_url_match, 'Toggle URL highlight')
map('n', '<leader>uw', ui.toggle_wrap, 'Toggle wrap')
map('n', '<leader>uy', ui.toggle_syntax, 'Toggle syntax highlight')
map('n', '<leader>ua', function()
  if vim.g.minianimate_disable then
    vim.g.minianimate_disable = false
  else
    vim.g.minianimate_disable = true
  end
end, 'Toggle animations')

map('n', '<F7>', ':Neotree filesystem reveal left toggle<CR>', 'NEO-Tree')
map('n', '<leader>E', function()
  require('neo-tree.command').execute {
    toggle = true,
    position = 'float',
  }
end, 'Explorer Float (root dir)')
map('n', '<leader>G', '<Cmd>Neotree git_status<CR>', 'Neotree Git Status')

local opts = { noremap = true }
local map2 = vim.keymap.set
local buffalo = require 'buffalo.ui'

-- buffers
map({ 't', 'n' }, '<leader>bm', buffalo.toggle_buf_menu, 'Buffer Menu')

map2('n', '<C-j>', buffalo.nav_buf_next, opts)
map2('n', '<C-k>', buffalo.nav_buf_prev, opts)

-- tabpages
map2({ 't', 'n' }, '<M-Space>', buffalo.toggle_tab_menu, opts)

map2('n', '<C-n>', buffalo.nav_tab_next, opts)
map2('n', '<C-p>', buffalo.nav_tab_prev, opts)
