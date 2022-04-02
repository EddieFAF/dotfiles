--- XMonad Configuration
--- by Eddie
--- last updated on: 2022/02/19

import Control.Monad (unless, when)
import Data.Bits (testBit)
import Data.Foldable (find)
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid
import Foreign.C (CInt)
import XMonad


--- Actions
import XMonad.Actions.CycleWS
import XMonad.Actions.EasyMotion
import XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.OnScreen
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.TiledWindowDragging
import XMonad.Actions.UpdatePointer
import XMonad.Actions.Warp
import XMonad.Actions.WindowMenu
import XMonad.Actions.WithAll (sinkAll)

--- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
--import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing

--- Layouts
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.IndependentScreens
import XMonad.Layout.LimitWindows (decreaseLimit, increaseLimit, limitWindows)
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

--- Layout Modifiers
import XMonad.Layout.Magnifier
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.MultiToggle (EOT (EOT), mkToggle, single, (??))
import qualified XMonad.Layout.MultiToggle as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.LayoutModifier
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.WindowNavigation as LWN

--- Prompts
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Ssh
import XMonad.Prompt.Window
import qualified XMonad.StackSet as W

--- Utils
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.Ungrab

--import Colors.OneDark
import Theme.Theme
------------------------------------------------------------------------------
--- Configuration
------------------------------------------------------------------------------
myFont2 = "xft:JetBrainsMono Nerd Font:weight=regular:pixelsize=12:antialias=true:hinting=true" -- myFont defined in Theme.Theme

myFontBig = "xft:JetBrainsMono Nerd Font:weight=regular:pixelsize=32:antialias=true:hinting=true" -- myFont defined in Theme.Theme

myModMask :: KeyMask
myModMask = mod4Mask

myBrowser = "qutebrowser "

altMask :: KeyMask
altMask = mod1Mask

myTerminal = "alacritty"
myFilemanager = "spacefm"

myNormColor = colorBack --"#bd93f9"

myFocusColor = color02 --"#98C379"

myBorderWidth = 2

myFocusFollowsMouse = True

myClickJustFocuses = False

myDmenu = "dmenu_run" ++ " -p 'dmenu:'" ++ " -l 10"

--- Colors for xmobar
blue, lowWhite, magenta, red, white, yellow :: String -> String
magenta = xmobarColor color05 ""
blue = xmobarColor color04 ""
white = xmobarColor color0F ""
yellow = xmobarColor color0B ""
red = xmobarColor color09 ""
lowWhite = xmobarColor color08 ""

activeWS = xmobarColor color02 "#383C44"

guttergrey = "#4b5263"

grey1, grey2, grey3, grey4, cyan, orange :: String
grey1 = "#2B2E37"
grey2 = "#555E70"
grey3 = "#697180"
grey4 = "#8691A8"
cyan = "#8BABF0"
orange = "#C45500"

--- workspace names
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

currentScreen :: X ScreenId
currentScreen = gets (W.screen . W.current . windowset)

isOnScreen :: ScreenId -> WindowSpace -> Bool
isOnScreen s ws = s == unmarshallS (W.tag ws)

workspaceOnCurrentScreen :: WSType
workspaceOnCurrentScreen = WSIs $ do
  s <- currentScreen
  return $ \x -> W.tag x /= "NSP" && isOnScreen s x

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------

switchScreen :: Int -> X ()
switchScreen d = do
  s <- screenBy d
  mws <- screenWorkspace s
  warpToScreen s 0.618 0.618
  case mws of
    Nothing -> return ()
    Just ws -> windows (W.view ws)

------------------------------------------------------------------------

newtype MyUpdatePointerActive = MyUpdatePointerActive Bool

instance ExtensionClass MyUpdatePointerActive where
  initialValue = MyUpdatePointerActive True

myUpdatePointer :: (Rational, Rational) -> (Rational, Rational) -> X ()
myUpdatePointer refPos ratio =
  whenX isActive $ do
    dpy <- asks display
    root <- asks theRoot
    (_, _, _, _, _, _, _, m) <- io $ queryPointer dpy root
    unless (testBit m 9 || testBit m 8 || testBit m 10) $ -- unless the mouse is clicking
      updatePointer refPos ratio
  where
    isActive = (\(MyUpdatePointerActive b) -> b) <$> XS.get

