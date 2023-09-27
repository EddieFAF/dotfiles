local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',

  config = function()
    local wk = require 'which-key'
    wk.setup {
      plugins = {
        spelling = {
          enabled = false,
          suggestions = 20,
        },
        marks = true,
        presets = {
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
          nav = true, -- misc bindings to work with windows
          motions = true, -- adds help for motions
          windows = true, -- default bindings on <c-w>
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          text_objects = true, -- help for text objects triggered after entering an operator
        },
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      },
      window = {
        border = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 05,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = 'left', -- align columns left, center or right
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
      b = { name = 'Buffers' },
      f = { name = 'File' },
      d = { name = 'Delete/Close' },
      q = { name = 'Quit' },
      s = { name = 'Search' },
      l = { name = 'LSP' },
      u = { name = 'UI' },
      --          b = { name = "Debugging" },
      g = { name = 'Git' },
      m = { name = 'Minimap' },
      w = { name = 'Workspace' },
    }

    wk.register(groups, opts)
  end,
}

return M
