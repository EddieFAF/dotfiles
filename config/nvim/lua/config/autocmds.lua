-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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