------------------------------------------------------------------------

multiScreenFocusHook :: Event -> X All
multiScreenFocusHook MotionEvent {ev_x = x, ev_y = y} = do
  ms <- getScreenForPos x y
  case ms of
    Just cursorScreen -> do
      let cursorScreenID = W.screen cursorScreen
      focussedScreenID <- gets (W.screen . W.current . windowset)
      when (cursorScreenID /= focussedScreenID) (focusWS $ W.tag $ W.workspace cursorScreen)
      return (All True)
    _ -> return (All True)
  where
    getScreenForPos ::
      CInt ->
      CInt ->
      X (Maybe (W.Screen WorkspaceId (Layout Window) Window ScreenId ScreenDetail))
    getScreenForPos x y = do
      ws <- windowset <$> get
      let screens = W.current ws : W.visible ws
          inRects = map (inRect x y . screenRect . W.screenDetail) screens
      return $ fst <$> find snd (zip screens inRects)
    inRect :: CInt -> CInt -> Rectangle -> Bool
    inRect x y rect =
      let l = fromIntegral (rect_x rect)
          r = l + fromIntegral (rect_width rect)
          t = fromIntegral (rect_y rect)
          b = t + fromIntegral (rect_height rect)
       in x >= l && x < r && y >= t && y < b
    focusWS :: WorkspaceId -> X ()
    focusWS ids = windows (W.view ids)
multiScreenFocusHook _ = return (All True)

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf =
      def
        { gs_cellheight = 40,
          gs_cellwidth = 200,
          gs_cellpadding = 6,
          gs_originFractX = 0.5,
          gs_originFractY = 0.5,
          gs_font = myFont
        }

--------------------------------------------------------------------------
---- Easymotion configuration
---------------------------------------------------------------------------
emConfig :: EasyMotionConfig
emConfig =
  def
    { txtCol = myFocusColor,
      bgCol = colorBack,
      borderCol = myFocusColor,
      overlayF = textSize,
      cancelKey = xK_Escape,
      emFont = myFontBig,
      borderPx = 1
    }

------------------------------------------------------------------------------
--- Prompt Config
------------------------------------------------------------------------------
myPromptConfig =
  def
    { font = myFont,
      bgColor = colorBack,
      fgColor = color0E,
      promptBorderWidth = 0,
      height = 23,
      position = Top,
      historySize = 256,
      historyFilter = id,
      defaultText = [],
      autoComplete = Just 100000,
      showCompletionOnTab = False,
      searchPredicate = fuzzyMatch,
      alwaysHighlight = True,
      maxComplRows = Nothing
    }

------------------------------------------------------------------------------
--- Startup Hook
------------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
  spawn "$HOME/.xmonad/scripts/autostart.sh"
  spawn ("sleep 2 && trayer --edge top --align right --width 5 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent true --alpha 0 --tint 0x15161E --height 24")
  setWMName "LG3D"
  modify $ \xstate -> xstate {windowset = onlyOnScreen 1 "1_1" (windowset xstate)}

