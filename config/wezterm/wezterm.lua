local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

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

config.term = "wezterm"
config.disable_default_key_bindings = true

config.keys = {
    { key = "Tab", mods = "CTRL",       action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "+",   mods = "CTRL",       action = act.IncreaseFontSize },
    { key = "=",   mods = "CTRL",       action = act.IncreaseFontSize },
    { key = "=",   mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
    { key = "-",   mods = "CTRL",       action = act.DecreaseFontSize },
    { key = "s",   mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "v",   mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "0",   mods = "CTRL",       action = act.ResetFontSize },
    { key = "1",   mods = "ALT",        action = act.ActivateTab(0) },
    { key = "2",   mods = "ALT",        action = act.ActivateTab(1) },
    { key = "3",   mods = "ALT",        action = act.ActivateTab(2) },
    { key = "4",   mods = "ALT",        action = act.ActivateTab(3) },
    { key = "5",   mods = "ALT",        action = act.ActivateTab(4) },
    { key = "6",   mods = "ALT",        action = act.ActivateTab(5) },
    { key = "7",   mods = "ALT",        action = act.ActivateTab(6) },
    { key = "8",   mods = "ALT",        action = act.ActivateTab(7) },
    { key = "9",   mods = "ALT",        action = act.ActivateTab(8) },
    { key = "c",   mods = "CTRL",       action = act.CopyTo("Clipboard") },
    { key = "v",   mods = "CTRL",       action = act.PasteFrom("Clipboard") },
    { key = "n",   mods = "SHIFT|CTRL", action = act.SpawnWindow },
    { key = "w",   mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "s",   mods = "ALT",        action = act.PaneSelect({ alphabet = "1234567890", mode = "Activate" }) },
    { key = "t",   mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "q",          mods = "ALT",     action = act.CloseCurrentTab({ confirm = true }) },
    { key = "PageUp",     mods = "SHIFT",          action = act.ScrollByPage(-1) },
    { key = "PageUp",     mods = "ALT",            action = act.ScrollByPage(-1) },
    { key = "PageDown",   mods = "SHIFT",          action = act.ScrollByPage(1) },
    { key = "PageDown",   mods = "ALT",            action = act.ScrollByPage(1) },
    { key = "LeftArrow",  mods = "CTRL",           action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "CTRL",           action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow",    mods = "CTRL",           action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow",  mods = "CTRL",           action = act.ActivatePaneDirection("Down") },
  }

  -- OpenGL for GPU acceleration, Software for CPU
config.front_end = "OpenGL"

-- Font config
config.font = wezterm.font_with_fallback({ "Iosevka Nerd Font Mono" })
config.font_size = 10
config.line_height = 1.0

config.underline_position = -3
config.underline_thickness = '250%'

-- Cursor style
config.default_cursor_style = "BlinkingUnderline"
config.color_scheme = "OneDark (base16)"

-- X11
config.enable_wayland = false

config.bold_brightens_ansi_colors = false

-- Padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- Tab Bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- General
config.animation_fps = 1
config.cursor_blink_rate = 1000
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.enable_kitty_graphics = true
config.initial_cols = 132
config.initial_rows = 43
config.automatically_reload_config = true
config.pane_focus_follows_mouse = true
config.inactive_pane_hsb = { saturation = 1.0, brightness = 0.85 }
config.exit_behavior = "CloseOnCleanExit"
config.window_decorations = "TITLE | RESIZE"
config.selection_word_boundary = " \t\n{}[]()\"'`,;:"
config.warn_about_missing_glyphs = false
config.xcursor_theme = xcursor_theme
config.xcursor_size = xcursor_size
config.check_for_updates = false


return config
