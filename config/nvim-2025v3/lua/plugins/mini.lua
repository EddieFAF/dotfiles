local now, later = MiniDeps.now, MiniDeps.later

now(
    function()
        require("mini.basics").setup({
            options = { extra_ui = false, win_borders = "bold" },
            mappings = { windows = true, move_with_alt = true },
            autocommands = { relnum_in_visual_mode = true },
        })
    end
)
later(function()
    require("mini.bufremove").setup()
    vim.keymap.set("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete buffer" })
    vim.keymap.set("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(0,  true)<CR>", { desc = "Delete! buffer" })

    vim.keymap.set("n", "<leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", { desc = "Wipeout buffer" })
    vim.keymap.set("n", "<leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", { desc = "Wipeout! buffer" })
end)

later(function() require("mini.cursorword").setup() end)

later(function() require("mini.extra").setup() end)

later(function()
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

later(function() require("mini.move").setup() end)

now(function()
          local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%7(%l/%3L%):%2c %P'
      end
end)

later(function() require("mini.tabline").setup() end)

now(function()
      local mininotify = require 'mini.notify'
      local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif)
          return not vim.startswith(notif.msg, 'lua_ls: Diagnosing')
        end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return mininotify.default_sort(notif_arr)
      end
      mininotify.setup {
        content = { sort = filterout_lua_diagnosing },
        window = { config = { row = 2, border = 'rounded' } },
      }

      vim.notify = require('mini.notify').make_notify()
end)

now(function()
    local clue = require("mini.clue")

    clue.setup({
        clues = {
            clue.gen_clues.builtin_completion(),
            clue.gen_clues.g(),
            clue.gen_clues.marks(),
            clue.gen_clues.registers({ show_contents = true }),
            clue.gen_clues.windows({ submode_resize = true }),
            clue.gen_clues.z(),
        },
        triggers = {
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },
            { mode = "n", keys = [[\]] }, -- mini.basics
            { mode = "n", keys = "[" }, -- mini.bracketed
            { mode = "n", keys = "]" },
            { mode = "x", keys = "[" },
            { mode = "x", keys = "]" },
            { mode = "i", keys = "<C-x>" }, -- built-in completion
            { mode = "n", keys = "g" }, -- `g` key
            { mode = "x", keys = "g" },
            { mode = "n", keys = "'" }, -- marks
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },
            { mode = "n", keys = '"' }, -- registers
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },
            { mode = "n", keys = "s" }, -- surround
            { mode = "n", keys = "<C-w>" }, -- windows
            { mode = "n", keys = "z" }, -- folds
            { mode = "x", keys = "z" },
        },
        window = {
            config = {
                anchor = "SE",
                row = "auto",
                col = "auto",
                width = "auto",
                border = "rounded",
            },
            delay = 0,
        },
    })
end)
