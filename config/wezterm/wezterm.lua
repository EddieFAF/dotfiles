local wezterm = require("wezterm")
local act = wezterm.action

local keybindings = require("keys")

local xcursor_size = nil
local xcursor_theme = nil

local success, stdout, stderr =
    wezterm.run_child_process({ "gsettings", "get", "org.gnome.desktop.interface", "cursor-theme" })
if success then
  xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
end

local success, stdout, stderr =
    wezterm.run_child_process({ "gsettings", "get", "org.gnome.desktop.interface", "cursor-size" })
if success then
  xcursor_size = tonumber(stdout)
end
local function font_with_fallback(name, params)
  local names = { name, "Iosevka Term", "Apple Color Emoji", "azuki_font" }
  return wezterm.font_with_fallback(names, params)
end

wezterm.on("update-right-status", function(window)
  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.nerdfonts.mdi_clock .. wezterm.strftime(" %A, %d.%B %Y %H:%M ") },
  }))
end)
function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, _, _, _, _)
  local idx = tab.tab_index + 1

  local prefix = (idx > 1 and tabs[idx - 1].is_active) and "  " or " "
  local suffix = (tab.is_active or idx == #tabs) and " " or "  "
  local title = prefix .. idx .. ": " .. basename(tab.active_pane.foreground_process_name) .. suffix

  if tab.is_active then
    return { { Attribute = { Intensity = "Bold" } }, { Text = title } }
  end
  return { { Text = title } }
end)

-- wezterm.on("update-right-status", function(window, pane)
--   local name = window:active_key_table()
--
--   if name then
--     name = "active key table: " .. name
--   end
--
--   window:set_right_status(name or "")
-- end)

local font_name = "JetBrainsMonoNL Nerd Font"

return {
  -- OpenGL for GPU acceleration, Software for CPU
  front_end = "OpenGL",

  -- Font config
  font = font_with_fallback(font_name),
  font_rules = {
    {
      italic = true,
      font = font_with_fallback(font_name, { italic = true }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback(font_name, { bold = true, italic = true }),
    },
    {
      intensity = "Bold",
      font = font_with_fallback(font_name, { bold = true }),
    },
    {
      intensity = "Half",
      font = font_with_fallback(font_name, { weight = "Light" }),
    },
  },
  font_size = 10,
  line_height = 1.0,

  -- Cursor style
  default_cursor_style = "BlinkingUnderline",
  color_scheme = "Tokyo Night Moon",

  -- X11
  enable_wayland = false,

  -- Keybinds
  disable_default_key_bindings = false,
  --leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
  key_tables = keybindings.key_tables,
  keys = keybindings.keys,

  bold_brightens_ansi_colors = false,

  -- Padding
  window_padding = {
    left = 1,
    right = 0,
    top = 8,
    bottom = 0,
  },
  -- Tab Bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tab_index_in_tab_bar = false,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,

  -- General
  animation_fps = 1,
  cursor_blink_rate = 1000,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  enable_kitty_graphics = true,
  initial_cols = 132,
  initial_rows = 43,
  automatically_reload_config = true,
  pane_focus_follows_mouse = true,
  inactive_pane_hsb = { saturation = 1.0, brightness = 0.85 },
  exit_behavior = "CloseOnCleanExit",
  window_decorations = "TITLE | RESIZE",
  selection_word_boundary = " \t\n{}[]()\"'`,;:",
  warn_about_missing_glyphs = false,
  xcursor_theme = xcursor_theme,
  xcursor_size = xcursor_size,
  check_for_updates = false,
}
