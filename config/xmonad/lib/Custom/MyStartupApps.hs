module Custom.MyStartupApps where

import XMonad
import XMonad.Util.SpawnOnce

myWallpaperPath :: String
myWallpaperPath = "~/wallpapers/out_the_window_darker.png"

myStartupHook :: X ()
myStartupHook = do
  let wallpaperCmd = "feh --bg-scale " ++ myWallpaperPath
      autostartCmd = "~/.config/xmonad/autostart.sh"
      trayerRestartCmd = "killall trayer; trayer --monitor 1 --edge top --align right --widthtype request --padding 7 --iconspacing 10 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x2B2E37  --height 29 --distance 5 &"
      blurCmd = "~/scripts/feh-blur.sh -s; ~/scripts/feh-blur.sh -d"
      picomCmd = "killall -9 picom; sleep 2 && picom -b &"
      easyeffectsCmd = "easyeffects --gapplication-service &"
      ewwCmd = "~/.config/eww/scripts/startup.sh"
  sequence_ [spawn wallpaperCmd, spawnOnce autostartCmd, spawn blurCmd, spawn picomCmd]
