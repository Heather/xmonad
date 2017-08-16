{-# LANGUAGE UnicodeSyntax #-}

module Ether.Keys
  ( myKeyBindings
  , (<~|)
  ) where

import XMonad
import XMonad.Util.EZConfig (additionalKeys)

infixl 2 <~|

(<~|) ∷ XConfig α → [((ButtonMask, KeySym), X ())] → XConfig α
f <~| a = additionalKeys f a

myKeyBindings ∷ [((ButtonMask, KeySym), X ())]
myKeyBindings =
  [(( mod4Mask .|. shiftMask, xK_F4), spawn "sudo shutdown -h now")--win+Shift+F4
  ,(( mod4Mask, xK_j ), sendMessage Expand) -- win + L is logout for windows

  ,((mod4Mask, xK_F1 ), spawn "gnome-terminal")
  ,((mod4Mask, xK_F2 ), spawn "deadbeef")
  ,((mod4Mask, xK_F4 ), spawn "chromium")
  ,((mod4Mask, xK_F5 ), spawn "qtcreator")
  ,((mod4Mask, xK_F6 ), spawn "atom")

  ,((mod4Mask, xK_F9 ), spawn "pidgin")
  ,((mod4Mask, xK_F10 ),spawn "steam")

  ,((0, xK_Print), spawn "scrot")
  ]
