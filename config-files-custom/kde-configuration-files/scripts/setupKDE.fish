#! /usr/bin/env fish

# TODO - remove qdbus usage

#! /usr/bin/env nix-shell
#! nix-shell -i fish -p python39 python39Packages.dbus-python

# kwinrc
kwriteconfig5 --file $HOME/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
kwriteconfig5 --file $HOME/.config/kwinrc --group MouseBindings --key CommandAllKey Meta
kwriteconfig5 --file $HOME/.config/kwinrc --group MouseBindings --key CommandWindow1 "Activate, raise and pass click"
kwriteconfig5 --file $HOME/.config/kwinrc --group MouseBindings --key CommandWindow2 "Activate, raise and pass click"
kwriteconfig5 --file $HOME/.config/kwinrc --group MouseBindings --key CommandWindow3 "Activate, raise and pass click"
kwriteconfig5 --file $HOME/.config/kwinrc --group MouseBindings --key CommandWindowWheel "Scroll"
# disable stupid touch screen edges and weird corners and thir animations
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-Cube --key BorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-Cube --key BorderActivateCylinder "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-Cube --key BorderActivateSphere "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-Cube --key TouchBorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-Cube --key TouchBorderActivateCylinder "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-Cube --key TouchBorderActivateSphere "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-DesktopGrid --key BorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-DesktopGrid --key TouchBorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key BorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key BorderActivateAll "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key BorderActivateClass "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key TouchBorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key TouchBorderActivateAll "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key TouchBorderActivateClass "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group TabBox --key BorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group TabBox --key BorderAlternativeActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group TabBox --key TouchBorderActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group TabBox --key TouchBorderAlternativeActivate "9"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key Bottom "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key BottomLeft "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key BottomRight "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key Left "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key Right "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key Top "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key TopLeft "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group ElectricBorders --key TopRight "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group TouchEdges --key Bottom "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group TouchEdges --key Left "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group TouchEdges --key Right "None"
kwriteconfig5 --file $HOME/.config/kwinrc --group TouchEdges --key Top "None"
# set titlebar buttons
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key BorderSize "Normal"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "MF"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key CloseOnDoubleClickOnMenu "false"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ShowToolTips "false"
# a bit of sugar
kwriteconfig5 --file $HOME/.config/kwinrc  --group "Plugins"  --key "diminactiveEnabled" "true"
kwriteconfig5 --file $HOME/.config/kwinrc  --group "Plugins"  --key "fallapartEnabled" "true"
kwriteconfig5 --file $HOME/.config/kwinrc  --group "Plugins"  --key "kwin4_effect_dimscreenEnabled" "true"

# krunnerrc
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key CharacterRunnerEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key DictionaryEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key "Kill RunnerEnabled" "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key PowerDevilEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key "Spell CheckerEnabled" "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key baloosearchEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key bookmarksEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key browsertabsEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key calculatorEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key desktopsessionsEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key konsoleprofilesEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key krunner_appstreamEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key kwinEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key locationsEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key org.kde.activitiesEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key org.kde.datetimeEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key org.kde.windowedwidgetsEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key placesEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key plasma-desktopEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key recentdocumentsEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key servicesEnabled "true"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key shellEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key unitconverterEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key webshortcutsEnabled "false"
kwriteconfig5 --file $HOME/.config/krunnerrc --group Plugins --key windowsEnabled "false"

# font
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key XftAntialias "true"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key XftHintStyle ""
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key XftSubPixel "rgb"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key fixed "Monospace,9,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key font "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key menuFont "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key shadeSortColumn "true"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key smallestReadableFont "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"
kwriteconfig5 --file $HOME/.config/kdeglobals --group General --key toolBarFont "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"

# keybindings
./unbind-all-keyboard-shortcuts.fish
# Meta+Z for US, Meta+X for georgian, Meta+C for russian
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc  --group "KDE Keyboard Layout Switcher"  --key "Switch keyboard layout to English (US)" "Meta+Z,none,Switch keyboard layout to English (US)"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc  --group "KDE Keyboard Layout Switcher"  --key "Switch keyboard layout to Georgian" "Meta+X,none,Switch keyboard layout to Georgian"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc  --group "KDE Keyboard Layout Switcher"  --key "Switch keyboard layout to Russian (phonetic, Windows)" "Meta+C,none,Switch keyboard layout to Russian (phonetic\\, Windows)"
# klipper - unbind few keys and use alt + v for pop up
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "plasmashell" --key "clipboard_action" "none,Ctrl+Alt+X,Enable Clipboard Actions"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "plasmashell" --key "repeat_action" "none,Ctrl+Alt+R,Manually Invoke Action on Current Clipboard"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "plasmashell" --key "show-on-mouse-pos" "Alt+V,none,Open Klipper at Mouse Position"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "kmix" --key "decrease_microphone_volume" "Microphone Volume Down,Microphone Volume Down,Decrease Microphone Volume"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "kmix" --key "decrease_volume" "Volume Down,Volume Down,Decrease Volume"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "kmix" --key "increase_microphone_volume" "Microphone Volume Up,Microphone Volume Up,Increase Microphone Volume"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "kmix" --key "increase_volume" "Volume Up,Volume Up,Increase Volume"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "kmix" --key "mic_mute" "Microphone Mute\tMeta+Volume Mute,Microphone Mute\tMeta+Volume Mute,Mute Microphone"
kwriteconfig5 --file $HOME/.config/kglobalshortcutsrc --group "kmix" --key "mute" "Volume Mute,Volume Mute,Mute"

