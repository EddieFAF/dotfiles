return {
  'echasnovski/mini.sessions',
  lazy = false,
  config = function()
    require('mini.sessions').setup()
  end,
}
