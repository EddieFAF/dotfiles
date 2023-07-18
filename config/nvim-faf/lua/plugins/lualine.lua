-- Lsp server name .
local function lsp()
  return {
    function()
      local msg = 'No Active Lsp'
      local ft = vim.bo.filetype
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end

      local clients_output = {}
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
          if client.name ~= 'null-ls' then
            table.insert(clients_output, client.name)
          end
        end
      end

      if #clients_output > 0 then
        return table.concat(clients_output, '/')
      else
        return msg
      end
    end,
    icon = 'LSP:',
    color = { gui = 'bold' },
  }
end

-- Get FG by name
local function fg(name)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format('#%06x', hl.foreground) }
  end
end

-- Trailing Spaces (copied from lualine wiki)
local function trailing_space()
  if not vim.o.modifiable then
    return ''
  end
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and 'TW:' .. space or ''
end

-- Show if Space and Tab are mixed in current buffer (copied from lualine wiki)
local function mixed_indent()
  if not vim.o.modifiable then
    return ''
  end
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ''
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return 'MI:' .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MIt:' .. tab_indent
  else
    return 'MIs:' .. space_indent
  end
end

-- Show number of Spaces for indention
local spaces = function()
  return 'SP: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

local navic = require 'nvim-navic'

-- Fancier statusline
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  enabled = true,
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'lazy', 'mason', 'neo-tree' } },
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
        always_divide_middle = true,
      },
      sections = {
        -- stylua: ignore
        lualine_a = {
          --        {'mode', fmt = function(str) return ' ' end, padding = { left = 0, right = 0 } },
          { 'mode', fmt = function(str) return str:sub(1, 1) end },
        },
        lualine_b = {
          { 'b:gitsigns_head', icon = '' },
          {
            'diff',
            -- Is it me or the symbol for modified us really weird
            --            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
          },
          {
            'diagnostics',
          },
        },
        lualine_c = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = {
              left = 1,
              right = 0,
            },
          },
          --{ "filename", path = 4 },
          { 'filename', path = 1, symbols = { modified = '  ', readonly = '  ', unnamed = '' } },
          -- stylua: ignore
          --          {
          --            function() return require("nvim-navic").get_location() end,
          --            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          --          },
        },
        lualine_x = {
          lsp(),
          -- stylua: ignore
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
          },
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          -- },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = fg 'Special',
          },
        },
        lualine_y = {
          -- {
          --   "fileformat",
          -- },
          {
            trailing_space,
            color = { fg = 'WarningMsg' },
          },
          {
            mixed_indent,
            color = { fg = 'WarningMsg' },
          },
          {
            spaces,
          },
          { 'progress', separator = '', padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return '%7(%l/%3L%):%2c %P'
            end,
          },
        },
      },
    }
  end,
}
