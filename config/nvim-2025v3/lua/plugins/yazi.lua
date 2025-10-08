MiniDeps.later(function()
    MiniDeps.add({
        source = "mikavilpas/yazi.nvim",
        depends = {
            "nvim-lua/plenary.nvim",
        },
    })

    require("yazi.nvim").setup({

        ---@type YaziConfig | {}
        opts = {
            open_for_directories = true,
            keymaps = {
                show_help = "<f1>",
            },
        },
    })
    vim.keymap.set({ "n", "v" }, "<leader>.", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
    vim.keymap.set(
        "n",
        "<leader>ew",
        "<cmd>Yazi cwd<cr>",
        { desc = "Open the file manager in nvim's working directory" }
    )
    vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
end)
