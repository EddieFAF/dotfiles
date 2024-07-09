module Custom.MyScratchpads where

import Custom.MyManagementPositioning
import qualified XMonad.StackSet as W
import XMonad (appName,title)
import XMonad.ManageHook ((=?))
import XMonad.Util.NamedScratchpad

myTerminal = "alacritty"

myScratchpads :: [NamedScratchpad]
myScratchpads =
  [ NS "terminal" spawnTerm findTerm manageTerm,
    NS "audio" spawnAudio findAudio manageAudio
  ]
  where
    spawnTerm = myTerminal ++ " -t scratchpad"
    findTerm = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.85
        w = 0.85
        t = (1 - h) / 2
        l = (1 - w) / 2
    spawnAudio = myTerminal ++ " -t audio -e ncmpcpp"
    findAudio = title =? "audio"
    manageAudio = customFloating $ W.RationalRect l t w h
      where
        h = 0.7
        w = 0.7
        t = (1 - h) / 2
        l = (1 - w) / 2
{-
To get WM_CLASS of a visible window, run "xprop | grep 'CLASS'" and select the window.
appName :: Query String
Return the application name; i.e., the first string returned by WM_CLASS.

resource :: Query String
Backwards compatible alias for appName.

className :: Query String
Return the resource class; i.e., the second string returned by WM_CLASS. -}
