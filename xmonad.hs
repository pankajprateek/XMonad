--
-- xmonad example config file for xmonad-0.9
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- NOTE: Those updating from earlier xmonad versions, who use
-- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- setup functions (dzen, xmobar) probably need to change
-- xmonad.hs, please see the notes below, or the following
-- link for more details:
--
-- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
--
 
import XMonad
import Data.Monoid
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.ResizableTile
import Data.Ratio ((%))  
import XMonad.Actions.CycleWS  
import Control.Monad (liftM2)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.SwapWorkspaces
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName    -- Sun Java Hack!
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.CenteredMaster
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)

import System.IO
import System.Exit
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvtc"
-- myTerminal      = "xterm"
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
-- myFocusFollowsMouse = False
 
-- Width of the window border in pixels.
--
myBorderWidth   = 1
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
 
-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------
 
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--

-- Define layout for specific workspaces  
nobordersLayout = smartBorders $ Full
-- nobordersLayout = noBorders $ Full  
gridLayout = spacing 8 $ Grid
pidginLayout = withIM (18/100) (Role "buddy_list") gridLayout
-- gimpLayout = withIM (0.20) (Role "gimp-toolbox") $ withIM (0.20) (Role "gimp-dock") Full 
   
-- Put all layouts together  
-- myLayout = onWorkspace "2:web" nobordersLayout $ defaultLayouts 

-- myLayout = onWorkspace "3:work" layout2 $ defaultLayouts

-- myLayout = onWorkspace "4:read" layoutCenter $ onWorkspace "7" pidginLayout $ layout1
-- myLayout = onWorkspace "4:read" layoutCenter $ onWorkspace "9" pidginLayout $ layout1
-- myLayout = onWorkspace "7" gimpLayout $ onWorkspace "8:IM" pidginLayout $ layout1
-- myLayout = onWorkspace "8:IM" pidginLayout $ layout1
myLayout = layout1

tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

