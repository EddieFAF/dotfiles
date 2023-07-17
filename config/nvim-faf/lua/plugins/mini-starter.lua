return {
  {
    'echasnovski/mini.starter',
    event = 'VimEnter',
    config = function()
      local starter = require 'mini.starter'
      starter.setup {
        autoopen = true,
        evaluate_single = true,
        items = {
          { action = 'ene | startinsert',                   name = 'New file',        section = 'Files' },
          { action = 'Telescope find_files',                name = 'Find files',      section = 'Files' },
          { action = 'Telescope oldfiles',                  name = 'Recent files',    section = 'Files' },
          { action = 'Telescope live_grep',                 name = 'Grep',            section = 'Search' },
          { action = 'Telescope vim_bookmarks',             name = 'Bookmarks',       section = 'Search' },
          { action = 'Telescope command_history',           name = 'Command history', section = 'Search' },
          { action = 'Lazy',                                name = 'Lazy',            section = 'Config' },
          { action = 'Mason',                               name = 'Mason',           section = 'Config' },
          { action = 'Telescope projects',                  name = 'Projects',        section = 'Session' },
          { action = [[lua require("persistence").load()]], name = 'Session restore', section = 'Session' },
          { action = 'qa',                                  name = 'Quit',            section = 'Exit' },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning('center', 'center'),
        },
        header = nil,
        footer = '',
        query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
      }
    end,
  },
}
