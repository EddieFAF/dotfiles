return {
  {
    'utilyre/barbecue.nvim',
    enabled = true,
    name = 'barbecue',
    event = 'VeryLazy',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      --      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    keys = {
      {
        '<Leader>ub',
        function()
          local off = vim.b['barbecue_entries'] == nil
          require('barbecue.ui').toggle(off and true or nil)
        end,
        desc = 'Breadcrumbs toggle',
      },
    },
    opts = {
      show_dirname = false,
      show_modified = true,
      -- kinds = false,
      kinds = {
        File = '󰈙 ',
        Module = ' ',
        Namespace = '󰌗 ',
        Package = ' ',
        Class = '󰌗 ',
        Method = '󰆧 ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = '󰕘',
        Interface = '󰕘',
        Function = '󰊕 ',
        Variable = '󰆧 ',
        Constant = '󰏿 ',
        String = '󰀬 ',
        Number = '󰎠 ',
        Boolean = '◩ ',
        Array = '󰅪 ',
        Object = '󰅩 ',
        Key = '󰌋 ',
        Null = '󰟢 ',
        EnumMember = ' ',
        Struct = '󰌗 ',
        Event = ' ',
        Operator = '󰆕 ',
        TypeParameter = '󰊄 ',
      },
    },
  },
}
