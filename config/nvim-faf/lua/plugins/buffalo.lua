return {

  {
    'Pheon-Dev/buffalo-nvim',
    event = 'VeryLazy',
    config = function()
      require('buffalo').setup {

        tab_commands = { -- use default neovim commands for tabs e.g `tablast`, `tabnew` etc
          next = {       -- you can use any unique name e.g `tabnext`, `tab_next`, `next`, `random` etc
            key = '<CR>',
            command = 'tabnext',
          },
          close = {
            key = 'c',
            command = 'tabclose',
          },
          dd = {
            key = 'dd',
            command = 'tabclose',
          },
          new = {
            key = 'n',
            command = 'tabnew',
          },
        },
        buffer_commands = { -- use default neovim commands for buffers e.g `bd`, `edit`
          edit = {
            key = '<CR>',
            command = 'edit',
          },
          vsplit = {
            key = 'v',
            command = 'vsplit',
          },
          split = {
            key = 'h',
            command = 'split',
          },
          buffer_delete = {
            key = 'd',
            command = 'bd',
          },
        },
        general_commands = {
          cycle = true,    -- cycle through buffers or tabs
          exit_menu = 'x', -- similar to 'q' and '<esc>'
        },
        go_to = {
          enabled = true,
          go_to_tab = '<leader>%s',
          go_to_buffer = '<M-%s>',
        },
        filter = {
          enabled = true,
          filter_tabs = '<M-t>',
          filter_buffers = '<M-b>',
        },
        ui = {
          width = 60,
          height = 10,
          row = 2,
          col = 2,
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        },
      }
    end,
  },
}