------------------------------------------------------------------------------
--- Key Bindings
------------------------------------------------------------------------------
myKeys =
  [ ("M-<Return>", spawn myTerminal),
    ("M-S-r", spawn "xmonad --restart"),
    ("M-C-r", spawn "xmonad --recompile"),
    ("M-q", kill),
    ("M-x", spawn "arcolinux-logout"),
    ("M-j", windows W.focusDown),
    ("M-k", windows W.focusUp),
    ("C-M1-f", spawn "firefox"),
    ("M-d", spawn ("dmenu_run -p 'Run: ' -h 22 -sb '" ++ color02 ++ "' -sf '" ++ colorBack ++ "'")),
    --    , ("M-e", spawn myDmenu)
    ("M-l", spawn "xscreensaver-command -lock"),
    ("<Print>", spawn "flameshot gui"),
    --    , ("M-c", spawn "colorscheme")
    ("C-M1-r", spawn "rofi-theme-selector"),
    --    , ("M-p s", sshPrompt myPromptConfig)
    ("M-p s", spawn ("sshmenu")),
    ("M-b", sendMessage ToggleStruts),
    ("M-g g", spawnSelected' myAppGrid),
    ("M-g t", goToSelected $ myGridConfig myColorizer),
    ("M-g b", bringSelected $ myGridConfig myColorizer),
    -- Layouts
    ("M1-<Tab>", sendMessage NextLayout),
    ("M1-S-<Tab>", sendMessage FirstLayout),
    ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts),
    -- Floating Windows
    ("M-t", withFocused $ windows . W.sink), -- Push floating window back to tile
    ("M-S-t", sinkAll), -- Push ALL floating windows back to tile
    ("M-C-t", withFocused toggleFloat),
    -- Window Movement
    ("M-<Right>", sendMessage $ Go LWN.R),
    ("M-<Left>", sendMessage $ Go LWN.L),
    ("M-<Up>", sendMessage $ Go U),
    ("M-<Down>", sendMessage $ Go D),
    ("M-S-<Right>", sendMessage $ Swap LWN.R),
    ("M-S-<Left>", sendMessage $ Swap LWN.L),
    ("M-S-<Up>", sendMessage $ Swap U),
    ("M-S-<Down>", sendMessage $ Swap D),
    ("M-f", selectWindow emConfig >>= (`whenJust` windows . W.focusWindow)),
    -- Workspace Movement
    ("M-<Tab>", nextWS),
    ("M-S-<Tab>", prevWS),
    ("M-n", switchScreen 1),
    -- Gaps
    ("M-M1-S-i", decWindowSpacing 4), -- Decrease window spacing
    ("M-M1-i", incWindowSpacing 4), -- Increase window spacing
    ("C-M1-S-o", decScreenSpacing 4), -- Decrease screen spacing
    ("M-M1-o", incScreenSpacing 4), -- Increase screen spacing

    -- Resizing Windows
    ("M-C-w", sendMessage ExpandSlave),
    ("M-C-a", sendMessage Shrink),
    ("M-C-s", sendMessage ShrinkSlave),
    ("M-C-d", sendMessage Expand),
    ("M-o", windowMenu),
    ("M-S-i", sendMessage (IncMasterN 1)), -- Increase Clients in Master
    ("M-S-d", sendMessage (IncMasterN (-1))), -- Decrease Clients in Master

    -- KB_GROUP Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
    ("M-C-h", sendMessage $ pullGroup L),
    ("M-C-l", sendMessage $ pullGroup R),
    ("M-C-k", sendMessage $ pullGroup U),
    ("M-C-j", sendMessage $ pullGroup D),
    ("M-C-m", withFocused (sendMessage . MergeAll)),
    ("M-C-u", withFocused (sendMessage . UnMerge)),
    ("M-C-/", withFocused (sendMessage . UnMergeAll)),
    ("M-C-.", onGroup W.focusUp'), -- Switch focus to next tab
    ("M-C-,", onGroup W.focusDown'), -- Switch focus to prev tab

    -- KB_GROUP Scratchpads
    -- Toggle show/hide these programs.  They run on a hidden workspace.
    -- When you toggle them to show, it brings them to your current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
    ("M-s t", namedScratchpadAction myScratchPads "terminal"),
    ("M-<F12>", namedScratchpadAction myScratchPads "terminal"),
    ("M-s m", namedScratchpadAction myScratchPads "audio"),
    --    , ("M-s c", namedScratchpadAction myScratchPads "calculator")

    -- KB_GROUP Launch Apps
    ("M1-<F2>", spawn "xfce4-appfinder --collapsed"),
    ("M1-<F3>", spawn "xfce4-appfinder"),
    ("C-M1-e", spawn "arcolinux-tweak-tool"),
    ("C-M1-p", spawn "pamac-manager"),
    ("C-S-<ESC>", spawn "xfce4-taskmanager"),
    ("M-<F3>", spawn "rofi -show ssh -font 'JetBrains Mono Nerd Font 11' -lines 5 -width 300"),
    ("M-<F2>", spawn "rofi -show drun"),
    ("S-M1-k", spawn "rofi -show linkding -modi linkding:$HOME/.local/bin/rofi-linkding"),
    ("M-e",    spawn myFilemanager),
    ("M-w",    spawn myBrowser),
    -- volume controls
    ("M-<Print>", spawn "amixer set Master toggle"),
    ("M-<Scroll_lock>", spawn "amixer set Master 5%-"),
    ("M-<Pause>", spawn "amixer set Master 5%+")
  ]
    ++ [] -- (++) is needed here because the following list comprehension
    -- is a list, not a single key binding. Simply adding it to the
    -- list of key bindings would result in something like [ b1, b2,
    -- [ b3, b4, b5 ] ] resulting in a type error. (Lists must
    -- contain items all of the same type.)
  where
    --    [ (otherModMasks ++ "M-" ++ [key], action tag)
    --      | (tag, key)  <- zip myWorkspaces "123456789"
    --      , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
    --                                   , ("S-", windows . W.shift)]
    --    ]

    -- The following lines are needed for named scratchpads.
    nonNSP = WSIs (return (\ws -> W.tag ws /= "NSP"))
    nonEmptyNonNSP = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

-- Testing, if both ways to define work parallel
myKeys2 conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ ((modm .|. shiftMask, xK_Return), spawn "thunar"),
      ((mod1Mask, xK_m), spawn "doublecmd"),
      --      , ((modm, xK_n), onPrevNeighbour def W.view)
      ((modm, xK_m), onNextNeighbour def W.view),
      --      , ((modm .|. shiftMask, xK_n), onPrevNeighbour def W.shift)
      --      , ((modm .|. shiftMask, xK_m), onNextNeighbour def W.shift)
      ((modm .|. shiftMask, xK_m), shiftNextScreen)
    ]
      ++ [ ((m .|. modm, k), windows $ onCurrentScreen f i)
           | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9],
             (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]
      ++ [ ((modm .|. mask, key), f sc)
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
             (f, mask) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]
         ]

