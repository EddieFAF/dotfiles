
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

--require("full-border"):setup()

require("yatline"):setup({
  theme = require("yatline-catppuccin"):setup("macchiato"),
  --theme = my_theme,

  section_separator = { open = "", close = "" },
part_separator = { open = "", close = "" },
inverse_separator = { open = "", close = "" },

style_a = {
  fg = "black",
  bg_mode = {
    normal = "white",
    select = "brightyellow",
    un_set = "brightred"
  }
},
  style_b = { bg = "brightblack", fg = "brightwhite" },
  style_c = { bg = "black", fg = "brightwhite" },

  permissions_t_fg = "green",
  permissions_r_fg = "yellow",
  permissions_w_fg = "red",
  permissions_x_fg = "cyan",
  permissions_s_fg = "white",

  tab_width = 20,
  tab_use_inverse = false,

  selected = { icon = "S", fg = "yellow" },
  copied = { icon = "", fg = "green" },
  cut = { icon = "", fg = "red" },

  total = { icon = "������", fg = "yellow" },
  succ = { icon = "", fg = "green" },
  fail = { icon = "", fg = "red" },
  found = { icon = "������", fg = "blue" },
  processed = { icon = "������", fg = "green" },

  show_background = true,

  display_header_line = true,
  display_status_line = true,

  component_positions = { "header", "tab", "status" },

  header_line = {
    left = {
      section_a = {
        {type = "line", custom = false, name = "tabs", params = {"left"}},
      },
      section_b = {
      },
      section_c = {
      }
    },
    right = {
      section_a = {
        {type = "string", custom = false, name = "date", params = {"%A, %d. %B %Y"}},
      },
      section_b = {
        {type = "string", custom = false, name = "date", params = {"%X"}},
      },
      section_c = {
      }
    }
  },

  status_line = {
    left = {
      section_a = {
        {type = "string", custom = false, name = "tab_mode"},
      },
      section_b = {
        {type = "string", custom = false, name = "hovered_size"},
      },
      section_c = {
        {type = "string", custom = false, name = "hovered_path"},
        {type = "coloreds", custom = false, name = "count"},
      }
    },
    right = {
      section_a = {
        {type = "string", custom = false, name = "cursor_position"},
      },
      section_b = {
        {type = "string", custom = false, name = "cursor_percentage"},
      },
      section_c = {
        {type = "string", custom = false, name = "hovered_file_extension", params = {true}},
        {type = "coloreds", custom = false, name = "permissions"},
        {type = "string", custom = false, name = "hovered_ownership"},
      }
    }
  },
})
require("yatline-githead"):setup({
    theme = require("yatline-catppuccin"):setup("macchiato"),

    branch_prefix = "",
    branch_borders = "[]",
})

