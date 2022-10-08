--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty                        = require("naughty")
naughty.config.defaults['icon_size'] = 100

-- Scratchpad
local scratch = require("scratch")
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

--local menubar       = require("menubar")

local lain        = require("lain")
local freedesktop = require("freedesktop")

-- cycle focus clients
local cyclefocus = require("cyclefocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi      = require("beautiful.xresources").apply_dpi
-- }}}



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err) })
        in_error = false
    end)
end
-- }}}



-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions
local sloppy_focus = true

-- keep themes in alfabetical order for ATT
local themes = {
    "blackburn", -- 1
    "copland", -- 2
    "gruvbox", -- 3
    "multicolor", -- 4
    "powerarrow", -- 5
    "powerarrow-blue", -- 6
    "onedark", -- 7
    "dracula", -- 8
}

-- choose your theme here
local chosen_theme = themes[8]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- import bling
local bling = require("bling")
--bling.module.window_swallowing.start()

bling.module.flash_focus.enable()


-- modkey or mod4 = super key
local modkey  = "Mod4"
local altkey  = "Mod1"
local modkey1 = "Control"

-- personal variables
--change these variables if you want
local browser1       = "brave"
local browser2       = "firefox"
local browser3       = "chromium -no-default-browser-check"
local editor         = os.getenv("EDITOR") or "nano"
local editorgui      = "geany"
local filemanager    = "pcmanfm"
local mailclient     = "thunderbird"
local musicplayer    = "alacritty --class music -e ncmpcpp"
local mediaplayer    = "spotify"
local terminal       = "st"
local virtualmachine = "virtualbox"
local scrlocker      = "Lockscreen"

-- awesome variables
awful.util.terminal = terminal
--awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
--awful.util.tagnames = { "", "", "", "", "", "", "", "", "" }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({}, 3, function()
--        local instance = nil

--        return function()
--            if instance and instance.wibox.visible then
--                instance:hide()
--                instance = nil
--            else
--                instance = awful.menu.client_list({ theme = { width = dpi(250) } })
--            end
--        end
        awful.menu.client_list { theme = { width = 250 } }
    end),
    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
    awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}



-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e 'man awesome'" },
    { "edit config", "emacsclient -c -a emacs ~/.config/awesome/rc.lua" },
    { "arandr", "arandr" },
    { "restart", awesome.restart },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu },
        --{ "Atom", "atom" },
        -- other triads can be put here
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
        -- other triads can be put here
    }
})
-- hide menu when mouse leaves it
--Eawful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}



-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper {
            widget = {
                {
                    image = beautiful.wallpaper,
                    resize = true,
                    widget = wibox.widget.imagebox,
                },
                valign = "center",
                halign = "center",
                tiles = false,
                widget = wibox.container.tile,
            }
        }
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

end)


-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s)
    s.systray = wibox.widget.systray()
    s.systray.visible = false
end)
-- }}}



-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({}, 3, function() awful.util.mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev),
    awful.button({ modkey, altkey }, 4, function()
        os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
        beautiful.volume.update()
    end),
    awful.button({ modkey, altkey }, 5, function()
        os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
        beautiful.volume.update()
    end)
))
-- }}}

-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================

-- Move given client to given direction
local function move_client(c, direction)
    -- If client is floating, move to edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        local workarea = awful.screen.focused().workarea
        if direction == "up" then
            c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
        elseif direction == "down" then
            c:geometry({ nil,
                y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 -
                    beautiful.border_width * 2, nil, nil })
        elseif direction == "left" then
            c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
        elseif direction == "right" then
            c:geometry({ x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 -
                beautiful.border_width * 2, nil, nil, nil })
        end
        -- Otherwise swap the client in the tiled layout
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, 0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0, 0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, floating_resize_amount, 0)
        end
    else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(tiling_resize_factor)
        end
    end
end

-- raise focused client
local function raise_client()
    if client.focus then
        client.focus:raise()
    end