------------------------------------------------------------------------------
--- Mouse Bindings
------------------------------------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)),
      ((modMask, button2), (\w -> focus w >> windows W.shiftMaster)),
      ((modMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w >> windows W.shiftMaster)),
      ((modMask .|. shiftMask, button1), dragWindow),
      ((modMask, button4), \_ -> moveTo Prev workspaceOnCurrentScreen),
      ((modMask, button5), \_ -> moveTo Next workspaceOnCurrentScreen)
    ]

-----------------------------------------------------------------------------
--- handleEvent Hook
-----------------------------------------------------------------------------
--myEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "urxvt") (return True) <+> multiScreenFocusHook
--myEventHook :: Event -> X All
myEventHook =
  swallowEventHook (className =? "Alacritty" <||> className =? "urxvt" <||> className =? "st") (return True)
    <+> multiScreenFocusHook

------------------------------------------------------------------------------
--- Manage Hooks
------------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook =
  composeAll . concat $
    [ [isDialog --> doCenterFloat],
      [className =? c --> doCenterFloat | c <- myCFloats],
      [title =? t --> doFloat | t <- myTFloats],
      [resource =? r --> doFloat | r <- myRFloats],
      [resource =? i --> doIgnore | i <- myIgnores],
      [namedScratchpadManageHook myScratchPads],
      [role =? "TfrmFileOp" --> doCenterFloat]
    ]
  where
    myCFloats =
      [ "Arandr",
        "Arcolinux-calamares-tool.py",
        "Arcolinux-tweak-tool.py",
        "feh",
        "mpv",
        "vlc",
        "Vlc",
        "pamac-manager",
        "xfce4-terminal",
        "confirm",
        "file_progress",
        "Gimp"
      ]
    myTFloats = ["Downloads", "Save As...", "Oracle VM VirtualBox Manager"]
    myRFloats = []
    myIgnores = ["desktop_window"]
    role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------------
