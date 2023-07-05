return {
	--  [notifications]
	--  https://github.com/rcarriga/nvim-notify
	{
		"rcarriga/nvim-notify",
		opts = {
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 1000 })
			end,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},
	-- Telescope integration (:Telescope notify)
	{
		"nvim-telescope/telescope.nvim",
		dependency = { "rcarriga/nvim-notify" },
		cmd = "Telescope notify",
		opts = function()
			require("telescope").load_extension("notify")
		end,
	},
}
