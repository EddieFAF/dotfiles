-- Lsp server name .
local function lsp()
  return {
    function()
      local msg = "No Active Lsp"
      local ft = vim.bo.filetype
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end

      local clients_output = {}
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
          if client.name ~= "null-ls" then
            table.insert(clients_output, client.name)
          end
        end
      end

      if #clients_output > 0 then
        return table.concat(clients_output, "/")
      else
        return msg
      end
    end,
    icon = "LSP:",
    color = { gui = "bold" },
  }
end

-- Trailing Spaces (copied from lualine wiki)
local function trailing_space()
  if not vim.o.modifiable then
    return ""
  end
  local space = vim.fn.search([[\s\+$]], "nwc")
  return space ~= 0 and "TW:" .. space or ""
end

-- Show if Space and Tab are mixed in current buffer (copied from lualine wiki)
local function mixed_indent()
  if not vim.o.modifiable then
    return ""
  end
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, "nwc")
  local tab_indent = vim.fn.search(tab_pat, "nwc")
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ""
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return "MI:" .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return "MI:" .. tab_indent
  else
    return "MI:" .. space_indent
  end
end

local icons = require("lazyvim.config").icons

local function fg(name)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

return {
  "nvim-lualine/lualine.nvim", -- Fancier statusline
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      component_separators = "┊",
      -- component_separators = { left = "╲", right = "╱" },
      section_separators = "",
    },
    winbar = {
      -- lualine_c = {
      --   -- stylua: ignore
      --   {
      --     function() return require("nvim-navic").get_location() end,
      --     cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
      --   },
      -- },
      -- lualine_x = {
      --   -- stylua: ignore
      --   {
      --     function() return os.date("%R")
      --     end,
      --   },
      -- },
    },
    sections = {
      -- stylua: ignore
      lualine_a = {
--        {'mode', fmt = function(str) return ' ' end, padding = { left = 0, right = 0 } },
        {'mode', fmt = function(str) return str:sub(1,1) end },
      },
      lualine_b = { { "b:gitsigns_head", icon = "" } },
      lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = "  ", readonly = "  ", unnamed = "" } },
      },
      lualine_x = {
        lsp(),
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = fg("Constant"),
        },
        { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
        },
      },
      lualine_y = {
        {
          "fileformat",
        },
        {
          function()
            return string.format(" %d", vim.api.nvim_buf_line_count(0))
          end,
        },
      },
      lualine_z = {
        { "progress", separator = "", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
        {
          trailing_space,
          color = "WarningMsg",
        },
        {
          mixed_indent,
          color = "WarningMsg",
        },
      },
    },
  },
}
