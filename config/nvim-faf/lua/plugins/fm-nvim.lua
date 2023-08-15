local M = {
  {
    'is0n/fm-nvim',
    opts = {
      mappings = { q = ':q<CR>' },
      cmds = {
        lf_cmd = "lf -command 'set hidden'",
      },
      ui = {
        float = {
          border = 'single',
        },
      },
    },
    keys = {
      {
        '<leader>e',
        -- doing it like this makes it so I can open Lf in my dashboard
        function()
          local filename = vim.fn.expand '%'
          vim.cmd([[Lf ]] .. filename)
        end,
        desc = 'File manager',
      },
    },
  },
}

return M
