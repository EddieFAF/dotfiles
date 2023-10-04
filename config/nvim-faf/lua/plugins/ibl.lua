return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    indent = { char = '▏' },
    scope = {
      enabled = true,
      injected_languages = false,
      highlight = { 'Function', 'Label' },
      priority = 500,
      char = '▏',
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
  },
  main = 'ibl',
}