--- Layouts
------------------------------------------------------------------------------
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
        then W.sink w s
        else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
    )

--  where
resizeTall =
  renamed [Replace "tall"] $
  draggingVisualizer $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  limitWindows 12 $
  mySpacing 8 $
  ResizableTall 1 (3 / 100) (1 / 2) []

--      $ mouseResizableTile
magnified =
  renamed [Replace "Magnify"] $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  magnifier $
  mySpacing 8 $
  ResizableTall 1 (3 / 100) (1 / 2) []

threeCol =
  renamed [Replace "ThreeCol"] $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  limitWindows 7 $
  ThreeCol 1 (3 / 100) (1 / 2)

threeRow =
  renamed [Replace "threeRow"] $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  limitWindows 7 $
  Mirror $
  ThreeCol 1 (3 / 100) (1 / 2)

spirals =
  renamed [Replace "spirals"] $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  mySpacing' 8 $
  spiral (6 / 7)

monocle =
  renamed [Replace "monocle"] $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  limitWindows 20 Full

tabs =
  renamed [Replace "tabs"] $
  tabbedAlways shrinkText myTabConfig

grid =
  renamed [Replace "Grid"] $
  smartBorders $
  windowNavigation $
  addTabs shrinkText myTabConfig $
  subLayout [] (smartBorders Simplest) $
  limitWindows 12 $
  mySpacing 8 $
  mkToggle (single MIRROR) $
  Grid (16 / 10)

floats =
  renamed [Replace "floats"] $
  smartBorders $
  limitWindows 20 simplestFloat

myLayout = avoidStruts $ mouseResize $ T.toggleLayouts floats $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
      withBorder myBorderWidth resizeTall
        ||| magnified
        ||| noBorders monocle
        ||| floats
        ||| noBorders tabs
        ||| grid
        ||| spirals
        ||| threeCol
        ||| threeRow

------------------------------------------------------------------------------
--- Show WName Config
------------------------------------------------------------------------------
myShowWNameConfig :: SWNConfig
myShowWNameConfig =
  def
    { swn_font = "xft:JetBrainsMono Nerd Font:bold:size=60",
      swn_fade = 1.0,
      swn_bgcolor = myNormColor,
      swn_color = myFocusColor
    }

------------------------------------------------------------------------------
--- Tab Configuration
------------------------------------------------------------------------------
myTabConfig =
  def
    { fontName = myFont,
      activeColor = myFocusColor,
      inactiveColor = color07,
      activeBorderColor = myFocusColor,
      inactiveBorderColor = colorBack,
      activeTextColor = colorBack,
      inactiveTextColor = "#FFFFFF"
    }

------------------------------------------------------------------------------
--- Grid Selection
------------------------------------------------------------------------------
myColorizer :: Window -> Bool -> X (String, String)
myColorizer =
  colorRangeFromClassName
    (0x1a, 0x1b, 0x29) -- lowest inactive bg
    (0x1a, 0x1b, 0x29) -- highest inactive bg
    (0xc7, 0x92, 0xea) -- active bg
    (0xc0, 0xa7, 0x9a) -- inactive fg
    (0x1a, 0x1b, 0x29) -- active fg

-- gridSelect menu layout
myGridConfig :: p -> GSConfig Window
myGridConfig colorizer =
  (buildDefaultGSConfig myColorizer)
    { gs_cellheight = 40,
      gs_cellwidth = 200,
      gs_cellpadding = 6,
      gs_originFractX = 0.5,
      gs_originFractY = 0.5,
      gs_font = myFont
    }

