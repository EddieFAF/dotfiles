local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local utils = require("utils.base")

---@type KeyMap[]
local keymaps = {}

-- ╒════════════════════════════════════════════╕
-- │ Installing Needed Plugins + Adding KeyMaps │
-- ╘════════════════════════════════════════════╛
now(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        checkout = "main",
        monitor = "main",
        -- Perform action after every checkout
        hooks = {
            post_checkout = function() vim.cmd("TSUpdate") end,
        },
    })

    add({
        source = "nvim-treesitter/nvim-treesitter-context",
        depends = { "nvim-treesitter/nvim-treesitter" },
    })
end)

now(function()
    add({
        source = "stevearc/conform.nvim",
    })

    -- Assign keymaps
    ---@type KeyMap[]
    local mappings = {
        {
            mode = "n",
            binding = "<leader>F",
            action = function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
            options = { desc = "[F]ormat Buffer" },
        },
    }

    keymaps = utils.merge_arrays(keymaps, mappings)
end)

now(function()
    add({ source = "mbbill/undotree" })

    -- Assign Global Settings
    vim.g.undotree_WindowLayout = 3

    --- Customize Shapes
    vim.g.undotree_TreeNodeShape = "⬤"
    vim.g.undotree_TreeVertShape = "│"
    vim.g.undotree_TreeSplitShape = "╱"
    vim.g.undotree_TreeReturnShape = "╲"

    -- Assign keymaps
    ---@type KeyMap[]
    local mappings = {
        {
            mode = "n",
            binding = "<leader>u",
            action = vim.cmd.UndotreeToggle,
            options = { desc = "[U]ndo Tree" },
        },
    }

    keymaps = utils.merge_arrays(keymaps, mappings)
end)

now(function() add({ source = "rafamadriz/friendly-snippets" }) end)

-- ╒═════════════════════════════════════╕
-- │ Setup `mini.nvim` Plugins + Keymaps │
-- ╘═════════════════════════════════════╛
later(function() require("mini.align").setup() end)

later(function() require("mini.bracketed").setup() end)

later(function()
    -- [[ Bufremove ]] ----------------------------------------------------------
    require("mini.bufremove").setup()
    local mappings = {

        {
            mode = "n",
            binding = "<leader>bd",
            action = "<Cmd>lua MiniBufremove.delete()<CR>",
            options = { desc = "Delete buffer" },
        },
        {
            mode = "n",
            binding = "<leader>bD",
            action = "<Cmd>lua MiniBufremove.delete(0,  true)<CR>",
            options = { desc = "Delete! buffer" },
        },
        {
            mode = "n",
            binding = "<leader>bw",
            action = "<Cmd>lua MiniBufremove.wipeout()<CR>",
            options = { desc = "Wipeout buffer" },
        },
        {
            mode = "n",
            binding = "<leader>bW",
            action = "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>",
            options = { desc = "Wipeout! buffer" },
        },
    }
    keymaps = utils.merge_arrays(keymaps, mappings)
end)

later(function() require("mini.completion").setup() end)

later(function()
    require("mini.diff").setup()
    vim.keymap.set("n", "<Leader>go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "toggle overlay" })
end)

later(function()
    require("mini.extra").setup()
    vim.keymap.set(
        "n",
        "<Leader>sc",
        function() MiniExtra.pickers.colorschemes() end,
        { desc = "[S]earch [C]olorscheme" }
    )
end)

later(function()
    require("mini.git").setup()
    local rhs = "<Cmd>lua MiniGit.show_at_cursor()<CR>"
    vim.keymap.set({ "n", "x" }, "<Leader>gs", rhs, { desc = "Show at cursor" })
end)

later(function()
    require("mini.jump2d").setup({
        labels = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        view = {
            dim = true,
            n_steps_ahead = 2,
        },
    })
    vim.api.nvim_set_hl(0, "MiniJump2dSpot", { reverse = true })
end)

later(function() require("mini.pairs").setup() end)

later(function()
    local gen_loader = require("mini.snippets").gen_loader
    require("mini.snippets").setup({
        snippets = {
            -- Load custom file with global snippets first (adjust for Windows)
            gen_loader.from_file("~/.config/nvim/snippets/global.json"),

            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
    })
end)

later(function() require("mini.surround").setup() end)

later(function() require("mini.visits").setup() end)

--`mini.files` setup + keymaps
now(function()
    -- Assign keymaps
    ---@type KeyMap[]
    local mappings = {
        {
            mode = "n",
            binding = "<leader>fe",
            action = not require("mini.files").close() and require("mini.files").open or "",
            options = { desc = "[F]ile [E]xplorer" },
        },
    }

    keymaps = utils.merge_arrays(keymaps, mappings)
end)
later(function()
    require("mini.files").setup({
        mappings = {
            close = "q",
            go_in = "L",
            go_in_plus = "l",
            go_out = "H",
            go_out_plus = "h",
            reset = ",",
            show_help = "?",
            synchronize = "w",
        },

        windows = {
            preview = true,
            width_focus = 40,
            width_preview = 75,
            height_focus = 20,
            max_number = math.huge,
        },
    })
    local show_dotfiles = true

    local filter_show = function(fs_entry) return true end

    local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end

    local gio_open = function()
        local fs_entry = require("mini.files").get_fs_entry()
        vim.notify(vim.inspect(fs_entry))
        vim.fn.system(string.format("gio open '%s'", fs_entry.path))
    end

    local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak left-hand side of mapping to your liking
            vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
            vim.keymap.set("n", "-", require("mini.files").close, { buffer = buf_id })
            vim.keymap.set("n", "o", gio_open, { buffer = buf_id })
        end,
    })

    -- Preview toggle
    local show_preview = false

    local toggle_preview = function()
        show_preview = not show_preview
        require("mini.files").refresh({ windows = { preview = show_preview } })
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            local buf_id = args.data.buf_id
            vim.keymap.set("n", "<M-p>", toggle_preview, { buffer = buf_id })
        end,
    })

    local minifiles_augroup = vim.api.nvim_create_augroup("ec-mini-files", {})
    vim.api.nvim_create_autocmd("User", {
        group = minifiles_augroup,
        pattern = "MiniFilesWindowOpen",
        callback = function(args) vim.api.nvim_win_set_config(args.data.win_id, { border = "single" }) end,
    })

    vim.keymap.set(
        "n",
        "<leader>ff",
        [[<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>]],
        { desc = "File directory" }
    )
    vim.keymap.set(
        "n",
        "<leader>fm",
        [[<Cmd>lua MiniFiles.open('~/.config/nvim')<CR>]],
        { desc = "Mini.nvim directory" }
    )
