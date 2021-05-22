-------------------------------------------------
--   __   __                                _  --
--   \ \ / /                               | | --
--    \ V / _ __ ___   ___  _ __   __ _  __| | --
--     > < | '_ ` _ \ / _ \| '_ \ / _` |/ _` | --
--    / . \| | | | | | (_) | | | | (_| | (_| | --
--   /_/ \_\_| |_| |_|\___/|_| |_|\__,_|\__,_| --
-------------------------------------------------

------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
    -- Base
import XMonad
import XMonad.Config.Desktop
import Data.Monoid
import Data.Maybe (isJust)
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8
import XMonad.Hooks.DynamicLog

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Monoid
import Data.Maybe (isJust, fromJust)
import Data.Tree
import qualified Data.Map as M
import Data.List

    -- Utilities
import XMonad.Util.Loggers
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Hooks
--import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat) 
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

    -- Actions
import XMonad.Actions.Minimize (minimizeWindow)
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), shiftNextScreen, shiftPrevScreen) 
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
import XMonad.Actions.MouseResize
import XMonad.Actions.FlexibleResize as Flex
import qualified XMonad.Actions.TreeSelect as TS
import qualified XMonad.Actions.ConstrainedResize as Sqr
import qualified XMonad.Actions.Search as S

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.WindowNavigation

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))

    -- Prompts
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

------------------------------------------------------------------------
---CONFIG
------------------------------------------------------------------------
myFont          = "xft:Hack Nerd Font:regular:size=11:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask       = mod4Mask  -- Sets modkey to super/windows key

myBrowser       = "qutebrowser "

altMask :: KeyMask -- used in some prompt stuff
altMask         = mod1Mask
myTerminal      = "/usr/local/bin/st"      -- Sets default terminal
myTextEditor    = "nvim"     -- Sets default text editor
myBorderWidth   = 2         -- Sets border width for windows

myNormColor :: String
myNormColor   = "#474646"  -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#CAA9FA"  -- Border color of focused windows

windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


-- Colours
foreground = "#F8F8F2"
fgalt = "#BFBFBF"
background = "#282A36"
secondary = "#BD93F9"
primary = "#50FA7B"
alert = "#FF5555"

------------------------------------------------------------------------
---Startup
------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
--          spawnOnce "lxsession &"
          spawnOnce "xrdb -merge /home/eddie/.Xresources"
          spawnOnce "nitrogen --restore &"
          spawnOnce "nm-applet &"
          spawnOnce "trayer --edge top --align right --width 5 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x282a36 --heighttype pixel --height 22 &"
--          spawnOnce "/home/eddie/.config/polybar/launch_xmonad.sh"
--          spawnOnce "compton -b -f --config /home/eddie/.config/compton.conf &"
          spawnOnce "picom -b --config /home/eddie/.config/picom.conf &"
          spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
--          spawnOnce "lxpolkit &"
          spawnOnce "/home/eddie/Applications/Nextcloud-3.2.1-x86_64.AppImage &"
          spawnOnce "urxvtd -q -o -f &"      -- urxvt daemon for better performance
          spawnOnce "xsetroot -cursor_name left_ptr &"
--          spawnOnce "stalonetray &"
          spawnOnce "mpd &"
          setWMName "LG3D"

------------------------------------------------------------------------
---Xprompts config, stolen from DistroTube
------------------------------------------------------------------------
myXPConfig :: XPConfig
myXPConfig = def
      { font                = myFont
      , bgColor             = "#2E3440"
      , fgColor             = "#D8DEE9"
      , bgHLight            = "#88C0D0"
      , fgHLight            = "#2E3440"
      , borderColor         = "#2E3440"
      , promptBorderWidth   = 0 -- Disable border
      , promptKeymap        = myXPKeymap
      , position            = Top
      -- , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 23
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      -- , defaultText         = map toUpper  -- change prompt to UPPER
      -- , defaultPrompter     = unwords . map reverse . words  -- reverse the prompt
      -- , defaultPrompter     = drop 5 .id (++ "XXXX: ")  -- drop first 5 chars of prompt and add XXXX:
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to 'Just 5' for 5 rows
      }

-- The same config above minus the autocomplete feature which is annoying
-- on certain Xprompts, like the search engine prompts.
myXPConfig' :: XPConfig
myXPConfig' = myXPConfig
      { autoComplete        = Nothing
      }