myAppGrid =
  [ ("Kitty", "alacritty"),
    ("Brave", "brave"),
    ("Emacs", "emacsclient -c -a emacs"),
    ("Firefox", "firefox"),
    ("Geany", "geany"),
    ("Qutebrowser", "qutebrowser"),
    ("Gimp", "gimp"),
--    ("Kdenlive", "kdenlive"),
    ("LibreOffice Impress", "loimpress"),
    ("LibreOffice Writer", "lowriter"),
    ("Libreoffice", "loffice"),
    ("Libreoffice Calc", "localc"),
    ("Libreoffice Base", "lobase"),
    ("Libreoffice Math", "lomath"),
    ("Libreoffice Draw", "lodraw"),
--    ("OBS", "obs"),
--    ("Teams", "teams"),
    ("PCManFM", "pcmanfm"),
    ("Alacritty", "alacritty"),
    ("htop", myTerminal ++ " -e htop"),
    ("Neovim", myTerminal ++ " -e nvim"),
--    ("Kakoune", myTerminal ++ " -e kak"),
    ("gtop", myTerminal ++ " -e gtop"),
--    ("Change Theme", myTerminal ++ " -e ./.local/bin/changetheme"),
    ("Network", myTerminal ++ " -e nmtui")
  ]

------------------------------------------------------------------------------
--- Scratchpads
------------------------------------------------------------------------------
myScratchPads :: [NamedScratchpad]
myScratchPads =
  [ NS "terminal" spawnTerm findTerm manageTerm,
    NS "audio" spawnAudio findAudio manageAudio
  ]
  where
    spawnTerm = myTerminal ++ " -t scratchpad"
    findTerm = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.8
        w = 0.8
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

------------------------------------------------------------------------------
--- Fadehook
------------------------------------------------------------------------------
myFadeHook =
  composeAll
    [ opaque,
      isUnfocused --> transparency 0.05
    ]

------------------------------------------------------------------------------
--- Main Call
------------------------------------------------------------------------------
main :: IO ()
main =
  xmonad
    . ewmh
    . ewmhFullscreen
    --     . withEasySB mySB1 defToggleStrutsKey
    --     . withEasySB mySB2 defToggleStrutsKey
    . withSB (myXmobar0 <> myXmobar1)
    . docks
    $ myConfig

myConfig =
  def
    { modMask = myModMask, -- Rebind Mod to the Super key
      layoutHook = showWName' myShowWNameConfig $ myLayout, -- Use custom layouts
      manageHook = myManageHook, -- Match on certain windows
      workspaces = withScreens 2 myWorkspaces,
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      borderWidth = myBorderWidth, -- defines border width
      handleEventHook = myEventHook <+> fadeWindowsEventHook,
      logHook = fadeWindowsLogHook myFadeHook,
      terminal = myTerminal,
      startupHook = myStartupHook, -- Autostarting apps
      mouseBindings = myMouseBindings,
      normalBorderColor = myNormColor,
      focusedBorderColor = myFocusColor,
      keys = myKeys2,
      rootMask = rootMask def .|. pointerMotionMask
    }
    `additionalKeysP` myKeys

------------------------------------------------------------------------------
--- XMobar related
------------------------------------------------------------------------------
--mySB1 = statusBarProp "xmobar -x 0 $HOME/.xmobarrc" (clickablePP myXmobarPP 0)
--mySB2 = statusBarProp "xmobar -x 1 $HOME/.xmobarrc1" (clickablePP myXmobarPP 1)
actionPrefix, actionButton, actionSuffix :: [Char]
actionPrefix = "<action=`xdotool key super+"
actionButton = "` button="
actionSuffix = "</action>"

addActions :: [(String, Int)] -> String -> String
addActions [] ws = ws
addActions (x : xs) ws = addActions xs (actionPrefix ++ k ++ actionButton ++ show b ++ ">" ++ ws ++ actionSuffix)
  where
    k = fst x
    b = snd x

myWorkspaceIndices :: M.Map [Char] Integer
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..]

clickable :: [Char] -> [Char] -> [Char]
clickable icon ws = addActions [(show i, 1), ("q", 2), ("Left", 4), ("Right", 5)] icon
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

--myStatusBarSpawner :: Applicative f => ScreenId -> f StatusBarConfig
--myStatusBarSpawner (S s) = do
--                    pure $ statusBarPropTo ("_XMONAD_LOG_" ++ show s)
--                          ("xmobar -x " ++ show s ++ " ~/.config/xmonad/xmobar/xmobarrc" ++ show s)
--                          (pure $ myXmobarPP (S s))
myXmobar0 = statusBarPropTo "_XMONAD_LOG_0" "xmobar -x 0 ~/.config/xmonad/xmobar/xmobarrc0" (clickablePP . filterOutWsPP [scratchpadWorkspaceTag] . marshallPP 0 $ myXmobarPP 0)

