return {
  -- The star of the show
  {
    'ibhagwan/fzf-lua',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- stylua: ignore
    keys = {
      { '<leader>/c',  function() require('fzf-lua').commands() end,             desc = 'Search commands', },
      { '<leader>/C',  function() require('fzf-lua').command_history() end,      desc = 'Search command history', },
      { '<leader>/b',  function() require('fzf-lua').buffers() end,              desc = 'Find buffers', },
      { '<leader>/d',  function() require('fzf-lua').diagnostics_document() end, desc = 'Find diagnostics', },
      { '<leader>/f',  function() require('fzf-lua').files() end,                desc = 'Find files', },
      { '<leader>/o',  function() require('fzf-lua').oldfiles() end,             desc = 'Find recent files', },
      { '<leader>/h',  function() require('fzf-lua').highlights() end,           desc = 'Search highlights', },
      { '<leader>/M',  function() require('fzf-lua').marks() end,                desc = 'Search marks', },
      { '<leader>/k',  function() require('fzf-lua').keymaps() end,              desc = 'Search keymaps', },
      { '<leader>/gf', function() require('fzf-lua').git_files() end,            desc = 'Find git files', },
      { '<leader>/gb', function() require('fzf-lua').git_branches() end,         desc = 'Search git branches', },
      { '<leader>/gc', function() require('fzf-lua').git_commits() end,          desc = 'Search git commits', },
      { '<leader>/gC', function() require('fzf-lua').git_bcommits() end,         desc = 'Search git buffer commits', },
      { '<leader>//',  function() require('fzf-lua').resume() end,               desc = 'Resume FZF', },
    },
    config = function()
      local fzf = require 'fzf-lua'
      local actions = require 'fzf-lua.actions'
      fzf.setup {
        keymap = {
          builtin = {
            ['<C-/>'] = 'toggle-help',
            ['<C-a>'] = 'toggle-fullscreen',
            ['<C-i>'] = 'toggle-preview',
            ['<C-f>'] = 'preview-page-down',
            ['<C-b>'] = 'preview-page-up',
          },
          fzf = {
            ['CTRL-Q'] = 'select-all+accept',
          },
        },
        fzf_colors = {
          bg = { 'bg', 'Normal' },
          gutter = { 'bg', 'Normal' },
          info = { 'fg', 'Conditional' },
          scrollbar = { 'bg', 'Normal' },
          separator = { 'fg', 'Comment' },
        },
        fzf_opts = {
          ['--info'] = 'default',
          ['--layout'] = 'reverse-list',
        },
        winopts = {
          height = 0.7,
          width = 0.55,
          preview = {
            scrollbar = false,
            layout = 'vertical',
            vertical = 'up:40%',
          },
        },
        files = {
          winopts = {
            preview = { hidden = 'hidden' },
          },
          actions = {
            ['ctrl-g'] = actions.toggle_ignore,
          },
        },
      }
      fzf.register_ui_select()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
