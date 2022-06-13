--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

     Adopted to the gruvbox color scheme
     by EddieFAF

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi   = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/gruvbox"
--theme.wallpaper                                 = theme.confdir .. "/wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/backgrounds/arcolinux/arco-wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/archlinux-tweak-tool/data/wallpaper/wallpaper.png"
theme.font                                      = "JetBrainsMono Nerd Font Regular 11"
theme.taglist_font                              = "JetBrainsMono Nerd Font Regular 11"
--theme.bg_normal                                 = "#282828"
theme.bg_normal                                 = xrdb.background
theme.bg_focus                                  = xrdb.color2
theme.bg_urgent                                 = theme.bg_normal
theme.bg_minimize                               = theme.bg_focus
theme.bg_systray                                = theme.bg_normal
theme.fg_normal                                 = xrdb.foreground
theme.fg_focus                                  = xrdb.background
theme.fg_urgent                                 = "#cc241d"
theme.fg_minimize                               = theme.fg_normal
theme.border_width                              = 2
theme.border_normal                             = xrdb.background
theme.border_focus                              = xrdb.color11
theme.border_float                              = xrdb.color4
theme.border_marked                             = xrdb.color12
theme.hotkeys_fg                                = theme.fg_normal
theme.hotkeys_bg                                = theme.bg_normal
theme.hotkeys_border_color                      = theme.border_focus
theme.hotkeys_border_width                      = theme.border_width
theme.hotkeys_modifiers_fg                      = theme.fg_urgent
theme.menu_border_width                         = 0
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = xrdb.background
theme.menu_bg_normal                            = xrdb.background
theme.menu_bg_focus                             = xrdb.color2
--theme.menu_bg_normal                            = "#050505dd"
--theme.menu_bg_focus                             = "#050505dd"
theme.widget_temp                               = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.png"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.png"
theme.widget_music                              = theme.confdir .. "/icons/note.png"
theme.widget_music_on                           = theme.confdir .. "/icons/note.png"
theme.widget_music_pause                        = theme.confdir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.confdir .. "/icons/stop.png"
--theme.taglist_squares_sel   = theme.wd .. "tags/focus.png"
--theme.taglist_squares_unsel = theme.wd .. "tags/base.png"
--theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
--theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.taglist_fg_focus    = xrdb.background
theme.taglist_fg_occupied = xrdb.color13
theme.taglist_fg_urgent   = xrdb.color9
theme.taglist_fg_empty    = xrdb.color8
theme.taglist_bg_focus    = xrdb.color2
theme.taglist_spacing     = 2
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_icon                     = false
theme.tasklist_fg_normal                        = xrdb.foreground
theme.tasklist_bg_normal                        = xrdb.background
theme.tasklist_fg_focus                         = xrdb.color2
theme.tasklist_bg_focus                         = xrdb.background
theme.useless_gap                               = 4
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

theme.parent_filter_list   = {"firefox", "Gimp", "doublecmd"} -- class names list of parents that should not be swallowed
theme.child_filter_list    = { "Dragon" }        -- class names list that should not swallow their parents
theme.swallowing_filter = true                   -- whether the filters above should be active

local markup = lain.util.markup
local quake = lain.util.quake()

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
--local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clockicon = wibox.widget.textbox(markup.fontfg(theme.font, "#458588", "  "))
local mytextclock = wibox.widget.textclock(markup("#458588", "%A, %d.%B ") .. markup("#458588", "•") .. markup("#FABD2F", " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Noto Sans Mono Medium 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    APPID = "fe5511607de89ba0f3aca728a3846969",
    city_id = 2940213, -- placeholder (Belgium)
    notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#D3869B", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#D3869B", descr .. " @ " .. units .. "°C "))
    end
})

-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" }, { "de", "" }, { "eu", "" } }
kbdcfg.current = 2  -- de is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_markup(markup.fontfg(theme.font, "#80D9D8", " " .. kbdcfg.layout[kbdcfg.current][1] .. " "))
kbdcfg.switch = function ()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_markup(markup.fontfg(theme.font, "#80D9D8", " " .. t[1] .. " "))
  os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

 -- Mouse bindings
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)

local keyboardText = wibox.widget.textbox();
local keyboardWidget = awful.widget.keyboardlayout();
keyboardText:set_markup(markup.fontfg(theme.font, "#80D9D8", " "));
theme.mykeyboardlayout = awful.widget.keyboardlayout()

-- / fs
--[[ commented because it needs Gio/Glib >= 2.54
local fsicon = wibox.widget.imagebox(theme.widget_fs)
theme.fs = lain.widget.fs({
    notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
    settings  = function()
        widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
    end
})
--]]

-- Mail IMAP check
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- CPU
--local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpuicon = wibox.widget.textbox(markup.fontfg(theme.font, "#B16286", "  "))
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#B16286", cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#D79921", coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})

-- ALSA volume
local volicon = wibox.widget.textbox(markup.fontfg(theme.font, "#FABD2F", "  "))
--local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#FABD2F", volume_now.level .. "% "))
    end
})

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
    settings = function()
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end

        widget:set_markup(markup.fontfg(theme.font, "#FB4934", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#B8BB26", net_now.received .. " "))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FB4934", mem_now.used .. "M "))
    end
})

-- MPD
local musicplr = "alacritty --class music -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    --[[awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    --]]
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FFFFFF", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})

function theme.at_screen_connect(s)
    -- Quake application
--    s.quake = lain.util.quake({ app = awful.util.terminal })
--   s.quake = lain.util.quake({ app = "urxvt", height = 0.50, argname = "--name %s", followtag = true })
--   s.quake = lain.util.quake({ app = "xterm", height = 0.50, argname = "--name %s", vert = "center", horiz = "center", width = 0.75})

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        --s.mytasklist, -- Middle widget
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mailicon,
            --mail.widget,
            mpdicon,
            theme.mpd.widget,
            netdownicon,
            netdowninfo,
            netupicon,
            netupinfo.widget,
            volicon,
            theme.volume.widget,
            --memicon,
            --memory.widget,
            cpuicon,
            cpu.widget,
            weathericon,
            theme.weather.widget,
            kbdcfg.widget,
            --tempicon,
            --temp.widget,
            --baticon,
            --bat.widget,
            clockicon,
            mytextclock,
            wibox.widget.systray(),
            s.mylayoutbox,

        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
        },
    }
end

return theme
