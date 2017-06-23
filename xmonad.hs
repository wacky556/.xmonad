import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Minimize
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import Graphics.X11.ExtraTypes.XF86
import System.IO
main = do
	xmproc <- spawnPipe "/usr/bin/xmobar /home/william/.xmobarrc"
	xmonad $ defaultConfig {
		terminal = "gnome-terminal"
		, manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
       		, layoutHook = avoidStruts $  layoutHook defaultConfig
		, handleEventHook =  handleEventHook defaultConfig <+> docksEventHook
		, logHook = dynamicLogWithPP xmobarPP
			{ ppOutput = hPutStrLn xmproc
			, ppTitle = xmobarColor "green" "" . shorten 50
			}
		, startupHook = setWMName "LG3D"
		, modMask = mod4Mask
        	} `additionalKeys`
		[ 
			((0 , xF86XK_AudioLowerVolume), spawn "amixer set Master on && amixer set Speaker on && amixer set 'Bass Speaker' on   && amixer set Master 2-"), 
      			((0 , xF86XK_AudioRaiseVolume), spawn "amixer set Master on  && amixer set Speaker on && amixer set 'Bass Speaker' on && amixer set Master 2+"),
      			((0 , xF86XK_AudioMute), spawn "amixer set Master toggle &&  amixer set Speaker on && amixer set 'Bass Speaker' on && amixer set Headphone toggle") 
		]







myManageHook = composeAll
	[
	isFullscreen-->doFullFloat
	, (role =? "gimp-toolbox" <||> role =? "gimp-image-window")-->(ask >>= doF . W.sink)
	, resource =? "stalonetray" --> doIgnore
	]
	where role = stringProperty "WM_WINDOW_ROLE"
