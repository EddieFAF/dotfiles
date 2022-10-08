 -----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.maplocalleader = " "
vim.g.mapleader = " "

-- Keymap for better default
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
--map('', '<up>', '<nop>')
--map('', '<down>', '<nop>')
--map('', '<left>', '<nop>')
--map('', '<right>', '<nop>')

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
--map('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<F2>'

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so $HOME/.config/nvim/init.lua<CR>')

-- Fast saving with <leader> and s
--map('n', '<leader>s', ':w<CR>')
--map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>e', ':NvimTreeToggle<CR>')        -- open/close
--map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Tagbar
map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

-- Move text up and down
map("n", "<A-k>", "<Esc>:m .-2<CR>")
map("n", "<A-j>", "<Esc>:m .+1<CR>")

-- b: buffer
map('n', '<leader>bn', ':bn<cr>')
map('n', '<leader>bp', ':bp<cr>')
map('n', '<leader>bd', ':Bdelete<cr>')
map('n', '<S-Tab>', ':bprev<CR>')
map('n', '<Tab>', ':bnext<CR>')

-- Colorizer
map('n', '<leader>ct', ':ColorizerToggle<cr>')


-- s: telescope
--map('n', '<leader>sf', ':Telescope find_files<CR>', { desc = '[S]earch [F]iles' })
--map('n', '<leader>sh', ':Telescope help_tags<CR>', { desc = '[S]earch [H]elp' })
--map('n', '<leader>sw', ':Telescope grep_string<CR>', { desc = '[S]earch current [W]ord' })
--map('n', '<leader>sg', ':Telescope live_grep<CR>', { desc = '[S]earch by [G]rep' })
--map('n', '<leader>sd', ':Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' })
--map('n', '<leader>sb', ':Telescope buffers<CR>', { desc = '[S]earch [B]uffers' })