------------------------------------------------------------------------
---XPrompt Keymap
------------------------------------------------------------------------
myXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
myXPKeymap = M.fromList $
     map (first $ (,) controlMask)      -- control + <key>
     [ (xK_z, killBefore)               -- kill line backwards
     , (xK_k, killAfter)                -- kill line forwards
     , (xK_a, startOfLine)              -- move to the beginning of the line
     , (xK_e, endOfLine)                -- move to the end of the line
     , (xK_m, deleteString Next)        -- delete a character foward
     , (xK_b, moveCursor Prev)          -- move cursor forward
     , (xK_f, moveCursor Next)          -- move cursor backward
     , (xK_BackSpace, killWord Prev)    -- kill the previous word
     , (xK_y, pasteString)              -- paste a string
     , (xK_g, quit)                     -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) altMask)          -- meta key + <key>
     [ (xK_BackSpace, killWord Prev)    -- kill the prev word
     , (xK_f, moveWord Next)            -- move a word forward
     , (xK_b, moveWord Prev)            -- move a word backward
     , (xK_d, killWord Next)            -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]

------------------------------------------------------------------------
---Tabbed Theme
------------------------------------------------------------------------
-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = myFocusColor
                 , inactiveColor       = myNormColor
                 , activeBorderColor   = myFocusColor
                 , inactiveBorderColor = myNormColor
                 , activeTextColor     = "#FFFFFF"
                 , inactiveTextColor   = "#000000"
                 }


------------------------------------------------------------------------
---GRID SELECT
------------------------------------------------------------------------

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x31,0x2e,0x39) -- lowest inactive bg
                  (0x31,0x2e,0x39) -- highest inactive bg
                  (0x61,0x57,0x72) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0xff,0xff,0xff) -- active fg

-- gridSelect menu layout
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 30
    , gs_cellwidth    = 200
    , gs_cellpadding  = 8
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def

myAppGrid = [ ("Mc", "urxvt -e mc")
            , ("Geany", "geany")
            , ("Cmus", "urxvt -e cmus")
            , ("Htop", "urxvt -e htop")
            , ("Volume Control", "pavucontrol")
            , ("Vim", "urxvt -e vim")
            , ("Firefox", "firefox-esr")
            , ("Ranger", "urxvt -e ranger")
            , ("Urxvt", "urxvt")
            , ("Lxappearance",    "lxappearance")
            , ("Double Commander", "doublecmd")
            , ("Thunderbird", "thunderbird")
            , ("Irssi", "urxvtc -e irssi")
            ]

-- Prefix for prompts. Note that there *must* be a space after the binding
promptMod :: String
promptMod = "C-<Space> "
------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
myKeys =
    --- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
--        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
--        , ("M-S-q", io exitSuccess)                  -- Quits xmonad
        , ("M-S-q", spawn "rofi -show power-menu -modi power-menu:/home/eddie/.config/rofi/rofi-power-menu -lines 6 -width 20 -theme /home/eddie/.config/rofi/themes/dracula.rasi") -- Shutdown Menu

    --- Windows
        , ("M-S-c", kill1)                           -- Kill the currently focused client
        , ("M-q",   kill1)                           -- Same as in i3/OB
        , ("M-S-a", killAll)                         -- Kill all the windows on current workspace

    --- Floating windows
        , ("M-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    --- Grid Select
        , ("M-g g", spawnSelected' myAppGrid)
        , ("M-g t", goToSelected $ mygridConfig myColorizer)
        , ("M-g b", bringSelected $ mygridConfig myColorizer)

    -- Increase/decrease spacing (gaps)
        , ("C-M1-j", decWindowSpacing 4)         -- Decrease window spacing
        , ("C-M1-k", incWindowSpacing 4)         -- Increase window spacing
        , ("C-M1-h", decScreenSpacing 4)         -- Decrease screen spacing
        , ("C-M1-l", incScreenSpacing 4)         -- Increase screen spacing

    --- Windows navigation
        , ("M-m", windows W.focusMaster)             -- Move focus to the master window
        , ("M-j", windows W.focusDown)               -- Move focus to the next window
        , ("M-<Tab>", windows W.focusDown)           -- Move Next Window
        , ("M-k", windows W.focusUp)                 -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)              -- Swap the focused window with the next window
        , ("M-S-k", windows W.swapUp)                -- Swap the focused window with the prev window
        , ("M-w <Left>", windows $ W.swapUp . W.focusUp)
        , ("M-w <Right>", windows $ W.swapDown . W.focusDown)
        , ("M-<Backspace>", promote)                 -- Moves focused window to master, all others maintain order
        , ("M-S-<Tab>", rotSlavesDown)              -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)                 -- Rotate all the windows in the current stack

    -- Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
        , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    --- Window Navigation
        , ("M-<Up>", sendMessage $ Go U)             -- Move Up
        , ("M-<Down>", sendMessage $ Go D)           -- Move Down
        , ("M-<Left>", sendMessage $ Go L)           -- Move Left
        , ("M-<Right>", sendMessage $ Go R)          -- Move Right

        , ("M-S-<Up>", sendMessage $ Swap U)         -- Move Up
        , ("M-S-<Down>", sendMessage $ Swap D)       -- Move Down
        , ("M-S-<Left>", sendMessage $ Swap L)       -- Move Left
        , ("M-S-<Right>", sendMessage $ Swap R)      -- Move Right

    --- Layouts
        , ("M-<Space>", sendMessage NextLayout)             -- Switch to next layout
