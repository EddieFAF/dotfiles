-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local plenary = require("plenary.path")
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local dropdown = themes.get_dropdown({
  hidden = true,
  no_ignore = true,
  previewer = false,
  prompt_title = "",
  preview_title = "",
  results_title = "",
  layout_config = { prompt_position = "top" },
})

-- Set current folder as prompt title
local with_title = function(opts, extra)
  extra = extra or {}
  local path = opts.cwd or opts.path or extra.cwd or extra.path or nil
  local title = ""
  local buf_path = vim.fn.expand("%:p:h")
  local cwd = vim.fn.getcwd()
  if path ~= nil and buf_path ~= cwd then
    title = plenary:new(buf_path):make_relative(cwd)
  else
    title = vim.fn.fnamemodify(cwd, ":t")
  end

  return vim.tbl_extend("force", opts, {
    prompt_title = title,
  }, extra or {})
end

vim.api.nvim_create_augroup("startup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = "startup",
  pattern = "*",
  callback = function()
    -- Open file browser if argument is a folder
    local arg = vim.api.nvim_eval("argv(0)")
    if arg and (vim.fn.isdirectory(arg) ~= 0 or arg == "") then
      vim.defer_fn(function()
        builtin.find_files(with_title(dropdown))
      end, 10)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

