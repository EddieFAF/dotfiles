--[[

******************************************************************************
* keymaps.lua                                                                *
* Neovim keymappings (global), plugin mappings go in their own files         *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.1                                                                *
* initial release                                                            *
******************************************************************************

--]]

-- [[ Keymappings ]] ---------------------------------------------------------
vim.keymap.set("n", "<esc>", ":noh<cr><esc>", { desc = "Remove Search Highlight" })
vim.keymap.set("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>L", ":Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>M", ":Mason<cr>", { desc = "Mason" })
-- increment/decrement
vim.keymap.set("n", "-", "<C-x>", { desc = "decrement" })
vim.keymap.set("n", "+", "<C-a>", { desc = "increment" })
-- Split window
vim.keymap.set("n", "<leader>ss", ":split<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
-- Move window
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<Leader>p", function()
  vim.ui.select({
    "buf_lines",
    "buffers",
    "cli",
    "commands",
    "diagnostic",
    "explorer",
    "files",
    "git_branches",
    "git_commits",
    "git_files",
    "hit_hunks",
    "grep",
    "grep_live",
    "help",
    "hipatterns",
    "history",
    "hl_groups",
    "keymaps",
    "list",
    "lsp",
    "makrs",
    "oldfiles",
    "options",
    "registers",
    "resume",
    "spellsuggest",
    "treesitter",
  }, { prompt = "Pick " }, function(choice)
    return vim.cmd({ cmd = "Pick", args = { choice } })
  end)
end, { desc = "Pick something" })

 vim.keymap.set("n", "<Leader>o", ":lua require('oil').open()<CR>", {desc = "Open parent directory" })
 vim.keymap.set("n", "<Leader>O", ":lua require('oil').open_float()<CR>", {desc = "Oil" })

-- vim: ts=2 sts=2 sw=2 et
