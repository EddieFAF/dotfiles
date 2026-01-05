-- Bindings
--
-- Keymaps
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

local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end

local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end

_G.keys = {
  map = map,
  maplocal = maplocal,
  toggle = toggle,
}
-- [[ Basic Keymaps ]]
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous Buffer' })

-- increment/decrement
vim.keymap.set('n', '-', '<C-x>', { desc = 'decrement' })
vim.keymap.set('n', '+', '<C-a>', { desc = 'increment' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>F', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

map('n', '<F8>', ':lua toggle_transparency()<CR>', 'Toggle transparency')