--        , ("M-S-<Space>", sendMessage $ JumpToLayout "tall") -- Reset Layout
        , ("M-b", sendMessage ToggleStruts)                 -- Toggles struts
        , ("M-<KP_Multiply>", sendMessage (IncMasterN 1))   -- Increase number of clients in the master pane
        , ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))  -- Decrease number of clients in the master pane
        , ("M-S-<KP_Multiply>", increaseLimit)              -- Increase number of windows that can be shown
        , ("M-S-<KP_Divide>", decreaseLimit)                -- Decrease number of windows that can be shown

    --  Window resizing
--        , ("M-h", sendMessage Shrink)
--        , ("M-l", sendMessage Expand)
--        , ("M-M1-j", sendMessage MirrorShrink)
--        , ("M-M1-k", sendMessage MirrorExpand)

    --- Workspaces
        , ("M-<KP_Add>", moveTo Next nonNSP)                                -- Go to next workspace
        , ("M-<KP_Subtract>", moveTo Prev nonNSP)                           -- Go to previous workspace
        , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next workspace
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to previous workspace

    --- Scratchpads
        , ("M-s t", namedScratchpadAction myScratchPads "terminal")
        , ("M-s c", namedScratchpadAction myScratchPads "ncmpcpp")

    --- Open Terminal
        , ("M-<Return>", spawn myTerminal)

    -- Other Dmenu Prompts
        , ("M-p o", spawn "~/bin/dmqute")   -- qutebrowser bookmarks/history
    --    , ("M-p p", spawn "passmenu")                    -- passmenu
    --    , ("M-p q", spawn "~/dmscripts/dmlogout") -- logout menu
    --    , ("M-p r", spawn "~/dmscripts/dmred")    -- reddio (a reddit viewer)
        , ("M-p s", spawn "~/bin/dmsearch") -- search various search engines

        , ("M-d", spawn "dmenu_run -fn 'FiraCode Nerd Font:size=11' -h 22 -sf '#F8F8F2' -sb '#BD93F9' -p 'dmenu:'")
--        , ("M-d", spawn "dmenu_run -fn 'Hack Nerd Font:size=10' -nb '#292d3e' -nf '#bbc5ff' -sb '#82AAFF' -sf '#292d3e' -p 'dmenu:'")
        , ("M-<F3>", spawn "rofi -show ssh -font 'Hack Nerd Font 11' -lines 5 -width 300 -theme /home/eddie/.config/rofi/themes/dracula.rasi")
        , ("M-<F2>", spawn "rofi -show drun -font 'Hack Nerd Font 11' -columns 2 -theme /home/eddie/.config/rofi/themes/dracula.rasi")

    --- My Applications (Super+Alt+Key)
        , ("M-M1-a", spawn (myTerminal ++ " -e pulsemixer"))
        , ("M-M1-c", spawn (myTerminal ++ " -e ncmpcpp"))
        , ("M-M1-e", spawn "emacs")
        , ("M-M1-h", spawn (myTerminal ++ " -e htop"))
        , ("M-M1-r", spawn (myTerminal ++ " -e ranger"))
        , ("<Print>", spawn "scrot")
        ]

          where nonNSP          = WSIs (return (\ws -> W.tag ws /= "nsp"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))

