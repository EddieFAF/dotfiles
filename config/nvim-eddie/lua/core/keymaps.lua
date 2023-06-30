local map = require("helpers.keys").map

-- Paste from clipboard
map("x", "<leader>p", '"+p', "Paste from clipboard")
map("n", "<leader>p", '"+p', "Paste from clipboard")

-- Yank from clipboard
map("n", "<leader>y", '"+y', "Yank from clipboard")
map("v", "<leader>y", '"+y', "Yank from clipboard")
map("n", "<leader>Y", '"+Y', "Yank from clipboard")

-- select all
map("n", "<C-a>", "gg<S-v>G", "Select all")

-- Remove Search
map("n", "<esc>", ":noh<cr><esc>", "Remove Search Highlight")
-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")

-- increment/decrement
map("n", "-", "<C-x>", "decrement")
map("n", "+", "<C-a>", "increment")

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")

-- Quick access to some common actions
--map("n", "<leader>fw", "<cmd>w<cr>", "Write")
--map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
--map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
--map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
map("n", "<leader>dw", "<cmd>close<cr>", "Window")


-- Diagnostic keymaps
map("n", "gx", vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Easier access to beginning and end of lines
--map("n", "<M-h>", "^", "Go to beginning of line")
--map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", "Resize +2")
map("n", "<C-Down>", ":resize -2<CR>", "Resize -2")
map("n", "<C-Left>", ":vertical resize +2<CR>", "VResize +2")
map("n", "<C-Right>", ":vertical resize -2<CR>", "VResize -2")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>db", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", "Next Buffer")
map("n", "<S-h>", ":bprevious<CR>", "Previous Buffer")
map("n", "]b", ":bnext<CR>", "Next Buffer")
map("n", "[b", ":bprevious<CR>", "Previous Buffer")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Switch between light and dark modes
map("n", "<leader>ut", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, "Toggle between light and dark themes")

-- Clear after search
--map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

local utils = require("helpers")
local get_icon = utils.get_icon
local is_available = utils.is_available

-- icons displayed on which-key.nvim ---------------------------------------
local icons = {
  f = { desc = get_icon("Search", 1, true) .. "Find" },
  p = { desc = get_icon("Package", 1, true) .. "Packages" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
  u = { desc = get_icon("Window", 1, true) .. "UI" },
  b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
  tt = { desc = get_icon("Test", 1, true) .. "Test" },
  dc = { desc = get_icon("Docs", 1, true) .. "Docs" },
  g = { desc = get_icon("Git", 1, true) .. "Git" },
  S = { desc = get_icon("Session", 1, true) .. "Session" },
  t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
}

local ui = require("helpers.ui")

-- ui toggles [ui ]---------------------------------------------------------
map("n", "<leader>u", "", "UI")

if is_available("nvim-autopairs") then
  map("n", "<leader>ua", ui.toggle_autopairs, "Toggle autopairs")
end
map("n", "<leader>ub", ui.toggle_background, "Toggle background")
if is_available("nvim-cmp") then
  map("n", "<leader>uc", ui.toggle_cmp, "Toggle autocompletion")
end
if is_available("nvim-colorizer.lua") then
  map("n", "<leader>uC", "<cmd>ColorizerToggle<cr>", "Toggle color highlight")
end
map("n", "<leader>ud", ui.toggle_diagnostics, "Toggle diagnostics")
map("n", "<leader>uf", ui.toggle_autoformat, "Toggle autoformat")
map("n", "<leader>ug", ui.toggle_signcolumn, "Toggle signcolumn")
map("n", "<leader>uh", ui.toggle_foldcolumn, "Toggle foldcolumn")
map("n", "<leader>ui", ui.set_indent, "Change indent setting")
map("n", "<leader>uI", "<cmd>set list!<cr>", "Toggle [in]visible characters")
map("n", "<leader>ul", ui.toggle_statusline, "Toggle statusline")
map("n", "<leader>uL", ui.toggle_codelens, "Toggle CodeLens")
map("n", "<leader>un", ui.change_number, "Change line numbering")
map("n", "<leader>uN", ui.toggle_ui_notifications, "Toggle UI notifications")
map("n", "<leader>up", ui.toggle_paste, "Toggle paste mode")
map("n", "<F1>", ui.toggle_paste, "Toggle paste mode")
map("n", "<leader>us", ui.toggle_spell, "Toggle spellcheck")
map("n", "<leader>uS", ui.toggle_conceal, "Toggle conceal")
map("n", "<leader>ut", ui.toggle_tabline, "Toggle tabline")
map("n", "<leader>uu", ui.toggle_url_match, "Toggle URL highlight")
map("n", "<leader>uw", ui.toggle_wrap, "Toggle wrap")
map("n", "<leader>uy", ui.toggle_syntax, "Toggle syntax highlight")
map("n", "<leader>ua", function()
  if vim.g.minianimate_disable then
    vim.g.minianimate_disable = false
  else
    vim.g.minianimate_disable = true
  end
end, "Toggle animations")

-- FZF Keymappings
map("n", "<leader>sf", "<cmd>lua require('fzf-lua').files()<CR>", "FZF Files")
map("n", "<leader>sb", "<cmd>lua require('fzf-lua').buffers()<CR>", "Search Buffers")
map("n", "<leader>fr", "<cmd>lua require('fzf-lua').oldfiles()<CR>", "FZF Recent Files")
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').grep()<CR>", "FZF Grep")
map("n", "<leader>sc", "<cmd>lua require('fzf-lua').colorschemes()<CR>", "Search Colorschemes Preview (FZF)")

