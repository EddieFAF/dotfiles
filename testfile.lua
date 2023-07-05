-- To find any highlight groups: "<cmd> Telescope highlights"
local M = {}
local K = "Inhaltloses Zeuchs"

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}
refurn K
return M