--------------------------------------------------------
--- Mouse bindings
--------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
        [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)) -- floating mode and move by dragging
        , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster)) -- Raise the window to the top of the stack
        , ((modMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w >> windows W.shiftMaster)) -- floating mode and resize by dragging
        -- mouse scroll wheel (button4 and button5)
        , ((modMask, button4), (\w -> focus w >> windows W.swapUp))
        , ((modMask, button5), (\w -> focus w >> windows W.swapDown))
        ]

myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
    [ className =? "stalonetray"    --> doIgnore
    , className =? "mpv"          --> doFullFloat
    , manageDocks
    , isFullscreen                --> (doF W.focusDown <+> doFullFloat)
    , className =? "XCalc"           --> doFloat
    , className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , (className =? "Firefox-esr" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
    , className =? "vlc"             --> doCenterFloat
    , title =? "Oracle VM VirtualBox Manager" --> doFloat
    , className =? "Celluloid"       --> doFloat
    , className =? "Pcmanfm"         --> doFloat
    , className  =? "VirtualBox Manager" --> doFloat
    , title =? "Celluloid" --> doCenterFloat
    , title =? "Double Commander" --> doCenterFloat
    , className =? "Brave-browser-beta"   --> doShift ( myWorkspaces !! 0 )
    , className =? "qutebrowser"     --> doShift ( myWorkspaces !! 0 )
    , className =? "Firefox-esr"     --> doShift ( myWorkspaces !! 0 )
    , isDialog --> doCenterFloat
    ] <+> namedScratchpadManageHook myScratchPads

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------
--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ windowNavigation
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 4
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ windowNavigation
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ windowNavigation
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
tallAccordion  = renamed [Replace "tallAccordion"]
           $ Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
           $ Mirror Accordion


myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| grid
                                 ||| spirals
                                 ||| threeCol
                                 ||| threeRow
                                 ||| tallAccordion
                                 ||| wideAccordion

------------------------------------------------------------------------
---SCRATCHPADS
------------------------------------------------------------------------

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "ncmpcpp" spawnNcmpcpp findNcmpcpp manageNcmpcpp
                ]

    where
    spawnTerm  = myTerminal ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
                 where
                 h = (1/2)
                 w = (1/2)
                 t = (1/4)
                 l = (1/4)
    spawnNcmpcpp  = myTerminal ++  " -n ncmpcpp 'ncmpcpp'"
    findNcmpcpp   = resource =? "ncmpcpp"
    manageNcmpcpp = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

------------------------------------------------------------------------
---Clickable Workspaces
------------------------------------------------------------------------
xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces = ["1:\xf269 ","2:\xf120 ","3:\xf0e0 ", "4:\xf07c ","5:\xf1b6 ","6:\xf281 ","7:\xf04b ","8:\xf167 ","9"]
               -- $ [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices


------------------------------------------------------------------------
---Main Part
------------------------------------------------------------------------
main = do
    -- Launching xmobar.
    xmproc <- spawnPipe "xmobar $HOME/.xmonad/xmobarrc"
   -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh desktopConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc x 
                        , ppCurrent = xmobarColor primary "" . wrap " " "" -- Current workspace in xmobar
                        , ppVisible = xmobarColor foreground "" . clickable    -- Visible but not current workspace
                        , ppHidden = xmobarColor secondary "" . wrap "*" "" . clickable   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor fgalt "" . wrap " " "" . clickable       -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor foreground "" . shorten 40     -- Title of active window in xmobar
                        , ppSep =  xmobarColor "#666666" "" " | "         -- Separators in xmobar
                        , ppUrgent = xmobarColor alert "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        } `additionalKeysP`         myKeys

-----------------------------------------------------------------------------}}}
-- CONFIG                                                                    {{{
--------------------------------------------------------------------------------
myConfig = def
  { terminal            = myTerminal
  , layoutHook          = myLayoutHook
  , manageHook          = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
  , startupHook         = myStartupHook
  , focusFollowsMouse   = False
  , clickJustFocuses    = False
  , borderWidth         = myBorderWidth
  , normalBorderColor   = myNormColor
  , focusedBorderColor  = myFocusColor
  , workspaces          = myWorkspaces
  , modMask             = myModMask
   } `additionalKeysP`         myKeys

------------------------------------------------------------------------
---Main Part
------------------------------------------------------------------------
