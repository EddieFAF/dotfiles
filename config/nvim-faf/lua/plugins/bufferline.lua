local M = {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    require('bufferline').setup {
      options = {
        close_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,
        right_mouse_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,
        diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc",
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   return '(' .. count .. ')'
        -- end,
        diagnostics_indicator = function(count, _, _, _)
          if count > 9 then
            return '(9+)'
          end
          return '(' .. tostring(count) .. ')'
        end,
        -- separator_style = "", -- | "thick" | "thin" | "slope" | { 'any', 'any' },
        -- separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
        separator_style = 'slant', -- | "thick" | "thin" | { 'any', 'any' },
        indicator = {
          -- icon = " ",
          --style = 'icon',
          style = 'underline',
        },
        always_show_bufferline = true,
        custom_filter = function(buf_number)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= 'qf' then
            return true
          end
        end,
        hover = {
          enabled = true,
          delay = 0,
          reveal = { 'close' },
        },
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            text_align = 'center',
            separator = true,
          },
        },
      },
    }
  end,
}

return M
