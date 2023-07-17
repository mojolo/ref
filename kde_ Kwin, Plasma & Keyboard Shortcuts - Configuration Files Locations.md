## [List of configuration files for KDE apps (Kate). Can I Sync the settings automatically?](https://www.reddit.com/r/kde/comments/b2n2at/list_of_configuration_files_for_kde_apps_kate_can/)

```
.config/dolphinrc
.config/katerc
.config/katemetainfos
.config/konsolerc
.config/okularrc
.config/QtProject.conf
.config/okularpartrc
.config/komparerc
.config/kdeglobals
.config/katepartrc
.config/kateschemarc
.config/katesyntaxhighlightingrc
.config/katemoderc

.local/share/kate/
.local/share/katepart/
.local/share/katekonsole/
.local/share/org.kde.syntax-highlighting/
.local/share/ktexteditor_snippets/
.local/share/dolphin/
.local/share/kxmlgui5/

.kde/share/ #??
```



## [How can I make my KDE config(s) portable?](https://www.reddit.com/r/kde/comments/654dwo/how_can_i_make_my_kde_configs_portable/)

I manage my dotfiles using [Homeshick](https://github.com/andsens/homeshick) and I was wondering what dotfiles or directories I should backup in order to make my KDE config work across systems.

If there are more things than directories and dotfiles, what are they and what do they do?

---

Most of the stuff is stored in `~/.local/share or ~/.config` (or `$XDG_DATA_HOME` and `$XDG_CONFIG_HOME`), it's a starting point.

Settings for different parts of KDE are stored in different locations, for  example Plasma desktop settings (wallpaper, panels locations, widgets  etc) are stored in `~/.config/plasmashellrc` (which changes often and  contains "pointless" info like sizes and positions for widget settings  dialogs which would be annoying to keep track of in VCS)

Keep in mind that you'll probably end up adding widgets downloaded trough  "Get Hot New Stuff", or somehow synchronizing them between machines,  same goes for wallpapers.

P.S. some really outdated stuff may still be present in `~/.kde`

---

Thanks, for now I have saved the following files in my VCS:

```
└── home
.config
├── breezerc
├── kaccessrc
├── kactivitymanagerd-pluginsrc
├── kactivitymanagerdrc
├── kactivitymanagerd-switcher
├── kateschemarc
├── kcmdisplayrc
├── kcminputrc
├── kconf_updaterc
├── kdebugrc
├── kded_device_automounterrc
├── kdeglobals
├── kgammarc
├── kglobalshortcutsrc
├── khotkeysrc
├── kiorc
├── klaunchrc
├── kmenueditrc
├── kmixrc
├── knotifyrc
├── konsolerc
├── krunnerrc
├── kscreenlockerrc
├── kservicemenurc
├── ksmserverrc
├── ksplashrc
├── ktimezonedrc
├── kwinrc
├── kwinrulesrc
├── plasma-localerc
├── plasma-locale-settings.sh
├── plasma-org.kde.plasma.desktop-appletsrc
├── plasmarc
├── plasmashellrc
├── startupconfig
├── startupconfigfiles
├── startupconfigkeys
└── systemsettingsrc
.kde
└── share
    └── config
        ├── kcminputrc
        └── kdeglobals
.local
└── share
    └── kactivitymanagerd
        └── resources
            ├── database
            ├── database-shm
            └── database-wal

7 directories, 46 files
```



## [Where is the configuration file to store keyboard shortcuts?](https://forum.kde.org/viewtopic.php?f=17&t=151477&sid=183f44e268ceaaa7e74545ac649a45f7)

I am going to write the following three things:

* The locations  of the preference files to store the keyboard shortcuts of `KDE Plasma 5` and of some of its associated applications
* How to find these preference files
* How to back up and restore them 


The following files store the keyboard shortcuts of `KDE Plasma 5` and of  some of its associated applications such as `Konsole` and `KWrite`.

```
~/.config/kdeglobals
~/.config/kglobalshortcutsrc
~/.config/khotkeysrc
~/.config/kwinrc
~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/.local/share/kxmlgui5/katepart/katepart5ui.rc
~/.local/share/kxmlgui5/konsole/konsoleui.rc
~/.local/share/kxmlgui5/konsole/sessionui.rc
~/.local/share/kxmlgui5/kwrite/kwriteui.rc
```



#### Let me add descriptions for the files.

* Standard Shortcuts (System Settings > Shortcuts)
  `~/.config/kdeglobals`

* Global Shortcuts (System Settings > Shortcuts)
  `~/.config/kglobalshortcutsrc`

* "Custom Shortcuts" (System Settings > Shortcuts)
  `~/.config/khotkeysrc`

* Konsole
  `~/.local/share/kxmlgui5/konsole/konsoleui.rc`
  `~/.local/share/kxmlgui5/konsole/sessionui.rc`

* KWrite > Settings > Configure Shortcuts... > KWrite
  `~/.local/share/kxmlgui5/kwrite/kwriteui.rc`

* KWrite > Settings > Configure Shortcuts... > Kate Part
  `~/.local/share/kxmlgui5/katepart/katepart5ui.rc`



Among "Global Shortcuts", "Plasma > Activate Application Launcher Widget" is also stored in

​	`~/.config/plasma-org.kde.plasma.desktop-appletsrc`

in addition to the common

​	`~/.config/kglobalshortcutsrc`

This is because `Activate Application Launcher Widget` can be also set by
Right-click `Application Launcher` > `Application Launcher Settings...` > `Keyboard Shortcuts`



The dissociation of `Meta` key (a.k.a. `Windows Key` or `Apple Command Key`) from the `Kickoff Application Launcher` (a.k.a. `Start Menu`) is stored in

​	`~/.config/kwinrc`

I dissociated the `Meta` key from the `Application Launcher` by the command:

​	`kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""`


This command adds the following two lines into `~/.config/kwinrc`.

​	`[ModifierOnlyShortcuts]Meta=`



Except `kglobalshortcutsrc` and `khotkeysrc`, these files store only custom  shortcuts but not default shortcuts, but also store other kinds of  preferences. `kglobalshortcutsrc` stores both custom and default  shortcuts, but does not store other kinds of preferences.  `khotkeysrc`  seems similar to `kglobalshortcutsrc`.



#### How to Find the Preference Files of Keyboard Shortcuts

First, add some custom shortcuts whose modifier key is `Meta` or `Control`, say  `Meta+C` or `Ctrl+Tab`, to `System Settings` > `Shortcuts` > `Standard Shortcuts` and `System Settings` > `Shortcuts` > `Global Shortcuts`  and to `Configure Shortcuts` of individual applications.

Then, by the following command, conduct a content search to look for files that contain the keyword `Meta+`, `Ctrl+` or `Meta=`, searching in the home  directory `~`.

```
cd; find . -type f -print0 | xargs -0 grep -El '(Meta\+|Ctrl\+|Meta=)' | perl -pe 's|^\.|~|' | sort
```


The resultant files are good candidates for the files storing keyboard  shortcuts.  Examine each file to see whether it actually stores keyboard shortcuts.


I thank TKL-Ansi for `~/.local/share/kxmlgui5`, which is the directory enclosing the files that store the custom  keyboard shortcuts of individual applications. I found the other files  on my own.



#### Back Up and Restore the Keyboard Shortcuts

Generally, the `System Settings` does not provide GUI methods to export or import  settings.  Under `System Settings` > `Shortcuts`, only when `Global  Shortcuts` is selected, the File popup menu emerges near the lower right corner of this System Settings window, and provides the `Import  Scheme...` and `Export Scheme...` menu items.  This File popup menu  disappears when `Standard Shortcuts` or `Custom Shortcuts` is selected.

I need to back up not only Global Shortcuts but also other shortcuts. The following command backs up the nine preference files containing  keyboard shortcuts into the archive file `KeyboardShortcut.tar.gz`.

```
cd ~; tar -czf KeyboardShortcut.tar.gz  .{config/{kdeglobals,kglobalshortcutsrc,khotkeysrc,plasma-org.kde.plasma.desktop-appletsrc,kwinrc},local/share/kxmlgui5/{katepart/katepart5,konsole/{konsole,session},kwrite/kwrite}ui.rc}
```

Note that, as stated above, these preference files (except  `kglobalshortcutsrc` and `khotkeysrc`) contain not only keyboard  shortcuts but also other kinds of preferences.  Therefore, when these  preference files are restored, not only keyboard shortcuts but also  other kinds of preferences will be restored, overwriting the existing  ones, which may or may not what you want.  (I am thinking about writing  commands to back up and restore only keyboard shortcuts without  interfering with other kinds of preferences; but not now.)

To restore these preference files, do the following command with the  current directory being your home directory, preferably in the rescue  mode (recovery mode).

```
tar -xf KeyboardShortcut.tar.gz -C .
```

The reason that this restoration should be done in the rescue mode follows.  For each preference file, Plasma and other applications likely keep an extra copy in the memory besides the one on the disk.  When they quit,  they may possibly update the preference files by overwriting those on  the disk with those in the memory.  Therefore, if the preference files  are restored from `KeyboardShortcut.tar.gz` to the disk while Plasma and  other applications are running, the restored copies may be overwritten  and destroyed when they quit.

Therefore, it is better to restore them while `Plasma` and other applications are not running.  To do so,  restore them in the recovery mode (rescue mode).  Thus, enter the  recovery mode from the `GRUB` menu when the computer starts up, and log in as `root`.  Note that, normally, the tilde (`~`) indicates your home  directory; however, while logged in as root, `~` means `/root`.  Hence,  you need to `cd` to your own home directory first.  Then, execute

```
tar -xf KeyboardShortcut.tar.gz -C .
```

To get out of the rescue mode, execute

```
exit
```

These commands here are expected to run on bash.
KDE Plasma 5
Debian 9.4 					