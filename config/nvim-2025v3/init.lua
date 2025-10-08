local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/nvim-mini/mini.nvim", mini_path }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Define main config table to be able to use it in scripts
_G.Config = {}

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

require("options")
require("bindings")
require("autocmds")

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugins", [[v:val =~ '\.lua$']])) do
    require("plugins." .. file:gsub("%.lua$", ""))
end

--require("plugins.mini")
--require("plugins.lsp")
--require("plugins.conform")
--require("plugins.mason")
