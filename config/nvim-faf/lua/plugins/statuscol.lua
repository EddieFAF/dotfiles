local M = {
  {
    'kevinhwang91/nvim-ufo',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = false,
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              {
                -- Git Signs
                text = { '%s' },
                sign = { name = { 'GitSigns' }, maxwidth = 1, colwidth = 1, auto = false },
                click = 'v:lua.ScSa',
              },
              {
                -- Line Numbers
                text = { builtin.lnumfunc },
                click = 'v:lua.ScLa',
              },
              {
                -- Fold Markers
                text = { builtin.foldfunc },
                click = 'v:lua.ScFa',
              },
              -- {
              --   -- Diagnostics
              --   sign = { name = { 'Diagnostic' }, maxwidth = 1, colwidth = 1, auto = false, fillchars = '' },
              --   click = 'v:lua.ScSa',
              -- },
              { text = { '│' } },
            },
          }
        end,
      },
    },
    opts = {
      provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
      end,
    },
  },
}

return M
