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
            --            vim.api.nvim_set_hl(0, "Update", { fg = 0, bg = "bg" })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                 strings = { mode, spell, wrap } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = 'MiniStatuslineFilename', strings = { lsp_client() } },
              { hl = 'Special',                strings = { lazy_updates() } },
              { hl = 'MiniStatuslineFileinfo', strings = { spaces(), fileinfo } },
              { hl = 'MoreMsg',                strings = { searchcount } },
              { hl = mode_hl,                  strings = { location2 } },
            })
          end,
        },
        use_icons = true,
        set_vim_settings = true,
      }
    end,
  },
}

return M
