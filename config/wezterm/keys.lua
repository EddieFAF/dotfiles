local wezterm = require("wezterm")
local act = wezterm.action

-- stylua: ignore
return {
	keys = {
		{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
		{ key = "(", mods = "CTRL", action = act.ActivateTab(-1) },
		{ key = "(", mods = "SHIFT|CTRL", action = act.ActivateTab(-1) },
		{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "=", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
		{ key = "-", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "0", mods = "CTRL", action = act.ResetFontSize },
		{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
		--{ key = "r", mods = "CTRL", action = act.ActivateKeyTable({ name = "RESIZE", one_shot = false, prevent_fallback = false, replace_current = true, until_unknown = false, }), },
		{ key = "b", mods = "ALT", action = act.RotatePanes("CounterClockwise") },
		{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		--{ key = "e", mods = "ALT", action = act.EmitEvent("trigger-nvim-with-scrollback") },
		{ key = "f", mods = "ALT", action = act.RotatePanes("Clockwise") },
		{ key = "f", mods = "CTRL", action = act.Multiple({ { ActivateKeyTable = { name = "FOCUS", one_shot = true, prevent_fallback = false, replace_current = true, until_unknown = false,},},}),},
		--{ key = "f", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		--{ key = "k", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
		--{ key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
		--{ key = "m", mods = "SHIFT|CTRL", action = act.Hide },
		{ key = "n", mods = "SHIFT|CTRL", action = act.SpawnWindow },
		{ key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "s", mods = "ALT", action = act.PaneSelect({ alphabet = "1234567890", mode = "Activate" }) },
		{ key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "u", mods = "SHIFT|CTRL", action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }), },
		{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
		--{ key = "x", mods = "CTRL", action = act.ActivateCopyMode },
		{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		--{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
		{ key = "PageUp", mods = "ALT", action = act.ScrollByPage(-1) },
		{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
		{ key = "PageDown", mods = "ALT", action = act.ScrollByPage(1) },
		{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
		{ key = "LeftArrow", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "LeftArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "RightArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "DownArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
		{ key = "Insert", mods = "CTRL", action = act.CopyTo("PrimarySelection") },
		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
	},

	key_tables = {
		FOCUS = {
			{ key = ",", mods = "NONE", action = act.ActivateTabRelative(-1) },
			{ key = ".", mods = "NONE", action = act.ActivateTabRelative(1) },
			{ key = "h", mods = "NONE", action = act.ActivatePaneDirection("Left") },
			{ key = "j", mods = "NONE", action = act.ActivatePaneDirection("Down") },
			{ key = "k", mods = "NONE", action = act.ActivatePaneDirection("Up") },
			{ key = "l", mods = "NONE", action = act.ActivatePaneDirection("Right") },
			{ key = "n", mods = "NONE", action = act.SpawnTab("CurrentPaneDomain") },
			{ key = "q", mods = "NONE", action = act.CloseCurrentPane({ confirm = true }) },
			{ key = "LeftArrow", mods = "NONE", action = act.SplitPane({ command = { domain = "CurrentPaneDomain" }, direction = "Left", size = { Percent = 50 }, top_level = false,}),},
			{ key = "RightArrow", mods = "NONE", action = act.SplitPane({ command = { domain = "CurrentPaneDomain" }, direction = "Right", size = { Percent = 50 }, top_level = false,}),},
			{ key = "UpArrow", mods = "NONE", action = act.SplitPane({ command = { domain = "CurrentPaneDomain" }, direction = "Up", size = { Percent = 50 }, top_level = false,}),},
			{ key = "DownArrow", mods = "NONE", action = act.SplitPane({ command = { domain = "CurrentPaneDomain" }, direction = "Down", size = { Percent = 50 }, top_level = false,}),},
		},

		RESIZE = {
			{ key = "Enter", mods = "NONE", action = act.PopKeyTable },
			{ key = "Escape", mods = "NONE", action = act.PopKeyTable },
			{ key = "f", mods = "NONE", action = act.PopKeyTable },
			{ key = "i", mods = "NONE", action = act.Multiple({ "PopKeyTable", { SendKey = { key = "i", mods = "NONE" } } }),},
			{ key = "h", mods = "NONE", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "j", mods = "NONE", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "k", mods = "NONE", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "l", mods = "NONE", action = act.AdjustPaneSize({ "Right", 1 }) },
		},

		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "y", mods = "NONE", action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},

		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	},
}