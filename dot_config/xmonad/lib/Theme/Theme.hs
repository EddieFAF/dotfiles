{-# LANGUAGE ScopedTypeVariables #-}

{- |
   Module : Theme.Theme
   Copyright : (c) 2021 Joan Milev <joantmilev@gmail.com>
   License : MIT
   Maintainer : Joan Milev <joantmilev@gmail.com>
   Stability : Stable
   Portability : Unknown
-}

module Theme.Theme ( colorBack
                   , colorFore
                   , colorcr
                   , color00
                   , color08
                   , color01
                   , color09
                   , color02
                   , color0A
                   , color03
                   , color0B
                   , color04
                   , color0C
                   , color05
                   , color0D
                   , color06
                   , color0E
                   , color07
                   , color0F
                   , myFont
                   , myFontGTK
                   , myBigFont
                   , myBoldFont
                   , myItalicFont
                   ) where

import           Prelude          (String)
import           Theme.Xresources (xprop)

colorBack, colorFore, colorcr, color00, color08, color01, color09, color02, color0A, color03, color0B, color04, color0C, color05, color0D, color06, color0E, color07, color0F :: String
colorBack = xprop "*.background"
colorFore = xprop "*.foreground"
colorcr = xprop "*.cursorColor"
color00 = xprop "*.color0"
color08 = xprop "*.color8"
color01 = xprop "*.color1"
color09 = xprop "*.color9"
color02 = xprop "*.color2"
color0A = xprop "*.color10"
color03 = xprop "*.color3"
color0B = xprop "*.color11"
color04 = xprop "*.color4"
color0C = xprop "*.color12"
color05 = xprop "*.color5"
color0D = xprop "*.color13"
color06 = xprop "*.color6"
color0E = xprop "*.color14"
color07 = xprop "*.color7"
color0F = xprop "*.color15"

myFont, myFontGTK,myBigFont, myBoldFont, myItalicFont :: String
myFont = xprop "xmonad.font"
myFontGTK = xprop "xmonad.font.gtk"
myBigFont = xprop "xmonad.font.big"
myBoldFont = xprop "xmonad.font.bold"
myItalicFont = xprop "xmonad.font.italic"

