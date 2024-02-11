local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local uv = require("commons.uv")
local strings = require("commons.strings")
local tables = require("commons.tables")
local colors_hl = require("commons.colors.hl")
local colors_hsl = require("commons.colors.hsl")
local black = "#000000"
local white = "#ffffff"
local red = "#FF0000"
local green = "#008000"
local blue = "#0000FF"
local cyan = "#00FFFF"
local grey = "#808080"
local orange = "#D2691E"
local yellow = "#FFFF00"
local purple = "#800080"
local magenta = "#FF00FF"

local colors = {
  --bg = '#111111',
  --fg = '#eeeeee',
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
}

local constants = require("core.constants")

--require("heirline").load_colors(colors)

----- All the Components -----
local function rgb_to_hsl(rgb)
  local h, s, l = colors_hsl.rgb_string_to_hsl(rgb)
  return colors_hsl.new(h, s, l, rgb)
end

-- value 0.0-1.0
local function shade_rgb(rgb, value)
  if vim.o.background == "light" then
    return rgb_to_hsl(rgb):tint(value):to_rgb()
  end
  return rgb_to_hsl(rgb):shade(value):to_rgb()
end

local OS_UNAME = uv.os_uname()

local function GetOsIcon()
  local uname = OS_UNAME.sysname
  if uname:match("Darwin") then
    return ""
  elseif uname:match("Windows") then
    return ""
  elseif uname:match("Linux") then
    if
        type(OS_UNAME.release) == "string"
        and OS_UNAME.release:find("arch")
    then
      return ""
    end
    return ""
  else
    return "󱚟"
  end
end

local ModeNames = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["ntT"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local ModeHighlights = {
  NORMAL = { fg = "normal_fg1", bg = "normal_bg1" },
  ["O-PENDING"] = { fg = "normal_fg1", bg = "normal_bg1" },
  INSERT = { fg = "insert_fg", bg = "insert_bg" },
  VISUAL = { fg = "visual_fg", bg = "visual_bg" },
  ["V-LINE"] = { fg = "visual_fg", bg = "visual_bg" },
  ["V-BLOCK"] = { fg = "visual_fg", bg = "visual_bg" },
  SELECT = { fg = "visual_fg", bg = "visual_bg" },
  ["S-LINE"] = { fg = "visual_fg", bg = "visual_bg" },
  ["S-BLOCK"] = { fg = "visual_fg", bg = "visual_bg" },
  REPLACE = { fg = "replace_fg", bg = "replace_bg" },
  MORE = { fg = "replace_fg", bg = "replace_bg" },
  ["V-REPLACE"] = { fg = "replace_fg", bg = "replace_bg" },
  COMMAND = { fg = "command_fg", bg = "command_bg" },
  EX = { fg = "command_fg", bg = "command_bg" },
  CONFIRM = { fg = "command_fg", bg = "command_bg" },
  SHELL = { fg = "command_fg", bg = "command_bg" },
  TERMINAL = { fg = "command_fg", bg = "command_bg" },
}

local function GetModeName(mode)
  return ModeNames[mode] or "???"
end

local Mode = {
  init = function(self)
    self.mode = vim.api.nvim_get_mode().mode
  end,
  hl = function(self)
    local mode_name = GetModeName(self.mode)
    local mode_hl = ModeHighlights[mode_name] or ModeHighlights.NORMAL
    return { fg = mode_hl.fg, bg = mode_hl.bg, bold = true }
  end,
  update = { "ModeChanged" },

  -- os icon
  {
    provider = function(self)
      return " " .. GetOsIcon() .. " "
    end,
  },
  -- mode
  {
    provider = function(self)
      return GetModeName(self.mode) .. " "
    end,
  },
}

local GitBranch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
  {
    condition = function(self)
      return not conditions.buffer_matches({
        filetype = self.filetypes,
      })
    end,
    {
      provider = function(self)
        return "  " .. (self.status_dict.head == "" and "main" or self.status_dict.head) .. " "
      end,
      on_click = {
        callback = function()
          om.ListBranches()
        end,
        name = "sl_git_click",
      },
      hl = { fg = "gray", bg = "#2e323b" },
    },
    {
      condition = function()
        return (_G.GitStatus ~= nil and (_G.GitStatus.ahead ~= 0 or _G.GitStatus.behind ~= 0))
      end,
      update = { "User", pattern = "GitStatusChanged" },
      {
        condition = function()
          return _G.GitStatus.status == "pending"
        end,
        provider = " ",
        hl = { fg = "gray", bg = "#2e323b" },
      },
      {
        provider = function()
          return _G.GitStatus.behind .. " "
        end,
        hl = function()
          return { fg = _G.GitStatus.behind == 0 and "gray" or "red", bg = "#2e323b" }
        end,
        on_click = {
          callback = function()
            if _G.GitStatus.behind > 0 then
              om.GitPull()
            end
          end,
          name = "sl_gitpull_click",
        },
      },
      {
        provider = function()
          return _G.GitStatus.ahead .. " "
        end,
        hl = function()
          return { fg = _G.GitStatus.ahead == 0 and "gray" or "green", bg = "#2e323b" }
        end,
        on_click = {
          callback = function()
            if _G.GitStatus.ahead > 0 then
              om.GitPush()
            end
          end,
          name = "sl_gitpush_click",
        },
      },
    },
  },
}

local FileBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then
      return "[No Name]"
    end
    return " " .. filename .. " "
  end,
  on_click = {
    callback = function()
      vim.cmd("Telescope find_files")
    end,
    name = "sl_filename_click",
  },
  hl = { fg = "gray", bg = "#2e323b" },
}

local FileFlags = {
  -- {
  --   condition = function() return vim.bo.modified end,
  --   provider = " ",
  --   hl = { fg = "gray" },
  -- },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = " ",
    hl = { fg = "gray" },
  },
}

local FileNameBlock = utils.insert(FileBlock, utils.insert(FileName, FileFlags))

local DiagnosticSigns = {
    constants.diagnostic.sign.error,
    constants.diagnostic.sign.warning,
    constants.diagnostic.sign.info,
    constants.diagnostic.sign.hint,
}
local DiagnosticColors = {
    "diagnostic_error",
    "diagnostic_warn",
    "diagnostic_info",
    "diagnostic_hint",
}
local DiagnosticSeverity = { "ERROR", "WARN", "INFO", "HINT" }

local function GetDiagnosticText(level)
    local value = #vim.diagnostic.get(
        0,
        { severity = vim.diagnostic.severity[DiagnosticSeverity[level]] }
    )
    if value <= 0 then
        return ""
    end
    return string.format("%s %d ", DiagnosticSigns[level], value)
end

local function GetDiagnosticHighlight(level)
    return { fg = DiagnosticColors[level], bg = "normal_bg4" }
end

local Diagnostic = {
    hl = { fg = "normal_fg4", bg = "normal_bg4" },
    update = { "DiagnosticChanged" },

    {
        provider = function(self)
            return GetDiagnosticText(1)
        end,
        hl = GetDiagnosticHighlight(1),
    },
    {
        provider = function(self)
            return GetDiagnosticText(2)
        end,
        hl = GetDiagnosticHighlight(2),
    },
    {
        provider = function(self)
            return GetDiagnosticText(3)
        end,
        hl = GetDiagnosticHighlight(3),
    },
    {
        provider = function(self)
            return GetDiagnosticText(4)
        end,
        hl = GetDiagnosticHighlight(4),
    },
}

---Return the LspDiagnostics from the LSP servers
local LspDiagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  on_click = {
    callback = function()
      require("telescope.builtin").diagnostics({
        layout_strategy = "center",
        bufnr = 0,
      })
    end,
    name = "sl_diagnostics_click",
  },
  update = { "DiagnosticChanged", "BufEnter" },
  -- Errors
  {
    condition = function(self)
      return self.errors > 0
    end,
    hl = { fg = "red" },
    {
      {
        provider = function(self)
          return vim.fn.sign_getdefined("DiagnosticSignError")[1].text .. self.errors
        end,
      },
    },
  },
  -- Warnings
  {
    condition = function(self)
      return self.warnings > 0
    end,
    hl = { fg = "yellow" },
    {
      {
        provider = function(self)
          return vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text .. self.warnings
        end,
      },
    },
  },
  -- Hints
  {
    condition = function(self)
      return self.hints > 0
    end,
    hl = { fg = "gray" },
    {
      {
        provider = function(self)
          return " " .. vim.fn.sign_getdefined("DiagnosticSignHint")[1].text .. self.hints
        end,
      },
    },
  },
  -- Info
  {
    condition = function(self)
      return self.info > 0
    end,
    hl = { fg = "gray" },
    {
      {
        provider = function(self)
          return " " .. vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text .. self.info
        end,
      },
    },
  },
}
--     return "  [" .. table.concat(names, ",") .. "]"