myWorkspaces = ["1:main","2:web","3:code","4:file","5:read","6","7","8:media","9:float","0:misc","-"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
-- myFocusedBorderColor = "#68e862"
myFocusedBorderColor = "#60A1AD"
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
-- xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm, xK_t), spawn $ XMonad.terminal conf)
    
    -- lock screen
    , ((modm, xK_l), spawn "i3lock -d -I 10 -t -e -i ~/joker.png")

    , ((modm .|. controlMask, xK_x), runOrRaisePrompt defaultXPConfig)

    -- launch firefox
    , ((modm, xK_f), spawn "firefox")

    -- launch files
    , ((modm, xK_a), spawn "files")
    
    -- send shutdown signal
    , ((modm .|. shiftMask, xK_s), spawn "sudo shutdown -h now")

    -- send hibernate signal
    , ((modm .|. shiftMask, xK_h), spawn "sudo pm-hibernate")

    -- send reboot signal
    , ((modm .|. shiftMask, xK_r), spawn "sudo reboot")
    
    -- launch file manager
    , ((modm .|. shiftMask, xK_r), spawn "urxvtc -e ranger")
    , ((modm, xK_r), spawn "thunar")

    , ((modm, xK_h), spawn "urxvtc -e htop")

    -- launch emacs
    , ((modm, xK_e), spawn "emacsclient -c")
    , ((modm .|. shiftMask, xK_e), spawn "urxvtc -e 'emacsclient -nwc'")

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu_run -nb black -nf white -sf red` && eval \"exec $exe\"")
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- Increase Volume
    , ((0   , xF86XK_AudioRaiseVolume  ), spawn "amixer set Master 4+ && amixer -D pulse sset Master 4%+")
    , ((modm   , xK_Up  ), spawn "amixer set Master 4+ && amixer -D pulse sset Master 4%+")
    
    -- Decrease Volume
    , ((0   , xF86XK_AudioLowerVolume  ), spawn "amixer set Master 4- && amixer -D pulse sset Master 4%-")
    , ((modm   , xK_Down  ), spawn "amixer set Master 4- && amixer -D pulse sset Master 4%-")

    -- Mute
    -- , ((0   , xF86XK_AudioMute  ), spawn "amixer set Master 0")
    , ((0   , xF86XK_AudioMute  ), spawn "amixer -D pulse sset Master toggle")
    
    -- Toggle Play
    , ((0   , xF86XK_AudioPlay  ), spawn "mpc toggle")
    
    -- Next
    , ((0   , xF86XK_AudioNext  ), spawn "mpc next")

    -- Previous
    , ((0   , xF86XK_AudioPrev  ), spawn "mpc prev")

    , ((0   , 0xff14  ), spawn "mpc toggle")                                                                                     
    , ((0   , 0xff13  ), spawn "mpc next")                                                                                       
    , ((0   , 0xff61  ), spawn "mpc prev") 

    -- Sleep
    , ((0   , xF86XK_Sleep  ), spawn "sudo pm-suspend")
 
    -- close focused window
    , ((modm, xK_F4), kill)
    , ((modm, xK_c), kill)
    , ((mod1Mask, xK_F4), kill)
 
    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    
    -- Rotate through the available layout algorithms
    -- , ((modm .|. shiftMask,   xK_space ), sendMessage PreviousLayout)  
    -- Not working currently, define Previous Layout module and see to it someday
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. controlMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Minimize focused window
    , ((modm,               xK_m     ), withFocused minimizeWindow)
    -- Restore next minimized window
    , ((modm .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    -- , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_Left     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_Right     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm .|. shiftMask, xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Change screen orientations
    , ((modm .|. controlMask, xK_Right     ), spawn "xrandr -o right && feh --bg-scale /home/pankaj/scripts/wallpaper/wallpaper.jpg && killall trayer && trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 10% --tint 0x000000 --transparent true --alpha 0 --height 14")
    , ((modm .|. controlMask, xK_Left     ), spawn "xrandr -o left  && feh --bg-scale /home/pankaj/scripts/wallpaper/wallpaper.jpg && killall trayer && trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 10% --tint 0x000000 --transparent true --alpha 0 --height 14")
    , ((modm .|. controlMask, xK_Up     ), spawn "xrandr -o normal  && feh --bg-scale /home/pankaj/scripts/wallpaper/wallpaper.jpg && killall trayer && trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 10% --tint 0x000000 --transparent true --alpha 0 --height 14 &")
    , ((modm .|. controlMask, xK_Down     ), spawn "xrandr -o inverted && feh --bg-scale /home/pankaj/scripts/wallpaper/wallpaper.jpg && killall trayer && trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 10% --tint 0x000000 --transparent true --alpha 0 --height 14")

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0] ++ [0x2d])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{y,u,i}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{y,u,i}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_y, xK_u, xK_i] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    [((modm .|. controlMask, k), windows $ swapWithCurrent i)
        | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]]
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- Set the window to floating mode and resize by dragging
    , ((modm .|. shiftMask, button1), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
defaultLayouts = tiled ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   =  Tall nmaster delta ratio
 
    -- The default number of windows in the master pane
    nmaster = 1
 
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
 
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

layout2 = tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   =  Tall nmaster delta ratio
 
    -- The default number of windows in the master pane
    nmaster = 2
 
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
 
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

layout1 = minimize fullscreen ||| maximize (ResizableTall 1 (3 / 100) (1 / 2) []) ||| tiled ||| Mirror tiled ||| tab
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   =  Tall nmaster delta ratio
 
    -- The default number of windows in the master pane
    nmaster = 1
 
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
 
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    -- tabbed config
    tab = tabbed shrinkText tabConfig
    
    -- fulscreen config
    fullscreen = noBorders (fullscreenFull Full)

layoutC = fullscreen
  where 
    -- fulscreen config
    fullscreen = noBorders (fullscreenFull Full)

layoutCenter = centerMaster layoutC
	
--    Tall 1 (3/100) (1/2) |||
--    Mirror (Tall 1 (3/100) (1/2)) |||
--    tabbed shrinkText tabConfig |||
--    Full |||
--    spiral (6/7)) |||
--    noBorders (fullscreenFull Full)

 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"			--> doFloat
    , className =? "Tk"				--> doFloat
    , className =? "Pidgin"			--> doShift "7"
--    , className =? "Gimp"           		--> doShift "7"
    , resource  =? "desktop_window" 		--> doIgnore
    , resource  =? "kdesktop"       		--> doIgnore 
    , className =? "Firefox"        		--> viewShift "2:web"
    , className =? "Google-chrome-stable"        		--> viewShift "2:web"
--    , className =? "Thunderbird"    		--> doShift "4:read"
    , className =? "Vlc"            		--> viewShift "8:media"
    , className =? "File Operation Progress"   --> doFloat  
    , className =? "Emacs" 	   	       --> viewShift "3:code"
--    , className =? "URxvt" 	       --> doFloat
    , className =? "xpad"		       --> doFloat
    , className =? "xpad"		       --> doShift "9"
    , className =? "net-sourceforge-jnlp-runtime-Boot"  --> doFloat
    , className =? "Nautilus"		       --> viewShift "4:file"
    , className =? "Thunar"		       --> viewShift "4:file"
    , className =? "ranger"		       --> viewShift "4:file"
    , className =? "Transmission"		       --> viewShift "-"
    , className =? "Evince"		       --> viewShift "5:read"
    , className =? "Evince"		       --> doFloat
    , className =? "Spotify"		       --> viewShift "0:misc"
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift
 
------------------------------------------------------------------------
-- Event handling
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = mempty
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = return ()
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook :: X()
myStartupHook = do
  -- spawn editor
  -- spawn browser
  spawn editor
  spawn browser
  -- spawn music
  where
    editor = "emacsclient -c"
    browser = "firefox"
    -- music = "urxvtc -e ncmpcpp"

-- myStartupHook = return ()
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults
-- main = xmonad defaults

-- trying 2 xmobars, not working, dunno why
-- lookup someday
-- main = do
--   xmobarBottom <- spawnPipe "xmobar"
--   xmobarTop <- spawn "xmobar ~/.xmobarrc.up"
--   xmonad $ withUrgencyHook NoUrgencyHook $ defaults

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]"
       		 -- ppOutput = hPutStrLn xmproc  
		, ppTitle = const "" -- xmobarColor "#2CE3FF" "" . shorten 50
                , ppLayout = const "" -- to disable the layout info on xmobar  
                -- , ppOutput = hPutStrLn xmobarBottom
       		 }
                             -- { ppCurrent         = xmobarColor myYellow      "" 
                             -- , ppHiddenNoWindows = xmobarColor myDarkGrey    "" 
                             -- , ppHidden          = xmobarColor myLightGrey   ""
                             -- , ppUrgent          = xmobarColor myRed         "" 
                             -- , ppSep             = "  |  "
                             -- , ppWsSep           = " " 
                             -- , ppTitle           = xmobarColor myYellow      "" 
                             -- , ppOutput          = hPutStrLn xmobarTop             -- Only the xmobar on top should receive information from xmonad
                             -- }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
        layoutHook         = myLayout,
       --  manageHook         = myManageHook,
        manageHook         = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
	                        <+> manageHook defaultConfig,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
