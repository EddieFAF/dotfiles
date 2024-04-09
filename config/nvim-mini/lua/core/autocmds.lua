--[[

******************************************************************************
* autocmds.lua                                                               *
* Neovim Autocommands                                                        *
* written by EddieFAF                                                        *
*                                                                            *
* version 0.1                                                                *
* initial release                                                            *
******************************************************************************

--]]

-- [[ Autocommands ]] --------------------------------------------------------
local function augroup(name)
  return vim.api.nvim_create_augroup("mini_" .. name, { clear = true })
end

-- go to last location
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
    vim.keymap.set("n", "q", "<cmd>close<cr>", { desc = "close", buffer = event.buf, silent = true })
  end,
})

-- -- disable statusline in starter window
-- vim.api.nvim_create_autocmd("User", {
--   group = augroup("disable_statusbar_on_starter"),
--   pattern = { "MiniStarterOpened" },
--   callback = function()
--     vim.b.ministatusline_disable = true
--   end,
-- })

local line_numbers_group = vim.api.nvim_create_augroup('mariasolos/toggle_line_numbers', {})
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
    group = line_numbers_group,
    desc = 'Toggle relative line numbers on',
    callback = function()
        if vim.wo.nu and not vim.startswith(vim.api.nvim_get_mode().mode, 'i') then
            vim.wo.relativenumber = true
        end
    end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
    group = line_numbers_group,
    desc = 'Toggle relative line numbers off',
    callback = function(args)
        if vim.wo.nu then
            vim.wo.relativenumber = false
        end

        -- Redraw here to avoid having to first write something for the line numbers to update.
        if args.event == 'CmdlineEnter' then
            vim.cmd.redraw()
        end
    end,
})

-- vim: ts=2 sts=2 sw=2 et
