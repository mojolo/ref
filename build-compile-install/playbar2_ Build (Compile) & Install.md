## Kubuntu dependencies

``` 
# apt install g++ libkf5plasma-dev plasma-workspace-dev libkf5declarative-dev libkf5globalaccel-dev libkf5configwidgets-dev libkf5xmlgui-dev libkf5windowsystem-dev libkf5doctools-dev cmake extra-cmake-modules gettext
```



## Build & Install

```
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release ..
make
sudo make install
```



## `qtquick` bug

```
I tried debugging it with plasmoidviewer from plasma-sdk and I found this error message on launch:
```

I tried debugging it with plasmoidviewer from plasma-sdk and I found this error message on launch:

```
file:///usr/share/plasma/plasmoids/audoban.applet.playbar/contents/ui/VerticalLayout.qml:49:9: "Connections.enabled" is not available in QtQuick 2.4.
```

Then I found this using that error message: https://phabricator.kde.org/D17184
 Basically, it was about that particular project getting the same error  and causing its main window not to appear (pretty much what my issue  was), and the solution was to upgrade the import line to `import QtQuick 2.7` (in the case of playbar2, its import line was `import QtQuick 2.4`).
 So yeah, did that, rebuilt, and tadaa, expanded view finally works and that error message never appeared again.

---



## [Fix `qtquick` #53](https://github.com/audoban/playbar2/pull/53)

> Open

###### *dkadioglu wants to merge 3 commits into [audoban:master](https://github.com/audoban/playbar2) from [dkadioglu:fix-qtquick](https://github.com/dkadioglu/PlayBar2/tree/fix-qtquick)*
Conversation 1 Commits 3 Checks 0
Files changed 25



###### *dkadioglu commented on Feb 14, 2019*
This fixes [#35](https://github.com/audoban/playbar2/issues/35) for me.

Fix was inspired by https://phabricator.kde.org/D14984
Until I had time to commit this, #52 contains partly the same fix.



###### *dkadioglu added 3 commits on Feb 14, 2019*

* raise QtQuick to 2.7 to fix empty widget with recent Plasma versions
* raise QtQuick to 2.7 to fix empty widget with recent Plasma versions
* Merge branch 'fix-qtquick' of https://github.com/dkadioglu/PlayBar2 i…



###### *Roboron3042 commented on Aug 22, 2019*

I tried this fix, but it didn't fix anything for me :/