local LSPActive = {
  condition = function()
    return conditions.lsp_attached()
  end,
  update = { "LspAttach", "LspDetach" },
  on_click = {
    callback = function()
      vim.defer_fn(function()
        require("lspconfig.ui.lspinfo")()
      end, 100)
    end,
    name = "heirline_LSP",
  },
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients()) do
      table.insert(names, server.name)
    end

    if #names == 0 then
      return ""
    end

    return ("  %s "):format(table.concat(names, " "))
  end,
  hl = { bg = colors.crust, fg = colors.subtext1, bold = true, italic = false },
}


-- local LspAttached = {
--   condition = conditions.lsp_attached,
--   static = {
--     lsp_attached = false,
--     show_lsps = {
--       copilot = false,
--       efm = false,
--     },
--   },
--   init = function(self)
--     for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
--       if self.show_lsps[server.name] ~= false then
--         self.lsp_attached = true
--         return
--       end
--     end
--   end,
--   update = { "LspAttach", "LspDetach" },
--   on_click = {
--     callback = function()
--       vim.defer_fn(function()
--         vim.cmd("LspInfo")
--       end, 100)
--     end,
--     name = "sl_lsp_click",
--   },
--   {
--     condition = function(self)
--       return self.lsp_attached
--     end,
--     {
--       provider = "  ",
--       hl = { fg = "gray", bg = "#2e323b" },
--     },
--   },
-- }

---Return the current line number as a % of total lines and the total lines in the file
local Ruler = {
  init = function(self)
    self.mode = vim.api.nvim_get_mode().mode
  end,
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  {
    -- %L = number of lines in the buffer
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%3L%):%2c %P",
    hl = function(self)
      local mode_name = GetModeName(self.mode)
      local mode_hl = ModeHighlights[mode_name] or ModeHighlights.NORMAL
      return { fg = mode_hl.fg, bg = mode_hl.bg, bold = true }
    end,
    update = { "ModeChanged" },
    --    hl = { fg = "bg", bg = "gray" },
    on_click = {
      callback = function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local total_lines = vim.api.nvim_buf_line_count(0)

        if math.floor((line / total_lines)) > 0.5 then
          vim.cmd("normal! gg")
        else
          vim.cmd("normal! G")
        end
      end,
      name = "sl_ruler_click",
    },
  },
}

local SearchResults = {
  condition = function(self)
    return vim.v.hlsearch ~= 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  {
    provider = function(self)
      local search = self.search

      return string.format(" %d/%d ", search.current, math.min(search.total, search.maxcount))
    end,
    hl = function()
      return { bg = utils.get_highlight("Substitute").bg, fg = "bg" }
    end,
  },
}

-- Show plugin updates available from lazy.nvim
local Lazy = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    }) and require("lazy.status").has_updates()
  end,
  -- update = { "User", pattern = "LazyUpdate" },
  provider = function()
    return " " .. require("lazy.status").updates() .. " "
  end,
  on_click = {
    callback = function()
      require("lazy").update()
    end,
    name = "sl_plugins_click",
  },
  hl = { fg = utils.get_highlight("Special").fg, bg="normal_bg4" },
}

--- Return information on the current buffers filetype
local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
      { default = true })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. " ")
  end,
  on_click = {
    callback = function()
      om.ChangeFiletype()
    end,
    name = "sl_fileicon_click",
  },
  hl = { fg = utils.get_highlight("Type").fg, bold = true, bg = "#2e323b" },
  --hl = { fg = "gray", bg = "#2e323b" },
}

local FileType = {
  provider = function()
    return string.lower(vim.bo.filetype) .. " "
  end,
  on_click = {
    callback = function()
      om.ChangeFiletype()
    end,
    name = "sl_filetype_click",
  },
  hl = { fg = utils.get_highlight("Type").fg, bold = true, bg = "#2e323b" },
  --hl = { fg = "gray", bg = "#2e323b" },
}

