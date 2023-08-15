return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '', -- symbol prepended to a group
    },

    window = { winblend = 0 },
    defaults = {
      mode = { 'n', 'v' },
      [';'] = { name = '+telescope' },
      [';d'] = { name = '+lsp/todo' },
      ['g'] = { name = '+goto' },
      ['gz'] = { name = '+surround' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
      ['<leader>d'] = { name = '+Delete' },
      ['<leader>f'] = { name = '+Files' },
      ['<leader>g'] = { name = '+Git' },
      ['<leader>l'] = { name = '+LSP' },
      ['<leader>s'] = { name = '+search' },
      ['<leader>m'] = { name = '+Minimap' },
      ['<leader>u'] = { name = '+ui' },
      ['<leader>x'] = { name = '+diagnostics/quickfix' },
      ['<leader>w'] = { name = '+Workspace' },
    },
  },

  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
