{-|        Light Gnomish Xmonad config
         Copyright (C)  2012-2014 Heather
--}

import XMonad
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.SetWMName

import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO

nWorkspaces = ["1","2","3","4","5","6","7","8","9:Trash"]
nManageHook = composeAll . concat $
              [[ className =? "Anjuta" --> doShift "4:dev"]
              ,[ className =? "Monodevelop" --> doShift "5:dev"]
              ,[ className =? "Steam" --> doShift "2:user"]
              ,[ className =? c --> doIgnore | c <- ignore ]
              ,[ className =? c --> doFloat | c <- floats ]
              ,[ className =? c --> doShift "8:irc" | c <- irc ]
              ,[ className =? c --> doShift "9:web" | c <- web ]
              ,[ isFullscreen --> doFullFloat ]
              ] where ignore = ["panel", "Trayer", "trayer"]
                      floats = ["Xmessage", "Steam"]
                      irc = ["Pidgin"]
                      web = ["Firefox"]

startup :: X()
startup = do
    spawn "xsetroot -cursor_name left_ptr"
    spawn "gnome-terminal"

layout = Full ||| tiled ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaultConfig {
    modMask = mod4Mask
    ,terminal = "xterm"
    ,borderWidth = 1
    ,normalBorderColor = "#fbc1f3"
    ,focusedBorderColor = "#000000"
    ,workspaces = nWorkspaces
    ,manageHook = nManageHook <+> manageHook defaultConfig
    ,layoutHook = avoidStruts  $  layout
    ,startupHook = startup
    ,logHook = dynamicLogWithPP xmobarPP {
                        	ppOutput 	= hPutStrLn xmproc
                        , 	ppTitle 	= xmobarColor "green" "" . shorten 50
                        }
    } `additionalKeys`  
      [(( mod4Mask .|. shiftMask, xK_F4), spawn "sudo shutdown -h now")--win+Shift+F4
      ,(( mod4Mask, xK_j ), sendMessage Expand) -- win + L is logout for windows

      ,((mod4Mask, xK_F1 ), spawn "gnome-terminal")
      ,((mod4Mask, xK_F4 ), spawn "firefox-bin")

      ,((mod4Mask, xK_F5 ), spawn "anjuta")
      ,((mod4Mask, xK_F6 ), spawn "monodevelop")

      ,((mod4Mask, xK_F9 ), spawn "pidgin")
      ,((mod4Mask, xK_F10 ),spawn "steam")

      ,((0, xK_Print), spawn "scrot")
      ]