local FileTypeN = utils.insert(FileBlock, FileIcon, FileType)

--- Return information on the current file's encoding
local FileEncoding = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  {
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return " " .. enc .. " "
    end,
    hl = {
      fg = "gray",
      bg = "#2e323b",
    },
  },
}
local LspStatus = {
  hl = { fg = "normal_fg4", bg = "normal_bg4" },
  provider = function()
    local result = require("lsp-progress").progress({
      max_size = math.max(math.floor(vim.o.columns / 2) - 5, 3),
      format = function(messages)
        local active_clients = vim.lsp.get_clients()
        local client_count = #active_clients
        if #messages > 0 then
          return " LSP:"
              .. client_count
              .. " "
              .. table.concat(messages, " ")
        end
        if #active_clients <= 0 then
          return " LSP:" .. client_count
        else
          local client_names = {}
          for i, client in ipairs(active_clients) do
            if client and client.name ~= "" then
              table.insert(client_names, "[" .. client.name .. "]")
              print(
                "client[" .. i .. "]:" .. vim.inspect(client.name)
              )
            end
          end
          return " LSP:"
              .. client_count
              .. " "
              .. table.concat(client_names, " ")
        end
      end,
    })
    if strings.not_empty(result) then
      return " " .. result
    end
    return ""
  end,
  update = {
    "User",
    pattern = "LspProgressStatusUpdated",
    callback = function()
      vim.schedule(function()
        vim.cmd("redrawstatus")
      end)
    end,
  },
}

---- Other Stuff: Colors ----
---@param lualine_ok boolean
---@param lualine_theme table
---@param mode_name "normal"|"insert"|"visual"|"replace"|"command"|"inactive"
---@param section "a"|"b"|"c"
---@param attribute "fg"|"bg"
---@param fallback_hls string|string[]
---@param fallback_attribute 'fg'|'bg'
---@param fallback_color string?
local function get_color_with_lualine(
  lualine_ok,
  lualine_theme,
  mode_name,
  section,
  attribute,
  fallback_hls,
  fallback_attribute,
  fallback_color
)
  if
      lualine_ok
      and tables.tbl_get(lualine_theme, mode_name, section, attribute)
  then
    return lualine_theme[mode_name][section][attribute]
  else
    return colors_hl.get_color_with_fallback(
      fallback_hls,
      fallback_attribute,
      fallback_color
    )
  end
end

local function get_terminal_color_with_fallback(number, fallback)
  if strings.not_empty(vim.g[string.format("terminal_color_%d", number)]) then
    return vim.g[string.format("terminal_color_%d", number)]
  else
    return fallback
  end
end

local function convert_lightline_theme(colorname)
  local var_name = "lightline#colorscheme#" .. colorname .. "#palette"
  vim.cmd("let tmp = " .. var_name)
  local theme = vim.g[var_name]

  local lua_theme = {}

  for mode, sections in pairs(theme) do
    if mode ~= "tabline" then
      lua_theme[mode] = {}
      lua_theme[mode].a = {}
      lua_theme[mode].b = {}
      lua_theme[mode].c = {}
      lua_theme[mode].a.fg = sections["left"][1][1]
      lua_theme[mode].a.bg = sections["left"][1][2]
      if sections["left"][2] then
        lua_theme[mode].b.fg = sections["left"][2][1]
        lua_theme[mode].b.bg = sections["left"][2][2]
      elseif sections["right"] then
        lua_theme[mode].b.fg = sections["right"][1][1]
        lua_theme[mode].b.bg = sections["right"][1][2]
      end
      if sections["middle"] then
        lua_theme[mode].c.fg = sections["middle"][1][1]
        lua_theme[mode].c.bg = sections["middle"][1][2]
      end
    end
  end

  local next_color = 0

  local function color_insert(color)
    for k, v in pairs(colors) do
      if v == color then
        return nil
      end
    end
    colors["color" .. next_color] = color
    next_color = next_color + 1
    return nil
  end

  for mode, sections in pairs(lua_theme) do
    for component, parts in pairs(sections) do
      color_insert(parts.fg)
      color_insert(parts.bg)
    end
  end
  return lua_theme