end

-- some functions to reduce code
function info(desc, gr)
    return {["description"] = desc; ["group"] = gr} end
function run(command)
    return function() awful.util.spawn(command) end end

-- {{{ Key bindings
Globalkeys = my_table.join(

-- {{{ Personal keybindings
    awful.key({ modkey }, "w", run(browser1),
        info(browser1,"super")),
    -- dmenu
    awful.key({ modkey }, "d",
        function()
            awful.spawn(string.format("dmenu_run -i -h 22 -p 'Run: '",
                beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        info("show dmenu","hotkeys")),

    awful.key({ "Shift" }, "Alt_L", function() beautiful.mykeyboardlayout.next_layout(); end),

    -- Function keys
    awful.key({}, "F12", run("xfce4-terminal --drop-down"),
        info("dropdown terminal", "function keys")),
    --    awful.key({ }, "F12", function () awful.screen.focused().quake:toggle() end,
    --          {description = "DropDown Terminal", group = "function keys"}),

    -- super + ... function keys
    awful.key({ modkey }, "F1", run(browser1),
        info(browser1, "function keys" )),
    awful.key({ modkey }, "F2", run(editorgui),
        info(editorgui, "function keys" )),
    awful.key({ modkey }, "F3", run("rofi -show ssh -theme ~/.config/rofi/ssh.rasi"),
        info("SSH Menu", "function keys" )),
    --    awful.key({ modkey }, "F4", function () awful.util.spawn( "gimp" ) end,
    --        {description = "gimp" , group = "function keys" }),
    awful.key({ modkey }, "F4", function() scratch.toggle("urxvt -name scratch", { instance ="scratch" }) end,
        info("dropdown terminal", "function keys" )),
    awful.key({ modkey }, "F5", run("meld"),
        info("meld", "function keys" )),
    awful.key({ modkey }, "F6", run("vlc --video-on-top"),
        info("vlc", "function keys" )),
    awful.key({ modkey }, "F7", run("virtualbox"),
        info(virtualmachine, "function keys" )),
    awful.key({ modkey }, "F8", run(filemanager),
        info(filemanager, "function keys" )),
    awful.key({ modkey }, "F9", run(mailclient),
        info(mailclient, "function keys" )),
    awful.key({ modkey }, "F10", run(musicplayer),
        info("ncmpcpp", "function keys" )),
    awful.key({ modkey }, "F11",
        run("rofi -theme-str 'window {width: 100%;height: 100%;}' -show drun"),
        info("rofi fullscreen", "function keys" )),
--    awful.key({ modkey }, "F12", function() awful.util.spawn("rofi -show drun") end,
--        info("rofi", "function keys" )),
    awful.key({ modkey }, "F12", function() scratch.toggle("st -n scratch", { instance = "scratch" }) end,
        info("Terminal", "function keys" )),

    -- super + ...
    awful.key({ modkey }, "c", run("conky-toggle"),info("conky-toggle", "super" )),
    awful.key({ modkey }, "e", run(filemanager),info(filemanager, "super" )),
    --awful.key({ modkey }, "h", function () awful.util.spawn( "urxvt -T 'htop task manager' -e htop" ) end,
    --{description = "htop", group = "super"}),
    awful.key({ modkey }, "r", run("rofi-theme-selector"),info("rofi theme selector", "super" )),
    --    awful.key({ modkey }, "t", function () awful.util.spawn( terminal ) end,
    --        {description = "terminal", group = "super"}),
    awful.key({ modkey }, "v", run("pavucontrol"), info("pulseaudio control", "super" )),
    --awful.key({ modkey }, "u", function () awful.screen.focused().mypromptbox:run() end,
    --{description = "run prompt", group = "super"}),
    awful.key({ modkey }, "x", run("archlinux-logout"),info("exit", "hotkeys" )),
    awful.key({ modkey }, "Escape", run("xkill"), info("Kill process", "hotkeys" )),
    awful.key({ modkey }, "p", run("rofi -show drun"), info("Rofi drun", "super")),
    awful.key({ altkey }, "Escape", function()
        local locker = "i3lock -c 000000 && xset dpms force off"
        awful.menu({
            { "Powermenu" },
            { "&l lock", function() awful.spawn.with_shell(locker) end },
            { "&e quit", function() awesome.quit() end },
            { "&s suspend", function() awful.spawn.with_shell(locker .. " && systemctl suspend") end },
            { "&h hibernate", function() awful.spawn.with_shell(locker .. " && systemctl hibernate") end },
            { "&r reboot", function() awful.spawn.with_shell("systemctl reboot") end },
            { "&p poweroff", function() awful.spawn.with_shell("systemctl poweroff") end },
        }):toggle()
    end,
        { description = "get powermenu", group = "awesome" }),

    -- super + shift + ...
    awful.key({ modkey, "Shift" }, "Return", run(filemanager)),
    awful.key({ modkey, "Shift" }, "s", function()
        sloppy_focus = not sloppy_focus
    end, info("toggle sloppy focus", "client" )),

    -- ctrl + shift + ...
    awful.key({ modkey1, "Shift" }, "Escape", run("xfce4-taskmanager")),


    -- ctrl+alt +  ...
--    awful.key({ modkey1, altkey }, "w", run("arcolinux-welcome-app"),
--        info("ArcoLinux Welcome App", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "e", run("archlinux-tweak-tool"),
--        info("ArcoLinux Tweak Tool", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "Next", run("conky-rotate -n"),
--        info("Next conky rotation", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "Prior", run("conky-rotate -p"),
--        info("Previous conky rotation", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "a", run("xfce4-appfinder"),
--        info("Xfce appfinder", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "b", run(filemanager),
--        info(filemanager, "alt+ctrl" )),
    --    awful.key({ modkey1, altkey   }, "c", function() awful.util.spawn("catfish") end,
    --        {description = "catfish", group = "alt+ctrl"}),
    --    awful.key({ modkey1, altkey   }, "f", function() awful.util.spawn( browser2 ) end,
    --        {description = browser2, group = "alt+ctrl"}),
    --    awful.key({ modkey1, altkey   }, "g", function() awful.util.spawn( browser3 ) end,
    --        {description = browser3, group = "alt+ctrl"}),
    --    awful.key({ modkey1, altkey   }, "k", function() awful.util.spawn( "archlinux-logout" ) end,
    --        {description = scrlocker, group = "alt+ctrl"}),
    --    awful.key({ modkey1, altkey   }, "l", function() awful.util.spawn( "archlinux-logout" ) end,
    --        {description = scrlocker, group = "alt+ctrl"}),
    awful.key({ modkey1, altkey }, "o",
        function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
        info("Picom toggle", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "s", function() awful.util.spawn(mediaplayer) end,
--        info(mediaplayer, "alt+ctrl" )),
    --    awful.key({ modkey1, altkey   }, "t", function() awful.util.spawn( terminal ) end,
    --        {description = terminal, group = "alt+ctrl"}),
--    awful.key({ modkey1, altkey }, "u", function() awful.util.spawn("pavucontrol") end,
--        info("pulseaudio control", "alt+ctrl" )),
    --    awful.key({ modkey1, altkey   }, "v", function() awful.util.spawn( browser1 ) end,
    --        {description = browser1, group = "alt+ctrl"}),
    --    awful.key({ modkey1, altkey   }, "Return", function() awful.util.spawn(terminal) end,
    --        {description = terminal, group = "alt+ctrl"}),
--    awful.key({ modkey1, altkey }, "m", function() awful.util.spawn("xfce4-settings-manager") end,
--        info("Xfce settings manager", "alt+ctrl" )),
--    awful.key({ modkey1, altkey }, "p", function() awful.util.spawn("pamac-manager") end,
--        info("Pamac Manager", "alt+ctrl" )),

    -- alt + ...
    --   awful.key({ altkey, "Shift"   }, "t", function () awful.spawn.with_shell( "variety -t  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
    --        {description = "Pywal Wallpaper trash", group = "altkey"}),
    --    awful.key({ altkey, "Shift"   }, "n", function () awful.spawn.with_shell( "variety -n  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
    --        {description = "Pywal Wallpaper next", group = "altkey"}),
    --    awful.key({ altkey, "Shift"   }, "u", function () awful.spawn.with_shell( "wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
    --        {description = "Pywal Wallpaper update", group = "altkey"}),
    --    awful.key({ altkey, "Shift"   }, "p", function () awful.spawn.with_shell( "variety -p  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
    --        {description = "Pywal Wallpaper previous", group = "altkey"}),
    --    awful.key({ altkey }, "t", function () awful.util.spawn( "variety -t" ) end,
    --        {description = "Wallpaper trash", group = "altkey"}),
    --    awful.key({ altkey }, "n", function () awful.util.spawn( "variety -n" ) end,
    --        {description = "Wallpaper next", group = "altkey"}),
    --    awful.key({ altkey }, "p", function () awful.util.spawn( "variety -p" ) end,
    --       {description = "Wallpaper previous", group = "altkey"}),
    --    awful.key({ altkey }, "f", function () awful.util.spawn( "variety -f" ) end,
    --        {description = "Wallpaper favorite", group = "altkey"}),
    --    awful.key({ altkey }, "Left", function () awful.util.spawn( "variety -p" ) end,
    --        {description = "Wallpaper previous", group = "altkey"}),
    --    awful.key({ altkey }, "Right", function () awful.util.spawn( "variety -n" ) end,
    --        {description = "Wallpaper next", group = "altkey"}),
    --    awful.key({ altkey }, "Up", function () awful.util.spawn( "variety --pause" ) end,
    --        {description = "Wallpaper pause", group = "altkey"}),
    --    awful.key({ altkey }, "Down", function () awful.util.spawn( "variety --resume" ) end,
    --        {description = "Wallpaper resume", group = "altkey"}),
    -- awful.key({ altkey }, "F2", function() awful.util.spawn("xfce4-appfinder --collapsed") end,
    --     info("Xfce appfinder", "altkey" )),
    -- awful.key({ altkey }, "F3", function() awful.util.spawn("xfce4-appfinder") end,
    --     info("Xfce appfinder", "altkey" )),
    -- awful.key({ altkey }, "F5", function () awful.spawn.with_shell( "xlunch --config ~/.config/xlunch/default.conf --input ~/.config/xlunch/entries.dsv" ) end,
    --    {description = "Xlunch app launcher", group = "altkey"}),

    -- screenshots
    awful.key({}, "Print", run("scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'"),
        info("Scrot", "screenshots" )),
    awful.key({ modkey1 }, "Print", run("xfce4-screenshooter"),
        info("Xfce screenshot", "screenshots" )),
    awful.key({ modkey1, "Shift" }, "Print", run("gnome-screenshot -i"),
        info("Gnome screenshot", "screenshots" )),

    -- Personal keybindings}}}


    -- Hotkeys Awesome

    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        info("show help", "awesome" )),

    -- Tag browsing with modkey
    awful.key({ modkey1, modkey,   }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey1, modkey,   }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ altkey, }, "Escape", awful.tag.history.restore,
        info("go back", "tag" )),

    -- Tag browsing modkey + tab
    awful.key({ modkey, }, "Tab", awful.tag.viewnext,
        info("view next", "tag" )),
    awful.key({ modkey, "Shift" }, "Tab", awful.tag.viewprev,
        info("view previous", "tag" )),


    -- Non-empty tag browsing
    --awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
    --{description = "view  previous nonempty", group = "tag"}),
    -- awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
    -- {description = "view  next nonempty", group = "tag"}),

    -- CLient focus by TAB
    --    awful.key({ altkey,           }, "Tab",
    --        function ()
    --            awful.client.focus.byidx( 1)
    --        end,
    --        {description = "focus next by index", group = "client"}),
    --    awful.key({ altkey, "Shift"   }, "Tab",
    --        function ()
    --            awful.client.focus.byidx(-1)
    --        end,
    --        {description = "focus previous by index", group = "client"}),

    -- Default client focus
    awful.key({ modkey, modkey1, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        info("focus next by index", "client" )
    ),
    awful.key({ modkey, modkey1 }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        info("focus previous by index", "client" )
    ),

    -- By direction client focus
    --    awful.key({ modkey }, "j",
    --        function()
    --            awful.client.focus.global_bydirection("down")
    --            if client.focus then client.focus:raise() end
    --        end,
    --        {description = "focus down", group = "client"}),
    --    awful.key({ modkey }, "k",
    --        function()
    --            awful.client.focus.global_bydirection("up")
    --            if client.focus then client.focus:raise() end
    --        end,
    --        {description = "focus up", group = "client"}),
    --    awful.key({ modkey }, "h",
    --        function()
    --            awful.client.focus.global_bydirection("left")
    --            if client.focus then client.focus:raise() end
    --        end,
    --        {description = "focus left", group = "client"}),
    --    awful.key({ modkey }, "l",
    --        function()
    --            awful.client.focus.global_bydirection("right")
    --            if client.focus then client.focus:raise() end
    --        end,
    --        {description = "focus right", group = "client"}),


    -- By direction client focus with arrows
    awful.key({ modkey }, "Down",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        info("focus down", "client" )),
    awful.key({ modkey }, "Up",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        info("focus up", "client" )),
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        info("focus left", "client" )),
    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        info("focus right", "client" )),

    -- =========================================
    -- CLIENT MOVING
    -- =========================================
    awful.key({ modkey, "Shift" }, "Down",
        function()
            move_client(client.focus, "down")
        end,
        info("move down", "client" )),
    awful.key({ modkey, "Shift" }, "Up",
        function()
            move_client(client.focus, "up")
        end,
        info("move up", "client" )),
    awful.key({ modkey, "Shift" }, "Left",
        function()
            move_client(client.focus, "left")
        end,
        info("move left", "client" )),
    awful.key({ modkey, "Shift" }, "Right",
        function()
            move_client(client.focus, "right")
        end,
        info("move right", "client" )),

    -- =========================================
    -- CLIENT RESIZING
    -- =========================================
    awful.key({ modkey, altkey }, "Down",
        function()
            resize_client(client.focus, "down")
        end,
        info("resize down", "client" )),
    awful.key({ modkey, altkey }, "Up",
        function()
            resize_client(client.focus, "up")
        end,
        info("resize up", "client" )),
    awful.key({ modkey, altkey }, "Left",
        function()
            resize_client(client.focus, "left")
        end,
        info("resize left", "client" )),
    awful.key({ modkey, altkey }, "Right",
        function()
            resize_client(client.focus, "right")
        end,
        info("resize right", "client" )),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        info("swap with next client by index", "client" )),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        info("swap with previous client by index", "client" )),
    awful.key({ modkey, altkey }, "j", function() awful.screen.focus_relative(1) end,
        info("focus the next screen", "screen" )),
    awful.key({ modkey, altkey }, "k", function() awful.screen.focus_relative(-1) end,
        info("focus the previous screen", "screen" )),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        info("jump to urgent client", "client" )),
    awful.key({ modkey1, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        info("go back", "client" )),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
        info("toggle wibox", "awesome" )),

    -- Show/Hide Systray
    awful.key({ modkey }, "-", function()
        awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, info("Toggle systray visibility", "awesome" )),

    -- Show/Hide Systray
    awful.key({ modkey }, "KP_Subtract", function()
        awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, info("Toggle systray visibility", "awesome" )),



    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "l", function() lain.util.useless_gaps_resize(1) end,
        info("increment useless gaps", "tag" )),
    awful.key({ altkey, "Control" }, "h", function() lain.util.useless_gaps_resize(-1) end,
        info("decrement useless gaps", "tag" )),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function() lain.util.add_tag() end,
        info("add new tag", "tag" )),
    awful.key({ modkey, "Control" }, "r", function() lain.util.rename_tag() end,
        info("rename tag", "tag" )),
    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --          {description = "move tag to the left", "tag")),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --          {description = "move tag to the right", "tag")),
    awful.key({ modkey, "Shift" }, "y", function() lain.util.delete_tag() end,
        info("delete tag", "tag" )),

    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
        info(terminal, "super" )),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        info("reload awesome", "awesome" )),
    -- awful.key({ modkey, "Shift"   }, "x", awesome.quit,
    --          {description = "quit awesome", group = "awesome")),

    awful.key({ altkey, "Shift" }, "l", function() awful.tag.incmwfact(0.05) end,
        info("increase master width factor", "layout" )),
    awful.key({ altkey, "Shift" }, "h", function() awful.tag.incmwfact(-0.05) end,
        info("decrease master width factor", "layout" )),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        info("increase the number of master clients", "layout" )),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        info("decrease the number of master clients", "layout" )),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        info("increase the number of columns", "layout" )),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        info("decrease the number of columns", "layout" )),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        info("select next", "layout" )),
    awful.key({ modkey, modkey1 }, "Up", function() awful.layout.inc(1) end,
        info("select next", "layout" )),
    awful.key({ modkey, modkey1 }, "Down", function() awful.layout.inc(-1) end,
        info("select previous", "layout")),

    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        info("restore minimized", "client" )),

    -- Widgets popups
    --awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
    --{description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    --{description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    --{description = "show weather", group = "widgets"}),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function() os.execute("xbacklight -inc 10") end,
        info("+10%", "hotkeys" )),
    awful.key({}, "XF86MonBrightnessDown", function() os.execute("xbacklight -dec 10") end,
        info("-10%", "hotkeys" )),

    -- ALSA volume control
    --awful.key({ modkey1 }, "Up",
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    --awful.key({ modkey1 }, "Down",
    awful.key({}, "XF86AudioLowerVolume",
        function()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({}, "XF86AudioMute",
        function()
            os.execute(string.format("amixer -q set %s toggle",
                beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "m",
        function()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "0",
        function()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),

    --Media keys supported by vlc, spotify, audacious, xmm2, ...
    --awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
    --awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
    --awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),
    --awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop", false) end),

    --Media keys supported by mpd.
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("mpc toggle") end),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn("mpc next") end),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn("mpc prev") end),
    awful.key({}, "XF86AudioStop", function() awful.util.spawn("mpc stop") end),

    -- MPD control
    awful.key({ modkey1, "Shift" }, "Up",
        function()
            os.execute("mpc toggle")
            beautiful.mpd.update()
        end,
        info("mpc toggle", "widgets" )),
    awful.key({ modkey1, "Shift" }, "Down",
        function()
            os.execute("mpc stop")
            beautiful.mpd.update()
        end,
        info("mpc stop", "widgets" )),
    awful.key({ modkey1, "Shift" }, "Left",
        function()
            os.execute("mpc prev")
            beautiful.mpd.update()
        end,
        info("mpc prev", "widgets" )),
    awful.key({ modkey1, "Shift" }, "Right",
        function()
            os.execute("mpc next")
            beautiful.mpd.update()
        end,
        info("mpc next", "widgets" )),
    awful.key({ modkey1, "Shift" }, "s",
        function()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        info("mpc on/off", "widgets" )),

    -- Copy primary to clipboard (terminals to gtk)
    --awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
    -- {description = "copy terminal to gtk", group = "hotkeys"}),
    --Copy clipboard to primary (gtk to terminals)
    --awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
    --{description = "copy gtk to terminal", group = "hotkeys"}),


    -- Default
    --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "super"})
    --]]

    awful.key({ altkey }, "x",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        info("lua execute prompt", "awesome" ))
