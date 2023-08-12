local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',

  config = function()
    local wk = require 'which-key'
    wk.setup {
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      window = {
        border = 'shadow',        -- none, single, double, shadow
        position = 'bottom',      -- bottom, top
        -- margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        margin = { 0, 1, 1, 5 },  -- extra window margin [top, right, bottom, left]
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 05,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3,                    -- spacing between columns
        align = 'center',               -- align columns left, center or right
      },
    }

    local opts = {
      prefix = '<leader>',
    }

    local groups = {
      r = { name = 'refactor' },
      n = { name = 'notifications' },
      ["'"] = { name = 'marks' },
      ['/'] = { name = 'search' },
      ['['] = { name = 'previous' },
      [']'] = { name = 'next' },
      f = { name = 'File' },
      d = { name = 'Delete/Close' },
      q = { name = 'Quit' },
      s = { name = 'Search' },
      l = { name = 'LSP' },
      -- u = { name = "UI" },
      --          b = { name = "Debugging" },
      g = { name = 'Git' },
      m = { name = 'Minimap' },
      w = { name = 'Workspace' },
    }

    wk.register(groups, opts)
  end,
}

return M
