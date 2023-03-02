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

--wezterm.on("update-right-status", function(window)
--    window:set_right_status(wezterm.format({
--        { Attribute = { Intensity = "Bold" } },
--        { Text = wezterm.nerdfonts.mdi_clock .. wezterm.strftime(" %A, %d.%B %Y %H:%M ") },
--    }))
--end)
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

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()

	if name then
		name = "active key table: " .. name
	end

	window:set_right_status(name or "")
end)

local font_name = "Hack Nerd Font"

local colors = {
	-- special
	foreground = "#abb2bf",
	darker_background = "#24272e",
	background = "#282c34",
	lighter_background = "#3d4148",
	one_background = "#202329",

	-- black
	color0 = "#3d4148",
	color8 = "#52565c",

	-- red
	color1 = "#e06c75",
	color9 = "#e06c75",

	-- green
	color2 = "#98c379",
	color10 = "#98c379",

	-- yellow
	color3 = "#e5c07b",
	color11 = "#e5c07b",

	-- blue
	color4 = "#61afef",
	color12 = "#61afef",

	-- magenta
	color5 = "#c678dd",
	color13 = "#c678dd",

	-- cyan
	color6 = "#56b6c2",
	color14 = "#56b6c2",

	-- white
	color7 = "#99a0ab",
	color15 = "#abb2bf",
}

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
	color_scheme = "DoomOne",

	-- X11
	enable_wayland = false,

	-- Keybinds
	disable_default_key_bindings = false,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	key_tables = keybindings.key_tables,
	keys = keybindings.keys,

	bold_brightens_ansi_colors = false,
	-- colors = {
	-- 	background = colors.background,
	-- 	foreground = colors.foreground,
	--
	-- 	cursor_bg = colors.foreground,
	-- 	cursor_fg = colors.foreground,
	-- 	cursor_border = colors.foreground,
	--
	-- 	selection_fg = colors.background,
	-- 	selection_bg = colors.color4,
	--
	-- 	scrollbar_thumb = colors.foreground,
	--
	-- 	split = colors.lighter_background,

	-- 	ansi = {
	-- 		colors.color0,
	-- 		colors.color1,
	-- 		colors.color2,
	-- 		colors.color3,
	-- 		colors.color4,
	-- 		colors.color5,
	-- 		colors.color6,
	-- 		colors.color7,
	-- 	},
	--
	-- 	brights = {
	-- 		colors.color8,
	-- 		colors.color9,
	-- 		colors.color10,
	-- 		colors.color11,
	-- 		colors.color12,
	-- 		colors.color13,
	-- 		colors.color14,
	-- 		colors.color15,
	-- 	},
	-- 	tab_bar = {
	-- 		active_tab = {
	-- 			bg_color = colors.background,
	-- 			fg_color = colors.foreground,
	-- 			italic = true,
	-- 		},
	-- 		inactive_tab = { bg_color = colors.darker_background, fg_color = colors.foreground },
	-- 		inactive_tab_hover = { bg_color = colors.one_background, fg_color = colors.darker_background },
	-- 		new_tab = { bg_color = colors.one_background, fg_color = colors.darker_background },
	-- 		new_tab_hover = { bg_color = colors.color4, fg_color = colors.darker_background },
	-- 	},
	-- },

	-- Padding
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
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
	window_frame = { active_titlebar_bg = colors.darker_background },
	exit_behavior = "CloseOnCleanExit",
	window_decorations = "TITLE | RESIZE",
	selection_word_boundary = " \t\n{}[]()\"'`,;:",
	warn_about_missing_glyphs = false,
	xcursor_theme = xcursor_theme,
	xcursor_size = xcursor_size,
	check_for_updates = false,
}
