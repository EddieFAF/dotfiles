local lsp_client = function(msg)
  msg = msg or ''
  local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

  if next(buf_clients) == nil then
    if type(msg) == 'boolean' or #msg == 0 then
      return ''
    end
    return msg
  end

  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= 'null-ls' then
      table.insert(buf_client_names, client.name)
    end
  end

  local hash = {}
  local client_names = {}
  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      client_names[#client_names + 1] = v
      hash[v] = true
    end
  end
  table.sort(client_names)
  return 'LSP:' .. table.concat(client_names, ', ')
end

-- Miscelaneous fun stuff
local M = {

  -- Comment with haste
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'echasnovski/mini.cursorword',
    event = 'VeryLazy',
    config = function()
      require('mini.cursorword').setup()
    end,
  },

  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local hi = require 'mini.hipatterns'
      return {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
    end,
  },

  -- Indentscope
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- symbol = "▏",
      --symbol = "│",
      symbol = '┊', -- default ╎, -- alts: ┊│┆ ┊  ▎││ ▏▏
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Move stuff with <M-j> and <M-k> in both normal and visual mode
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    -- config = function()
    --   require("mini.move").setup()
    -- end,
    opts = {
      mappings = {
        line_left = '<M-h>',
        line_right = '<M-l>',
      },
    },
  },

  {
    'echasnovski/mini.statusline',
    version = false,
    lazy = false,
    enabled = true,
    config = function()
      require('mini.statusline').setup {
        content = {
          active = function()
            -- stylua: ignore start
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local spell         = vim.wo.spell and (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or ''
            local wrap          = vim.wo.wrap and (MiniStatusline.is_truncated(120) and 'W' or 'WRAP') or ''
            local git           = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local searchcount   = MiniStatusline.section_searchcount({ trunc_width = 75 })
            -- local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local location2     = "%7(%l/%3L%):%2c %P"
            local lazy_updates  = require("lazy.status").updates
            local spaces        = function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
              return "SPC:" .. shiftwidth
            end
            vim.api.nvim_set_hl(0, "Update", { fg = 0, bg = "bg" })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                 strings = { mode, spell, wrap } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = 'WarningMsg',             strings = { lsp_client(), lazy_updates() } },
              { hl = 'MiniStatuslineFileinfo', strings = { spaces(), fileinfo } },
              { hl = 'MoreMsg',                strings = { searchcount } },
              { hl = mode_hl,                  strings = { location2 } },
            })
          end,
        },
        use_icons = true,
        set_vim_settings = false,
      }
    end,
  },

  {
    'echasnovski/mini.bracketed',
    event = 'VeryLazy',
    config = function()
      require('mini.bracketed').setup()
    end,
  },

  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup()
    end,
  },

  {
    'echasnovski/mini.tabline',
    event = 'VeryLazy',
    config = function()
      require('mini.tabline').setup()
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'LazyGit',
    keys = {
      {
        '<leader>gg',
        '<cmd>LazyGit<CR>',
        desc = 'LazyGit',
      },
    },
  },
}

return M
