-- [[ Configure Colorizer ]]
-- See `:help colorizer.lua`
local status_ok, colorizer = pcall(require, 'colorizer')
if not status_ok then
  return
end


colorizer.setup()
