
-- function Linemode:custom()
--     local year = os.date("%Y")
--     local time = (self._file.cha.modified or 0) // 1
--
--     if time > 0 and os.date("%Y", time) ~= year then
--         time = os.date("%b %d %H:%M", time)
--     else
--         time = time and os.date("%b %d  %Y", time) or ""
--     end
--
--     local size = self._file:size()
--     return ui.Line(string.format(" %s %s ", size and ya.readable_size(size):gsub(" ", "") or "-", time))
-- end

function Linemode:file_info()
  return string.format("%s   %s", self:size(), self:mtime())
end


require("full-border"):setup()

require("sshfs"):setup()

-- require("yaziline"):setup({
--   color = "#98c379",
--   secondary_color = "#5A6078",
--   default_files_color = "darkgray", -- color of the file counter when it's inactive
--   selected_files_color = "white",
--   yanked_files_color = "green",
--   cut_files_color = "red",
--
--   separator_style = "empty", -- "angly" | "curvy" | "liney" | "empty"
--   separator_open = "",
--   separator_close = "",
--   separator_open_thin = "",
--   separator_close_thin = "",
--   separator_head = "",
--   separator_tail = "",
--   -- separator_open = "ÓÇ≤",
--   -- separator_close = "ÓÇ∞",
--   -- separator_open_thin = "ÓÇ≥",
--   -- separator_close_thin = "ÓÇ±",
--   -- separator_head = "ÓÇ∂",
--   -- separator_tail = "ÓÇ¥",
--
--   select_symbol = "Ôíß",
--   yank_symbol = "ÔøΩÔøΩ",
--
--   filename_max_length = 24, -- truncate when filename > 24
--   filename_truncate_length = 6, -- leave 6 chars on both sides
--   filename_truncate_separator = "..."
-- })

require("yafg"):setup({
  editor = "nvim",                   -- Editor command (default: "hx")
  args = { "--noplugin" },           -- Additional editor arguments (default: {})
  file_arg_format = "+{row} {file}", -- File argument format (default: "{file}:{row}:{col}")
})

-- require("yatline"):setup({
--   -- theme = require("yatline-catppuccin"):setup("macchiato"),
--   --theme = my_theme,
--
--   section_separator = { open = "ÓÇ≤", close = "ÓÇ∞" },
--   part_separator = { open = "ÓÇ≥", close = "ÓÇ±" },
--   inverse_separator = { open = "ÓÉñ", close = "ÓÉó" },
--
-- style_a = {
--   fg = "black",
--   bg_mode = {
--     normal = "white",
--     select = "brightyellow",
--     un_set = "brightred"
--   }
-- },
--   style_b = { bg = "brightblack", fg = "brightwhite" },
--   style_c = { bg = "black", fg = "brightwhite" },
--
--   permissions_t_fg = "green",
--   permissions_r_fg = "yellow",
--   permissions_w_fg = "red",
--   permissions_x_fg = "cyan",
--   permissions_s_fg = "white",
--
--   tab_width = 20,
--   tab_use_inverse = false,
--
--   selected = { icon = "S", fg = "yellow" },
--   copied = { icon = "ÔÉÖ", fg = "green" },
--   cut = { icon = "ÔÉÑ", fg = "red" },
--
--   total = { icon = "ÌÆÇÌæç", fg = "yellow" },
--   succ = { icon = "ÔÅù", fg = "green" },
--   fail = { icon = "ÔÅú", fg = "red" },
--   found = { icon = "ÌÆÇÌæï", fg = "blue" },
--   processed = { icon = "ÌÆÅÌ∞ç", fg = "green" },
--
--   show_background = true,
--
--   display_header_line = true,
--   display_status_line = true,
--
--   component_positions = { "header", "tab", "status" },
--
--   header_line = {
--     left = {
--       section_a = {
--         {type = "line", custom = false, name = "tabs", params = {"left"}},
--       },
--       section_b = {
--       },
--       section_c = {
--       }
--     },
--     right = {
--       section_a = {
--         {type = "string", custom = false, name = "date", params = {"%A, %d. %B %Y"}},
--       },
--       section_b = {
--         {type = "string", custom = false, name = "date", params = {"%X"}},
--       },
--       section_c = {
--       }
--     }
--   },
--
--   status_line = {
--     left = {
--       section_a = {
--         {type = "string", custom = false, name = "tab_mode"},
--       },
--       section_b = {
--         {type = "string", custom = false, name = "hovered_size"},
--       },
--       section_c = {
--         {type = "string", custom = false, name = "hovered_path"},
--         {type = "coloreds", custom = false, name = "githead"},
--         {type = "coloreds", custom = false, name = "count"},
--       }
--     },
--     right = {
--       section_a = {
--         {type = "string", custom = false, name = "cursor_position"},
--       },
--       section_b = {
--         {type = "string", custom = false, name = "cursor_percentage"},
--       },
--       section_c = {
--         {type = "string", custom = false, name = "hovered_file_extension", params = {true}},
--         {type = "coloreds", custom = false, name = "permissions"},
--         {type = "string", custom = false, name = "hovered_ownership"},
--       }
--     }
--   },
-- })
-- require("yatline-githead"):setup({
--     -- theme = require("yatline-catppuccin"):setup("macchiato"),
--       show_branch = true,
--       branch_prefix = "on",
--       branch_borders = "()",
-- })
--
