{-|           Light Xmonad config
         Copyright (C)  2012-2016 Heather
--}

import XMonad
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.SetWMName

import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO

import Ether.Keys

nWorkspaces = ["1","2","3","4","5","6","7","8","9:Trash"]

startup :: X()
startup = do
    spawn "xsetroot -cursor_name left_ptr"
    spawn "konsole"

layout = Full ||| tiled ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaultConfig {
    modMask = mod4Mask -- controlMask -- .|. 
    ,terminal = "xterm"
    ,borderWidth = 1
    ,normalBorderColor = "#fbc1f3"
    ,focusedBorderColor = "#000000"
    ,workspaces = nWorkspaces
    ,layoutHook = avoidStruts  $  layout
    ,startupHook = startup
    ,logHook = dynamicLogWithPP xmobarPP {
                        	ppOutput 	= hPutStrLn xmproc
                        , 	ppTitle 	= xmobarColor "green" "" . shorten 50
                        }
    } `additionalKeys` myKeyBindings
