module Custom.MyManagement where

import Custom.MyScratchpads
import XMonad
import XMonad.Hooks.ManageHelpers (doCenterFloat,isDialog)
import XMonad.Util.NamedScratchpad

myManagement =
  composeAll . concat $
    [ [isDialog --> doCenterFloat],
      [className =? c --> doCenterFloat | c <- myCFloats],
      [title =? t --> doFloat | t <- myTFloats],
      [resource =? r --> doFloat | r <- myRFloats],
      [resource =? i --> doIgnore | i <- myIgnores],
      [namedScratchpadManageHook myScratchpads],
      [role =? "TfrmFileOp" --> doCenterFloat]
    ]
  where
    myCFloats =
      [ "Arandr",
        "Arcolinux-calamares-tool.py",
        "archlinux-tweak-tool.py",
        "Archlinux-logout.py",
        "feh",
        "mpv",
        "vlc",
        "Vlc",
        "pamac-manager",
        "xfce4-terminal",
        "xfce4-appfinder",
        "confirm",
        "file_progress",
        "Pcmanfm",
        "Spacefm",
        "Gimp",
        "vifm"
      ]
    myTFloats = ["Downloads", "Save As...", "Oracle VM VirtualBox Manager"]
    myRFloats = []
    myIgnores = ["desktop_window"]
    role = stringProperty "WM_WINDOW_ROLE"

myManageHook :: ManageHook
myManageHook = namedScratchpadManageHook myScratchpads <> myManagement