end)

-- `mini.pick` Setup
now(function()
    -- Assign keymaps
    local mini_picker = require("mini.pick").builtin
    local mini_picker_extras = require("mini.extra").pickers

    --@type KeyMap[]
    local mappings = {
        {
            mode = "n",
            binding = "<leader>so",
            action = mini_picker_extras.oldfiles,
            options = { desc = "[S]earch [O]ldfiles" },
        },
        {
            mode = "n",
            binding = "<leader>sb",
            action = mini_picker.buffers,
            options = { desc = "[S]earch [B]uffers" },
        },
        {
            mode = "n",
            binding = "<leader>sr",
            action = mini_picker_extras.registers,
            options = { desc = "[S]earch [R]egisters" },
        },
        {
            mode = "n",
            binding = "<leader>sf",
            action = mini_picker.files,
            options = { desc = "[S]earch [F]iles" },
        },
        {
            mode = "n",
            binding = "<leader>sgf",
            action = mini_picker_extras.git_files,
            options = { desc = "[S]earch [G]it [F]iles" },
        },
        {
            mode = "n",
            binding = "<leader>ss",
            action = mini_picker.grep_live,
            options = { desc = "[S]earch for [S]tring" },
        },
        {
            mode = "n",
            binding = "<leader>sh",
            action = mini_picker.help,
            options = { desc = "[S]earch [H]elp files" },
        },
    }

    keymaps = utils.merge_arrays(keymaps, mappings)
end)

later(function()
    require("mini.pick").setup({
        window = {
            prompt_prefix = "󰛿 ",
        },
    })

    vim.ui.select = function(items, opts, on_choice)
        local get_cursor_anchor = function() return vim.fn.screenrow() < 0.5 * vim.o.lines and "NW" or "SW" end
        -- Auto-adjust width
        local num_items = #items
        local max_height = math.floor(0.45 * vim.o.columns)
        local height = math.min(math.max(num_items, 1), max_height)
        local start_opts = {
            options = { content_from_bottom = get_cursor_anchor() == "SW" },
            window = {
                config = {
                    relative = "cursor",
                    anchor = get_cursor_anchor(),
                    row = get_cursor_anchor() == "NW" and 1 or 0,
                    col = 0,
                    width = math.floor(0.618 * vim.o.columns),
                    height = height,
                },
            },
        }

        return MiniPick.ui_select(items, opts, on_choice, start_opts)
    end
end)

-- ╒═════════════════════════╕
-- │ `nvim-treesitter` Setup │
-- ╘═════════════════════════╛
later(function()
    require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        auto_install = true,
        indent = { enable = true, disable = { "python" } },
        ensure_installed = {
            "lua",
            "markdown",
            "markdown_inline",
            "regex",
            "vimdoc",
            "vim",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
            },
        },
        modules = {},
        sync_install = true,
        ignore_install = {},
    })
    require("treesitter-context").setup({})
end)

-- ╒════════════════════╕
-- │ conform.nvim setup │
-- ╘════════════════════╛
local formatters = require("plugins.mason").formatters
later(function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    require("conform").setup({
        formatters_by_ft = {
            arduino = { "clang_format" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            css = { "prettierd" },
            html = { "prettierd" },
            json = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            python = { "isort", "black" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
        },
        formatters = formatters,
        format_on_save = function(bufnr)
            local disable_filetypes = {}
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = "never"
            else
                lsp_format_opt = "fallback"
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt,
            }
        end,
    })
end)

-- Return the list of formatters to be installed with `mason.nvim`
return { keymaps = keymaps }
