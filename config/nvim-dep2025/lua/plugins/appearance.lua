local now, add = MiniDeps.now, MiniDeps.add

now(function() add({ source = "stevearc/dressing.nvim" }) end)

-- ╒═════════════════════╕
-- │ Setting Colorscheme │
-- ╘═════════════════════╛
now(function()
    add({ source = "sainnhe/everforest" })
    add({ source = "everviolet/nvim", name = "evergarden" })

    ---@diagnostic disable-next-line: missing-fields
    require("evergarden").setup({
        theme = {
            variant = "winter",
            accent = "aqua",
        },
    })

    -- vim.cmd.colorscheme("evergarden")
    vim.cmd.colorscheme("termcolors")
end)

-- ╒══════════════════════════════╕
-- │ Enabling `mini.nvim` Plugins │
-- ╘══════════════════════════════╛
now(function()
    local miniicons = require("mini.icons")
    miniicons.setup({
        style = "glyph",
    })
    miniicons.mock_nvim_web_devicons()
    miniicons.tweak_lsp_kind()
end)

now(function()
    -- [[ Notify ]] ----------------------------------------------------------
    local mininotify = require("mini.notify")
    local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif) return not vim.startswith(notif.msg, "lua_ls: Diagnosing") end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return mininotify.default_sort(notif_arr)
    end
    mininotify.setup({
        content = { sort = filterout_lua_diagnosing },
        window = { config = { row = 2, border = "rounded" } },
    })

    vim.notify = require("mini.notify").make_notify()
end)

now(function()
    -- [[ Statusline ]] ----------------------------------------------------------
    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return "%7(%l/%3L%):%2c %P" end
end)

now(function()
    require("mini.tabline").setup({
        format = function(buf_id, label)
            local modified_suffix = vim.bo[buf_id].modified and " ⬤" or ""
            local icon_label = string.gsub(MiniTabline.default_format(buf_id, label), "^%s*(.-)%s*$", "%1")
            return " " .. icon_label .. modified_suffix .. "🭵"
        end,
        tabpage_section = "right",
    })
end)

now(function()
    -- [[ Starter ]] -------------------------------------------------------------
    local logo = table.concat({
        "     _____  .__       .______   ____.__             ",
        "    /     \\ |__| ____ |__\\   \\ /   /|__| _____   ",
        "   /  \\ /  \\|  |/    \\|  |\\   Y   / |  |/     \\  ",
        "  /    Y    \\  |   |  \\  | \\     /  |  |  Y Y  \\ ",
        "  \\____|__  /__|___|  /__|  \\___/   |__|__|_|  / ",
        "          \\/        \\/                       \\/  ",
        "",
        "Pwd: " .. vim.fn.getcwd(),
    }, "\n")
    require("mini.starter").setup({
        autoopen = true,
        evaluate_single = true,
        header = logo,
        footer = "config powered by mini.nvim",
        items = {
            require("mini.starter").sections.recent_files(5, false),
            require("mini.starter").sections.pick(),
            require("mini.starter").sections.builtin_actions(),
            require("mini.starter").sections.sessions(5, true),
            { action = "Mason", name = "Mason", section = "Plugin Actions" },
            { action = "DepsUpdate", name = "Update deps", section = "Plugin Actions" },
        },
    })
end)

now(function()
    -- Indentscope Plugin
    require("mini.indentscope").setup({
        draw = {
            animation = function() return 1 end,
        },
        symbol = "│",
        --symbol = "▏",
        options = {
            try_as_border = true,
            border = "both",
            indent_at_cursor = true,
        },
    })
end)

-- Custom vim.ui.input
now(function()
    require("dressing").setup({
        select = { enabled = false },
    })
end)
