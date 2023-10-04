local M = {
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = {
        char = '▏',
        --      char_list = { '|', '¦', '┆', '┊' },
        highlight = 'IndentBlanklineChar',
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
        buftypes = { 'terminal', 'nofile' },
      },
      scope = {
        enabled = true,
        show_start = true,
      },
    },
  },
}
return M