--]]
)

Clientkeys = my_table.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client,
        info("magnify client", "client" )),
    awful.key({ modkey, }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        info("toggle fullscreen", "client" )),
    awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end,
        info("close", "hotkeys" )),
    awful.key({ modkey, }, "q", function(c) c:kill() end,
        info("close", "hotkeys" )),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        info("toggle floating", "client" )),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        info("move to master", "client" )),
    awful.key({ modkey, "Shift" }, "n", function(c) c:move_to_screen() end,
        info("move to screen", "client" )),
    awful.key({ modkey, "Shift" }, "m", function(c) c:move_to_screen() end,
        info("move to screen", "client" )),
    --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    --{description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        info("minimize", "client" )),
    -- altkey+Tab: cycle through all clients.
    awful.key({ altkey }, "Tab", function(c)
        cyclefocus.cycle({ modifier = "Alt_L" })
    end,
        info("Cycle through all clients", "client" )
    ),
    -- altkey+Shift+Tab: backwards
    awful.key({ altkey, "Shift" }, "Tab", function(c)
        cyclefocus.cycle({ modifier = "Alt_L" })
    end,
        info("cycle through all clients backwards", "client" )
    ),
    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        info("maximize", "client" )
)
)
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = info("view tag #", "tag" )
        descr_toggle = info("toggle tag #", "tag" )
        descr_move = info("move focused client to tag #", "tag" )
        descr_toggle_focus = info("toggle focused client on tag #", "tag" )
    end
    Globalkeys = my_table.join(Globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end
            end,
            descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus)
    )