# keyboard settings
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key KeyboardRepeating "0"
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key NumLock "2"
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key RepeatDelay "300"
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key RepeatRate "40"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "DisplayNames" ",,"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "LayoutList" "us,ge,ru(phonetic_winkeys)"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "LayoutLoopCount" " -1"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "Model" "pc86"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "Options" "grp_led:caps"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "ResetOldOptions" "true"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "ShowFlag" "false"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "ShowLabel" "true"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "ShowLayoutIndicator" "true"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "ShowSingle" "false"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "SwitchMode" "WinClass"
kwriteconfig5 --file $HOME/.config/kxkbrc  --group "Layout"  --key "Use" "true"

# background services
kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-appmenu"  --key "autoload" "false"
kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-baloosearchmodule"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-bluedevil"  --key "autoload" "true"
kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-browserintegrationreminder"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-colorcorrectlocationupdater"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-device_automounter"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-freespacenotifier"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-gtkconfig"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-kded_accounts"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-keyboard"  --key "autoload" "true"
kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-khotkeys"  --key "autoload" "false" #sxhkd FTW!!!
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-ksysguard"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-ktimezoned"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-kwrited"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-networkmanagement"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-networkstatus"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-proxyscout"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-remotenotifier"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-smbwatcher"  --key "autoload" "false"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-statusnotifierwatcher"  --key "autoload" "true"
# kwriteconfig5 --file $HOME/.config/kded5rc  --group "Module-touchpad"  --key "autoload" "false"

# disable annoying notification when changing volume
kwriteconfig5 --file $HOME/.config/plasmarc --group OSD --key Enabled "false"
# kwriteconfig cannot write -1 :( 
# i found the way, needs an empty space...
kwriteconfig5 --file $HOME/.config/plasmarc --group PlasmaToolTips --key Delay " -1"

# do not restore desktop session
kwriteconfig5 --file $HOME/.config/ksmserverrc --group General --key loginMode "default"

# disable file somthing...
kwriteconfig5 --file $HOME/.config/baloofilerc --group "Basic Settings" --key Indexing-Enabled "false"

# touchpad
kwriteconfig5 --file $HOME/.config/touchpadxlibinputrc --group "SynPS/2 Synaptics TouchPad" --key tapToClick "true"

# powermanagement
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key lidAction 32
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key powerButtonAction 1
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key triggerLidActionWhenExternalMonitorPresent false
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key lidAction 32
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key powerButtonAction 1
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key triggerLidActionWhenExternalMonitorPresent false
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key lidAction 32
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key powerButtonAction 1
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key triggerLidActionWhenExternalMonitorPresent false
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group AC --group SuspendSession  --key idleTime 1200000
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group AC --group SuspendSession  --key suspendThenHibernate false
kwriteconfig5 --file $HOME/.config/powermanagementprofilesrc --group AC --group SuspendSession  --key suspendType 1

# hide files and folders on desktop
# TODO fix this
# sed -i 's/plugin=org.kde.plasma.folder/plugin=org.kde.desktopcontainment/g' $HOME/.config/plasma-org.kde.plasma.desktop-appletsrc

# disable kwallet
kwriteconfig5 --file $HOME/.config/kwalletrc --group "Wallet" --key "Enabled" "false"

# theme settings - disable title bar for all windows but keep borders
kwriteconfig5 --file $HOME/.config/breezerc --group "Common" --key "OutlineCloseButton" "false"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco" --key "DrawBackgroundGradient" "false"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco Exception 0" --key "BorderSize" "3"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco Exception 0" --key "Enabled" "true"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco Exception 0" --key "ExceptionPattern" ".*"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco Exception 0" --key "ExceptionType" "0"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco Exception 0" --key "HideTitleBar" "true"
kwriteconfig5 --file $HOME/.config/breezerc --group "Windeco Exception 0" --key "Mask" "16"

# change panel height
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "panels()[0].height = 30"

# eenable user feedback because why not
kwriteconfig5 --file $HOME/.config/PlasmaUserFeedback --group "Global" --key "FeedbackLevel" "64"

# panel settings

# disable burp sound when changing volume
./plasmasetconfig.py org.kde.plasma.volume General volumeFeedback false
# clock
./plasmasetconfig.py org.kde.plasma.digitalclock Appearance showDate false
./plasmasetconfig.py org.kde.plasma.digitalclock Appearance use24hFormat 2

# task manager stuff
./plasmasetconfig.py org.kde.plasma.taskmanager General groupedTaskVisualization 3 # show list of windows when clicking groups
./plasmasetconfig.py org.kde.plasma.taskmanager General middleClickAction Close
./plasmasetconfig.py org.kde.plasma.taskmanager General separateLaunchers false
./plasmasetconfig.py org.kde.plasma.taskmanager General wheelEnabled false

# lock screen wallpaper
set lock_screen_wallpaper (xdg-user-dir PICTURES)/lock-screen-wallpaper.jpg
if test -e $lock_screen_wallpaper
    kwriteconfig5 --file $HOME/.config/kscreenlockerrc --group "Greeter" --group "Wallpaper" --group "org.kde.image" --group "General" --key "Image" "file://$lock_screen_wallpaper"
end