myXmobar1 = statusBarPropTo "_XMONAD_LOG_1" "xmobar -x 1 ~/.config/xmonad/xmobar/xmobarrc1" (clickablePP . filterOutWsPP [scratchpadWorkspaceTag] . marshallPP 1 $ myXmobarPP 1)

myXmobarPP :: ScreenId -> PP
--myXmobarPP = filterOutWsPP [scratchpadWorkspaceTag] . marshallPP $ def
myXmobarPP s =
  xmobarPP
    { ppSep = " • ",
      ppWsSep = "",
      --  , ppWsSep   = "<fc=" ++ color09 ++ "><fn=1>|</fn></fc>"
      --  , ppCurrent = xmobarColor cyan "" . clickable wsIconFull
      ppCurrent = xmobarColor color02 "" . wrap "[" "]",
      ppVisible = xmobarColor color04 "" . wrap "[" "]",
      ppVisibleNoWindows = Just (xmobarColor color05 "" . wrap " " " "),
      ppHidden = xmobarColor color04 "" . wrap " " " ",
      ppHiddenNoWindows = xmobarColor color08 "" . wrap " " " ",
      ppUrgent = xmobarColor orange "" . wrap "!" "!",
      ppOrder = \(ws : l : _ : extras) -> [ws, l] ++ extras,
      ppExtras =
        [ wrapL (actionPrefix ++ "n" ++ actionButton ++ "1>") actionSuffix $
          wrapL (actionPrefix ++ "Left" ++ actionButton ++ "4>") actionSuffix $
          wrapL (actionPrefix ++ "Right" ++ actionButton ++ "5>") actionSuffix $
          wrapL " " " " $ layoutColorIsActive s (logLayoutOnScreen s),
          wrapL (actionPrefix ++ "q" ++ actionButton ++ "2>") actionSuffix $
          titleColorIsActive s (shortenL 61 $ logTitleOnScreen s)
        ],
      ppLayout = myLayoutPrinter
    }
  where
    titleColorIsActive n l = do
      c <- withWindowSet $ return . W.screen . W.current
      if n == c then xmobarColorL color04 "" l else xmobarColorL color08 "" l
    layoutColorIsActive n l = do
      c <- withWindowSet $ return . W.screen . W.current
      if n == c then wrapL "[" "]" l else wrapL " " " " l

myLayoutPrinter :: String -> String
myLayoutPrinter "tall" = xmobarColor color04 "" "[]="
myLayoutPrinter "Full" = xmobarColor color04 "" "[M]"
myLayoutPrinter "Mirror tall" = xmobarColor color04 "" "TTT"
myLayoutPrinter "ThreeCol" = xmobarColor color04 "" "|||"
myLayoutPrinter "threeRow" = xmobarColor color04 "" "==="
myLayoutPrinter "Grid" = xmobarColor color04 "" "HHH"
myLayoutPrinter "monocle" = xmobarColor color02 "" "[M]"
myLayoutPrinter "spirals" = xmobarColor color02 "" "(@)"
myLayoutPrinter "Magnify" = xmobarColor color02 "" "|M|"
myLayoutPrinter "floats" = xmobarColor color01 "" "><>"
myLayoutPrinter "tabs" = xmobarColor color04 "" "[T]"
myLayoutPrinter x = xmobarColor "white" "" x

myPPLayout :: String -> String
myPPLayout x = case x of
  "tall" -> "[]="
  "Full" -> "[M]"
  "Mirror tall" -> "TTT"
  "ThreeCol" -> "|||"
  "threeRow" -> "==="
  "Grid" -> "HHH"
  "monocle" -> "[M]"
  "spirals" -> "(@)"
  "Magnify" -> "|M|"
  "floats" -> "><>"
  "tabs" -> "[T]"
  _ -> x