end

Clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(Globalkeys)
-- }}}



-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = {},
        properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = Clientkeys,
            buttons = Clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
        properties = { titlebars_enabled = false } },
    -- Set applications to always map on the tag 2 on screen 1.
    --{ rule = { class = "Subl" },
    --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },


    -- Set applications to always map on the tag 1 on screen 1.
    -- find class or role via xprop command
    --{ rule = { class = browser2 },
    --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

    --{ rule = { class = browser1 },
    --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

    --{ rule = { class = "Vivaldi-stable" },
    --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true } },

    --{ rule = { class = "Chromium" },
    --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

    --{ rule = { class = "Opera" },
    --properties = { screen = 1, tag = awful.util.tagnames[1],switchtotag = true  } },

    -- Set applications to always map on the tag 2 on screen 1.
    --{ rule = { class = "Subl" },
    --properties = { screen = 1, tag = awful.util.tagnames[2],switchtotag = true  } },

    --{ rule = { class = editorgui },
    --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    --{ rule = { class = "Brackets" },
    --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    --{ rule = { class = "Code" },
    --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    --    { rule = { class = "Geany" },
    --  properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },


    -- Set applications to always map on the tag 3 on screen 1.
    --{ rule = { class = "Inkscape" },
    --properties = { screen = 1, tag = awful.util.tagnames[3], switchtotag = true  } },

    -- Set applications to always map on the tag 4 on screen 1.
    --{ rule = { class = "Gimp" },
    --properties = { screen = 1, tag = awful.util.tagnames[4], switchtotag = true  } },

    -- Set applications to always map on the tag 5 on screen 1.
    --{ rule = { class = "Meld" },
    --properties = { screen = 1, tag = awful.util.tagnames[5] , switchtotag = true  } },

    -- Scratchpad Rule
    {
        rule_any = {
            instance = { "scratch" },
            class = { "scratch" },
            icon_name = { "scratchpad_urxvt" },
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = true,
            minimized = true,
            sticky = false,
            width = screen_width * 0.7,
            height = screen_height * 0.75
        },
        callback = function(c)
            awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
            gears.timer.delayed_call(function()
                c.urgent = false
            end)
        end
    },

    -- Set applications to be maximized at startup.
    -- find class or role via xprop command

    { rule = { class = editorgui },
        properties = { maximized = true } },

    { rule = { class = "Geany" },
        properties = { maximized = false, floating = false } },

    -- { rule = { class = "Thunar" },
    --     properties = { maximized = false, floating = false } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
        properties = { maximized = true } },

    { rule = { class = "Gnome-disks" },
        properties = { maximized = true } },

    { rule = { class = "inkscape" },
        properties = { maximized = true } },

    { rule = { class = mediaplayer },
        properties = { maximized = true } },

    { rule = { class = "Vlc" },
        properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
        properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
        properties = { maximized = true } },

    { rule = { class = "Vivaldi-stable" },
        properties = { maximized = false, floating = false } },

    { rule = { class = "Vivaldi-stable" },
        properties = { callback = function(c) c.maximized = false end } },

    --IF using Vivaldi snapshot you must comment out the rules above for Vivaldi-stable as they conflict
    --    { rule = { class = "Vivaldi-snapshot" },
    --          properties = { maximized = false, floating = false } },

    --    { rule = { class = "Vivaldi-snapshot" },
    --          properties = { callback = function (c) c.maximized = false end } },

    { rule = { class = "Xfce4-settings-manager" },
        properties = { floating = false } },

    -- Floating clients.
    { rule_any = {
        instance = {
            "DTA", -- Firefox addon DownThemAll.
            "copyq", -- Includes session name in class.
        },
        class = {
            "Arandr",
            "Arcolinux-welcome-app.py",
            "Blueberry",
            "Galculator",
            "Gnome-font-viewer",
            "Gpick",
            "Imagewriter",
            "Font-manager",
            "Kruler",
            "MessageWin", -- kalarm.
            "archlinux-logout",
            "archlinux-tweak-tool",
            "Peek",
            "Skype",
            "System-config-printer.py",
            "Sxiv",
            "Unetbootin.elf",
            "Wpa_gui",
            "pinentry",
            "veromix",
            "xtightvncviewer",
            "pavucontrol",
            "Xfce4-terminal" },

        name = {
            "Event Tester", -- xev.
        },
        role = {
            "AlarmWindow", -- Thunderbird's calendar.
            "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            "Preferences",
            "setup",
        }
    }, properties = { floating = true } },

    -- Floating clients but centered in screen
    { rule_any = {
        class = {
            "Polkit-gnome-authentication-agent-1",
            "Arcolinux-calamares-tool.py",
            "Pcmanfm", "pcmanfm",
        },
    },
        properties = { floating = true },
        callback = function(c)
            awful.placement.centered(c, nil)
        end },

    -- Floating music client, centered in screen
    { rule_any = {
        class = {
            "music",
        },
        instance = {
            "music",
        },
    },
        properties = { floating = true,
            width = screen_width * 0.5,
            height = screen_height * 0.5,
        },
        callback = function(c)
            awful.placement.centered(c, nil)
        end },

    { rule_any = {
        role = {
            "TfrmDialog",
            "TfrmFileOp"
        },
        type = {
            "dialog"
        },
    },
        properties = { floating = true, titlebars_enabled = true },
        callback = function(c)
            awful.placement.centered(c, nil)
        end },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
        not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    if c.transient_for then
        awful.placement.centered(c, {
            parent = c.transient_for
        })
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = dpi(21) }):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
    awful.titlebar.hide(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = true})
--end)
client.connect_signal("mouse::enter", function(c)
    if sloppy_focus and awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        c:emit_signal("request::activate", "mouse_enter", { raise = false })
    end
end)

-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
    if c.floating then
        c.border_color = beautiful.border_float
    end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("property::floating", function(c)
	if c.floating then
		awful.titlebar.show(c)
	else
		awful.titlebar.hide(c)
	end
end)

-- }}}

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
--awful.spawn.with_shell("picom -b --config  $HOME/.config/arco-dwm/picom.conf")
