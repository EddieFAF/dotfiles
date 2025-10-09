MiniDeps.add { source = 'neanias/everforest-nvim' }

MiniDeps.now(function()
  require('everforest').setup()
  vim.cmd.colorscheme 'everforest'
end)