end

---@param lightline_theme table
---@param mode_name "normal"|"insert"|"visual"|"replace"|"command"|"inactive"
---@param section "a"|"b"|"c"
---@param attribute "fg"|"bg"
---@param fallback_hls string|string[]
---@param fallback_attribute 'fg'|'bg'
---@param fallback_color string?
local function get_color_with_lightline(
  lightline_theme,
  mode_name,
  section,
  attribute,
  fallback_hls,
  fallback_attribute,
  fallback_color
)
  local sec1, sec2
  if section == "a" then
    sec1 = "left"
    sec2 = 1
  elseif section == "b" then
    if tables.tbl_get(lightline_theme, mode_name, "left", 2) then
      sec1 = "left"
      sec2 = 2
    else
      sec1 = "right"
      sec2 = 1
    end
  elseif section == "c" then
    sec1 = "middle"
    sec2 = 1
  end
  local attr = attribute == "fg" and 1 or 2
  if tables.tbl_get(lightline_theme, mode_name, sec1, sec2, attr) then
    local result = lightline_theme[mode_name][sec1][sec2][attr]
    return result
  else
    return colors_hl.get_color_with_fallback(
      fallback_hls,
      fallback_attribute,
      fallback_color
    )
  end
end

-- Turns #rrggbb -> { red, green, blue }
local function rgb_str2num(rgb_color_str)
  if rgb_color_str:find("#") == 1 then
    rgb_color_str = rgb_color_str:sub(2, #rgb_color_str)
  end
  local r = tonumber(rgb_color_str:sub(1, 2), 16)
  local g = tonumber(rgb_color_str:sub(3, 4), 16)
  local b = tonumber(rgb_color_str:sub(5, 6), 16)
  return { red = r, green = g, blue = b }
end

-- Turns { red, green, blue } -> #rrggbb
local function rgb_num2str(rgb_color_num)
  local rgb_color_str = string.format(
    "#%02x%02x%02x",
    rgb_color_num.red,
    rgb_color_num.green,
    rgb_color_num.blue
  )
  return rgb_color_str
end

-- Returns brightness level of color in range 0 to 1
-- arbitrary value it's basically an weighted average
local function get_color_brightness(rgb_color)
  local color = rgb_str2num(rgb_color)
  local brightness = (color.red * 2 + color.green * 3 + color.blue) / 6
  return brightness / 256
end

-- Clamps the val between left and right
local function clamp(val, left, right)
  if val > right then
    return right
  end
  if val < left then
    return left
  end
  return val
end

-- Changes brightness of rgb_color by percentage
local function brightness_modifier(rgb_color, percentage)
  local color = rgb_str2num(rgb_color)
  color.red = clamp(color.red + (color.red * percentage / 100), 0, 255)
  color.green = clamp(color.green + (color.green * percentage / 100), 0, 255)
  color.blue = clamp(color.blue + (color.blue * percentage / 100), 0, 255)
  return rgb_num2str(color)
end

---@param colorname string?
---@return table<string, string>
local function setup_colors(colorname)
  local shade_level1 = 0.5
  local shade_level2 = 0.65
  local shade_level3 = 0.8

  local diagnostic_error = colors_hl.get_color_with_fallback(
    { "DiagnosticSignError", "ErrorMsg" },
    "fg",
    red
  )
  local diagnostic_warn = colors_hl.get_color_with_fallback(
    { "DiagnosticSignWarn", "WarningMsg" },
    "fg",
    yellow
  )
  local diagnostic_info = colors_hl.get_color_with_fallback(
    { "DiagnosticSignInfo", "None" },
    "fg",
    cyan
  )
  local diagnostic_hint = colors_hl.get_color_with_fallback(
    { "DiagnosticSignHint", "Comment" },
    "fg",
    grey
  )
  local git_add = colors_hl.get_color_with_fallback(
    { "GitSignsAdd", "GitGutterAdd", "diffAdded", "DiffAdd" },
    "fg",
    green
  )
  local git_change = colors_hl.get_color_with_fallback(
    { "GitSignsChange", "GitGutterChange", "diffChanged", "DiffChange" },
    "fg",
    yellow
  )
  local git_delete = colors_hl.get_color_with_fallback(
    { "GitSignsDelete", "GitGutterDelete", "diffRemoved", "DiffDelete" },
    "fg",
    red
  )

  local text_bg, text_fg
  local statusline_bg, statusline_fg
  local normal_bg, normal_fg
  local normal_bg1, normal_fg1
  local normal_bg2, normal_fg2
  local normal_bg3, normal_fg3
  local normal_bg4, normal_fg4
  local insert_bg, insert_fg
  local visual_bg, visual_fg
  local replace_bg, replace_fg
  local command_bg, command_fg

  local has_lualine, lualine_theme =
      pcall(require, string.format("lualine.themes.%s", colorname))

  text_bg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "a",
    "bg",
    { "Normal" },
    "bg",
    black
  )
  text_fg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "a",
    "fg",
    { "Normal" },
    "fg",
    white
  )
  -- statusline_bg = get_color_with_lualine(
  --     has_lualine,
  --     lualine_theme,
  --     "normal",
  --     "c",
  --     "bg",
  --     { "StatusLine", "Normal" },
  --     "bg",
  --     black
  -- )
  -- statusline_fg = get_color_with_lualine(
  --     has_lualine,
  --     lualine_theme,
  --     "normal",
  --     "c",
  --     "fg",
  --     { "StatusLine", "Normal" },
  --     "fg",
  --     white
  -- )
  normal_bg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "a",
    "bg",
    -- { "PmenuSel", "PmenuThumb", "TabLineSel" },
    { "StatusLine", "PmenuSel", "PmenuThumb", "TabLineSel" },
    "bg",
    get_terminal_color_with_fallback(0, magenta)
  )
  normal_fg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "a",
    "fg",
    {},
    "fg",
    text_bg -- or black
  )
  normal_bg1 = normal_bg
  normal_fg1 = normal_fg
  normal_bg2 = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "b",
    "bg",
    {},
    "bg",
    shade_rgb(get_terminal_color_with_fallback(0, magenta), shade_level1)
  )
  normal_fg2 = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "b",
    "fg",
    {},
    "fg",
    text_fg -- or white
  )
  normal_bg3 = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "c",
    "bg",
    {},
    "bg"
  )
  normal_fg3 = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "normal",
    "c",
    "fg",
    {},
    "fg"
  )
  if normal_bg3 and normal_fg3 then
    local parameter = get_color_brightness(normal_bg3) > 0.5 and 8 or -8
    normal_bg4 = brightness_modifier(normal_bg3, parameter)
    normal_fg4 = normal_fg3
  else
    normal_bg3 = shade_rgb(
      get_terminal_color_with_fallback(0, magenta),
      shade_level2
    )
    normal_fg3 = text_fg
    normal_bg4 = shade_rgb(
      get_terminal_color_with_fallback(0, magenta),
      shade_level3
    )
    normal_fg4 = text_fg
  end
  -- normal_bg4 = statusline_bg
  -- normal_fg4 = statusline_fg
  insert_bg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "insert",
    "a",
    "bg",
    { "String", "MoreMsg" },
    "fg",
    get_terminal_color_with_fallback(2, green)
  )
  insert_fg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "insert",
    "a",
    "fg",
    {},
    "fg",
    text_bg
  )
  visual_bg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "visual",
    "a",
    "bg",
    { "Special", "Boolean", "Constant" },
    "fg",
    get_terminal_color_with_fallback(3, yellow)
  )
  visual_fg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "visual",
    "a",
    "fg",
    {},
    "fg",
    text_bg
  )
  replace_bg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "replace",
    "a",
    "bg",
    { "Number", "Type" },
    "fg",
    get_terminal_color_with_fallback(4, blue)
  )
  replace_fg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "replace",
    "a",
    "fg",
    {},
    "fg",
    text_bg
  )
  command_bg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "command",
    "a",
    "bg",
    { "Identifier" },
    "fg",
    get_terminal_color_with_fallback(1, red)
  )
  command_fg = get_color_with_lualine(
    has_lualine,
    lualine_theme,
    "command",
    "a",
    "fg",
    {},
    "fg",
    text_bg
  )

  if not has_lualine then
    local background_color = colors_hl.get_color("Normal", "bg")
    if background_color then
      local parameter = get_color_brightness(background_color) > 0.5
          and -10
          or 10
      normal_bg = brightness_modifier(normal_bg, parameter)
      normal_bg1 = normal_bg
      if get_color_brightness(normal_bg1) < 0.5 then
        normal_fg = text_fg
        normal_fg1 = text_fg
      end
      normal_bg2 = shade_rgb(normal_bg, 0.5)
      if get_color_brightness(normal_bg2) > 0.5 then
        normal_fg2 = text_bg
      end
      normal_bg3 = shade_rgb(normal_bg, shade_level2)
      if get_color_brightness(normal_bg3) > 0.5 then
        normal_fg3 = text_bg
      end
      normal_bg4 = shade_rgb(normal_bg, shade_level3)
      if get_color_brightness(normal_bg4) > 0.5 then
        normal_fg4 = text_bg
      end
      insert_bg = brightness_modifier(insert_bg, parameter)
      if get_color_brightness(insert_bg) < 0.5 then
        insert_fg = text_fg
      end
      visual_bg = brightness_modifier(visual_bg, parameter)
      if get_color_brightness(visual_bg) < 0.5 then
        visual_fg = text_fg
      end
      replace_bg = brightness_modifier(replace_bg, parameter)
      if get_color_brightness(replace_bg) < 0.5 then
        replace_fg = text_fg
      end
      command_bg = brightness_modifier(command_bg, parameter)
      if get_color_brightness(command_bg) < 0.5 then
        command_fg = text_fg
      end
    end
  end
  return {
    text_bg = text_bg,
    text_fg = text_fg,
    -- statusline_bg = statusline_bg,
    black = black,
    white = white,
    red = red,
    green = green,
    blue = blue,
    cyan = cyan,
    grey = grey,
    orange = orange,
    yellow = yellow,
    purple = purple,
    magenta = magenta,
    normal_bg1 = normal_bg1,
    normal_fg1 = normal_fg1,
    normal_bg2 = normal_bg2,
    normal_fg2 = normal_fg2,
    normal_bg3 = normal_bg3,
    normal_fg3 = normal_fg3,
    normal_bg4 = normal_bg4,
    normal_fg4 = normal_fg4,
    insert_bg = insert_bg,
    insert_fg = insert_fg,
    visual_bg = visual_bg,
    visual_fg = visual_fg,
    replace_bg = replace_bg,
    replace_fg = replace_fg,
    command_bg = command_bg,
    command_fg = command_fg,
    diagnostic_error = diagnostic_error,
    diagnostic_warn = diagnostic_warn,
    diagnostic_info = diagnostic_info,
    diagnostic_hint = diagnostic_hint,
    git_add = git_add,
    git_change = git_change,
    git_delete = git_delete,
  }
