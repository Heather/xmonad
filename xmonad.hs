import XMonad
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.SetWMName

import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO

nWorkspaces = ["1:root","2:user","3","4:dev","5:dev","6","7","8:irc","9:web"]
nManageHook = composeAll . concat $
              [[ className =? "CMake,KDevelop" --> doShift "4:dev", isFullscreen --> doFullFloat]
              ,[ className =? c --> doFloat | c <- floats ]
              ,[ className =? c --> doShift "7" | c <- trash ]
              ,[ className =? c --> doShift "8:irc" | c <- irc ]
              ,[ className =? c --> doShift "9:web" | c <- web ]
              ] where floats = ["CMake"]
                      trash = [""]
                      irc = ["Quassel"]
                      web = ["google-chrome"]

startup :: X()
startup = do
        -- spawn "konsole"
        spawn "xsetroot -cursor_name left_ptr"

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/nen/.xmonad/xmobar.hs"
  xmonad $ defaultConfig {
    modMask = mod4Mask
    ,terminal = "xterm"
    ,borderWidth = 1
    ,normalBorderColor = "#fbc1f3"
    ,focusedBorderColor = "#000000"
    ,workspaces = nWorkspaces
    ,manageHook = nManageHook <+> manageHook defaultConfig
    ,layoutHook = avoidStruts  $  layoutHook defaultConfig
    ,startupHook = startup
    ,logHook = dynamicLogWithPP xmobarPP {
                        ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
    } `additionalKeys`  
      [(( mod4Mask .|. shiftMask, xK_F4), spawn "sudo shutdown -h now")--win+Shift+F4
      ,(( mod4Mask, xK_j ), sendMessage Expand) -- win + L is logout for windows
      ,((mod4Mask, xK_F1 ), spawn "konsole")
      ,((mod4Mask, xK_F4 ), spawn "google-chrome")
      ,((mod4Mask, xK_F5 ), spawn "kdevelop")
      ,((mod4Mask, xK_F9 ), spawn "quasselclient")
      ,((mod4Mask, xK_F10 ),spawn "steam")
      ,((0, xK_Print), spawn "scrot")
      ]
