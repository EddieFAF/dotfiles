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
map('n', '<S-l>', ':bnext<CR>', 'Next Buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Previous Buffer')
map('n', ']b', ':bnext<CR>', 'Next Buffer')
map('n', '[b', ':bprevious<CR>', 'Previous Buffer')

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')