end

vim.api.nvim_create_augroup("heirline_augroup", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "heirline_augroup",
  callback = function(event)
    local colorname = event.match
    require("heirline.utils").on_colorscheme(setup_colors(colorname))
  end,
})
vim.api.nvim_create_autocmd("VimEnter", {
  group = "heirline_augroup",
  callback = function()
    local colorname = vim.g.colors_name
    require("heirline.utils").on_colorscheme(setup_colors(colorname))
  end,
})

return {
  static = {
    filetypes = {
      "^git.*",
      "fugitive",
      "alpha",
      "^neo--tree$",
      "^neotest--summary$",
      "^neo--tree--popup$",
      "^NvimTree$",
      "^toggleterm$",
    },
    force_inactive_filetypes = {
      "^aerial$",
      "^alpha$",
      "^chatgpt$",
      "^DressingInput$",
      "^frecency$",
      "^lazy$",
      "^lazyterm$",
      "^netrw$",
      "^oil$",
      "^TelescopePrompt$",
      "^undotree$",
    },
  },
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.force_inactive_filetypes,
    })
  end,
  {
    Mode,
    GitBranch,
    LspStatus,
    -- FileNameBlock,
    { provider = "%=" },
    --LSPActive,
    --LspDiagnostics,
    Diagnostic,
    Lazy,
    FileTypeN,
    -- FileEncoding,
    SearchResults,
    Ruler,
  },
}
