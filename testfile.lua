-- To find any highlight groups: "<cmd> Telescope highlights"
local M = {}
local K = "Inhaltloses Zeuchs"

M.override = {
  Comment = {
    italic = true,
  },
}
-- change for git
-- more
---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}
refurn K
return M

