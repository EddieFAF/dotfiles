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

      local icon = 'LSP:'
      if vim.g.icons_enabled then
        icon = ':'
      else
        icon = 'LSP:'
      end

      if #clients_output > 0 then
        return icon .. table.concat(clients_output, '/')
      else
        return icon .. msg
      end
    end,
    icon = '',
    --icon = ' LSP:',
    color = { gui = 'bold' },
  }
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-----------------------------------------------------------
local function selectionCount()
  local isVisualMode = vim.fn.mode():find '[Vv]'
  if not isVisualMode then
    return ''
  end
  local starts = vim.fn.line 'v'
  local ends = vim.fn.line '.'
  local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
  return ' ' .. tostring(lines) .. 'L ' .. tostring(vim.fn.wordcount().visual_chars) .. 'C'
end
-----------------------------------------------------------

local function searchCounter()
  if vim.v.hlsearch == 0 then
    return ''
  end
  if vim.fn.mode() == 'n' then
    local total = vim.fn.searchcount().total
    local current = vim.fn.searchcount().current
    local searchTerm = vim.fn.getreg '/'
    local isStarSearch = searchTerm:find [[^\<.*\>$]]
    if isStarSearch then
      searchTerm = '*' .. searchTerm:sub(3, -3)
    end
    if total == 0 then
      return ' 0 ' .. searchTerm
    end
    return (' %s/%s %s'):format(current, total, searchTerm)

    -- manual method of counting necessary since `fn.searchcount()` does not work
    -- during the search in the cmdline
  elseif vim.fn.mode() == 'c' and vim.fn.getcmdtype():find '[/?]' then
    -- for correct count, requires autocmd below refreshing lualine on CmdlineChanged
    local searchTerm = vim.fn.getcmdline()
    if searchTerm == '' then
      return ''
    end

    local buffer = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true), '\n')

    -- determine case-sensitive from user's vim settings
    local ignoreCase = vim.opt.smartcase:get() and (searchTerm:find '%u' == nil) or vim.opt.ignorecase:get()

    -- using `fn.count()` instead of `string.find` since `/` uses vimscript
    local count = vim.fn.count(buffer, searchTerm, ignoreCase)
    return (' %s'):format(count)
  end
end

-- force refreshing for search count, since lualine otherwise lags behind
vim.api.nvim_create_autocmd('CmdlineChanged', {
  callback = function()
    if not vim.fn.getcmdtype():find '[/?]' then
      return
    end
    require('lualine').refresh()
  end,
})
-----------------------------------------------------------

-- Get FG by name -----------------------------------------
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
  local icon = 'SPC:'
  if vim.g.icons_enabled then
    icon = ' '
  end
  return icon .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

-- local navic = require 'nvim-navic'

local function navicBreadcrumbs()
  if vim.bo.filetype == 'css' or not require('nvim-navic').is_available() then
    return ''
  end
  return require('nvim-navic').get_location()
end

-- Fancier statusline
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  enabled = true,
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'lazy', 'mason', 'neo-tree', 'starter' } },
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
        always_divide_middle = true,
      },
      sections = {
        -- stylua: ignore
        lualine_a = {
          -- {'mode', fmt = function(str) return ' ' end, padding = { left = 0, right = 0 } },
          { 'mode', fmt = function(str) return str:sub(1, 1) end },
        },
        lualine_b = {
          { 'b:gitsigns_head', icon = '' },
          {
            'diff',
            diff_source = diff_source,
            -- Is it me or the symbol for modified us really weird
            --            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            --  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
            symbols = { added = '+', modified = '~', removed = '-' }, -- changes diff symbols
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
          -- { custom_fname },
          { 'filename', path = 4, symbols = { modified = '  ', readonly = '  ', unnamed = '' } },
          -- stylua: ignore
          -- {
          --   function() return require("nvim-navic").get_location() end,
          --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          -- },
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
        },
        lualine_y = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = fg 'Special',
          },
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
        },
        lualine_z = {
          { selectionCount, padding = { left = 0, right = 1 } },
          {
            function()
              return '[%l/%L] :%c'
            end,
          },
          { 'progress',     separator = '',                   padding = { left = 1, right = 1 } },
        },
      },
      -- tabline = {
      --   lualine_a = {
      --     { searchCounter },
      --     {
      --       'buffers',
      --       mode = 4,
      --       show_filename_only = true,
      --       show_modified_status = true,
      --       filetype_names = {
      --         NvimTree = 'NvimTree',
      --         TelescopePrompt = 'Telescope',
      --         lazy = 'Lazy',
      --         alpha = 'Alpha',
      --         ['dap-repl'] = 'DAP REPL',
      --       },
      --     },
      --     {
      --       'tabs',
      --       mode = 1,
      --       max_length = vim.o.columns * 0.7,
      --       cond = function()
      --         return vim.fn.tabpagenr '$' > 1
      --       end,
      --     },
      --   },
      --   lualine_b = {},
      --   lualine_c = {
      --     { navicBreadcrumbs },
      --   },
      --   lualine_x = {
      --     {
      --       require('lazy.status').updates,
      --       cond = require('lazy.status').has_updates,
      --       color = fg 'NonText',
      --     },
      --   },
      --   lualine_y = {},
      --   lualine_z = {},
      -- },
      -- winbar = {
      --   -- Starting with B due to nicer theming on B and C sections
      --   -- lualine_b = { 'diagnostics', { 'diff', source = diff_source } },
      --   lualine_b = {},
      --   lualine_c = {},
      -- },
      -- inactive_winbar = {},
    }
  end,
}
