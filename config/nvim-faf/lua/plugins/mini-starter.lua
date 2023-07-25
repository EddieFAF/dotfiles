return {
  {
    'echasnovski/mini.starter',
    event = 'VimEnter',
    config = function()
      local starter = require 'mini.starter'
      local logo = table.concat({
        [[                                  __]],
        [[     ___     ___    ___   __  __ /\_\    ___ ___]],
        [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
        [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }, '\n')

      local pad = string.rep(' ', 22)

      starter.setup {
        autoopen = true,
        evaluate_single = true,
        header = logo,
        items = {
          { action = 'ene | startinsert', name = 'New file', section = pad .. 'Files' },
          { action = 'Telescope find_files', name = 'Find files', section = pad .. 'Files' },
          { action = 'Telescope oldfiles', name = 'Recent files', section = pad .. 'Files' },
          { action = 'Telescope live_grep', name = 'Grep', section = pad .. 'Search' },
          { action = 'Telescope vim_bookmarks', name = 'Bookmarks', section = pad .. 'Search' },
          { action = 'Telescope command_history', name = 'Command history', section = pad .. 'Search' },
          { action = 'Lazy', name = 'Lazy', section = pad .. 'Config' },
          { action = 'Mason', name = 'Mason', section = pad .. 'Config' },
          { action = 'Telescope projects', name = 'Projects', section = pad .. 'Session' },
          --          { action = [[lua require("persistence").load()]], name = 'Session restore', section = pad .. 'Session' },
          { action = 'qa', name = 'Quit', section = pad .. 'Exit' },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. '░ ', false),
          starter.gen_hook.aligning('center', 'center'),
        },
        footer = '',
        query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
      }
    end,
  },
}
