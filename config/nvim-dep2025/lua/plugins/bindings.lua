local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local utils = require("utils.base")

-- ╒════════════════════════════════════════════╕
-- │ Installing Needed Plugins + Adding KeyMaps │
-- ╘════════════════════════════════════════════╛
now(function()
    -- [[ Clues (Whichkey replacement) ]] ----------------------------------------
    local hints = {}
    local miniclue = require("mini.clue")
    miniclue.setup({
        triggers = {
            -- Leader triggers
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },

            -- mini.basics
            { mode = "n", keys = [[\]] },

            -- mini.bracketed
            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },
            { mode = "x", keys = "[" },
            { mode = "x", keys = "]" },

            -- Built-in completion
            { mode = "i", keys = "<C-x>" },

            -- `g` key
            { mode = "n", keys = "g" },
            { mode = "x", keys = "g" },

            -- Marks
            { mode = "n", keys = "'" },
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },

            -- Registers
            { mode = "n", keys = '"' },
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },

            -- Window commands
            { mode = "n", keys = "<C-w>" },

            -- `z` key
            { mode = "n", keys = "z" },
            { mode = "x", keys = "z" },

            { mode = "n", keys = "s" },
            { mode = "x", keys = "s" },
        },

        clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.z(),
            hints,
            miniclue.gen_clues.windows({
                submode_move = true,
                submode_navigate = true,
                submode_resize = true,
            }),
            { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
            { mode = "n", keys = "<Leader>s", desc = "+Search" },
            { mode = "n", keys = "<Leader>f", desc = "+Files" },
            { mode = "n", keys = "<Leader>g", desc = "+Git" },
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
-- ╒═══════════════════════════════╕
-- │ Assigning All Defined KeyMaps │
-- ╘═══════════════════════════════╛
later(function()
    ---@type KeyMap[]
    local keymaps = utils.merge_arrays(require("plugins.editing").keymaps, require("plugins.coding").keymaps)

    for _, keymap in ipairs(keymaps) do
        require("utils.base").mapd(keymap.mode, keymap.binding, keymap.action, keymap.options.desc)
    end
end)
