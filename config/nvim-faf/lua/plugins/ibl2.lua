-- indent guides
return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = false,
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    -- use a protected call so we don't error out on first use
    local status_ok, ibl = pcall(require, 'ibl')
    if not status_ok then
      vim.notify('Plugin [ibl] failed to load', vim.log.levels.WARN)
      return
    end

    local hooks = require 'ibl.hooks'
    local highlight = {
      'RainbowRed',
      'RainbowYellow',
      'RainbowBlue',
      'RainbowOrange',
      'RainbowGreen',
      'RainbowViolet',
      'RainbowCyan',
    }
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
      vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
      vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
      vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
      vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
      vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
      vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
    end)
    vim.g.rainbow_delimiters = { highlight = highlight }
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

    ibl.setup {
      enabled = true,
      debounce = 200,
      indent = {
        char = '▏',
        highlight = highlight,
      },
      scope = {
        highlight = highlight,
        show_start = true,
        show_end = true,
        include = {
          node_type = { ['*'] = { '*' } },
        },
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    }
  end,
}
