local M = {
  {
    'tamton-aquib/staline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = { 'User', 'BufNewFile', 'BufReadPost' },

    keys = {
      { '<leader>bn', '<cmd>ene<CR>', desc = 'New buffer' },
      { '<leader>bl', '<cmd>bn<CR>',  desc = 'Next buffer' },
      { '<leader>bh', '<cmd>bp<CR>',  desc = 'Previous buffer' },
      { '<leader>bd', '<cmd>bd<CR>',  desc = 'Delete buffer' },
    },

    config = function()
      require('stabline').setup {
        style = 'arrow',
      }

      require('staline').setup {
        sections = {
          left = {
            ' ',
            'right_sep_double',
            '-mode',
            'left_sep_double',
            ' ',
            'right_sep',
            '-file_name',
            'left_sep',
            ' ',
            'right_sep_double',
            '-branch',
            'left_sep_double',
            ' ',
          },
          mid = { 'lsp' },
          right = {
            'right_sep',
            '-cool_symbol',
            'left_sep',
            ' ',
            'right_sep',
            '- ',
            '-lsp_name',
            '- ',
            'left_sep',
            ' ',
            'right_sep_double',
            '-line_column',
            'left_sep_double',
            ' ',
          },
        },

        defaults = {
          fg = '#add8e6',
          left_separator = '',
          right_separator = '',
          true_colors = true,
          line_column = '[%l:%c] ≡%p%% ',
        },

        mode_colors = {
          n = '#181a23',
          i = '#181a23',
          c = '#181a23',
          v = '#181a23',
          ic = '#181a23',
          V = '#181a23',
          t = '#181a23',
          R = '#181a23',
          r = '#181a23',
          s = '#181a23',
          S = '#181a23',
        },
      }
    end,
  },
}

return M
