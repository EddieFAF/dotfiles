local bit = require("bit")

local sep = "  "

local Spacer = {
  provider = " ",
}

local VimLogo = {
  provider = " ",
  hl = "VimLogo",
}

local Filepath = {
  static = {
    modifiers = {
      dirname = ":s?/Users/Oli/.dotfiles?dotfiles?:s?.config/nvim/lua/Oli?Neovim?:s?/Users/Oli/Code?Code?",
    },
  },
  init = function(self)
    self.current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")

    self.filepath = vim.fn.fnamemodify(self.current_dir, self.modifiers.dirname or nil)
    self.short_path = vim.fn.fnamemodify(vim.fn.expand("%:h"), self.modifiers.dirname or nil)
    if self.filepath == "" then
      self.filepath = "[No Name]"
    end
  end,
  hl = "HeirlineWinbar",
  {
    condition = function(self)
      return self.filepath ~= "."
    end,
    flexible = 2,
    {
      provider = function(self)
        return table.concat(vim.fn.split(self.filepath, "/"), sep) .. sep
      end,
    },
    {
      provider = function(self)
        local filepath = vim.fn.pathshorten(self.short_path)
        return table.concat(vim.fn.split(self.short_path, "/"), sep) .. sep
      end,
    },
    {
      provider = "",
    },
  },
}

local Filename = {
  {
    {
      provider = function()
        local filetype_icon, filetype_hl = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)
        return (filetype_icon and "%#" .. filetype_hl .. "#" .. filetype_icon .. " " or "")
      end,
    },
    {
      provider = function()
        return vim.fn.expand("%:t")
      end,
      hl = function()
        if vim.o.background == "light" then
          return { fg = "fg" }
        else
          return { fg = "fg" } -- comment
        end
      end,
    },
    hl = "HeirlineWinbar",
  },
  -- Modifier
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = " ",
    hl = { fg = "red" },
  },
}

return {
  static = {
    encode_pos = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    decode_pos = function(c)
      return bit.rshift(c, 16), bit.band(bit.rshift(c, 6), 1023), bit.band(c, 63)
    end,
  },
  Spacer,
  Filepath,
  Filename,
  { provider = "%=" },
  VimLogo,
}
