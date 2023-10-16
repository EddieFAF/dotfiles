local M = {
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '▏',
        --      char_list = { '|', '¦', '┆', '┊' },
      },
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
          'startify',
          'dashboard',
          'dotooagenda',
          'log',
          'fugitive',
          'gitcommit',
          'packer',
          'vimwiki',
          'markdown',
          'json',
          'txt',
          'vista',
          'help',
          'todoist',
          'NvimTree',
          'neo-tree',
          'Lazy',
          'peekaboo',
          'git',
          'TelescopePrompt',
          'undotree',
          'flutterToolsOutline',
          'lazy',
          '', -- for all buffers without a file type
        },
      },
    },
  },
}
return M
