return {
  'echasnovski/mini.sessions',
  lazy = false,
  keys = {
    { "<leader>ss", function()
      vim.cmd('wa')
      MiniSessions.write()
      MiniSessions.select()
    end, desc = 'Switch Session' },
    { "<leader>sw", function() MiniSessions.write() end, desc = 'Save Session' },
    { "<leader>sf", function() MiniSessions.select() end, desc = 'Load Session' },
  },
  config = function()
    require('mini.sessions').setup({
      autowrite = true,
    })
  end,
}
