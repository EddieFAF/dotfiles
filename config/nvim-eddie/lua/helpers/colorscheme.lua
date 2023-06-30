-- Fetch and setup colorscheme if available, otherwise just return 'default'
-- This should prevent Neovim from complaining about missing colorschemes on first boot
local function get_if_available(name, opts)
	local lua_ok, colorscheme = pcall(require, name)
	if lua_ok then
		colorscheme.setup(opts)
		return name
	end

	local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
	if vim_ok then
		return name
	end

	return "default"
end

-- Uncomment the colorscheme to use
-- local colorscheme = get_if_available("catppuccin")
-- local colorscheme = get_if_available('gruvbox')
-- local colorscheme = get_if_available('onedark')
-- local colorscheme = get_if_available('rose-pine')
-- local colorscheme = get_if_available('everforest')
-- local colorscheme = get_if_available('tokyonight')
-- local colorscheme = get_if_available('doom-one')
-- local colorscheme = get_if_available('melange')
-- local colorscheme = get_if_available('kanagawa')
local colorscheme = get_if_available('onedark')

return colorscheme
