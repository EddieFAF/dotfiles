local git_status = function(type, prefix)
  local status = vim.b.gitsigns_status_dict
  if not status then
    return nil
  end
  if not status[type] or status[type] == 0 then
    return nil
  end
  return prefix .. status[type]
end

local lazy_status = function()
  local updates = require('lazy.status').updates
  if not require('lazy.status').has_updates then
    return nil
  end
  return 'U:' .. updates
end

local M = {
  {
    'tamton-aquib/staline.nvim',
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = { 'User', 'BufNewFile', 'BufReadPost' },

    keys = {
      { '<leader>bn', '<cmd>ene<CR>', desc = 'New buffer' },
      { '<leader>bl', '<cmd>bn<CR>',  desc = 'Next buffer' },
      { '<leader>bh', '<cmd>bp<CR>',  desc = 'Previous buffer' },
      { '<leader>bd', '<cmd>bd<CR>',  desc = 'Delete buffer' },
    },

    config = function()
      require('staline').setup {
        sections = {
          left = {
            '- ',
            '-mode',
            '- ',
            {
              'GitSignsAdd',
              function()
                return git_status('added', '+') or ''
              end,
            },
            ' ',
            {
              'GitSignsChange',
              function()
                return git_status('changed', '~') or ''
              end,
            },
            ' ',
            {
              'GitSignsDelete',
              function()
                return git_status('removed', '-') or ''
              end,
            },
            'branch',
            ' ',
            'file_name',
            ' ',
          },
          mid = { 'lsp' },
          right = {
            'lsp_name',
            ' ',
            {
              'MoreMsg',
              function()
                return lazy_status
              end,
            },
            ' ',
            '-line_column',
          },
        },

        defaults = {
          true_colors = true,
          expand_null_ls = true,
          line_column = '[%l/%L:%c] ≡%p%% ',
        },
      }
    end,
  },
}

return M
