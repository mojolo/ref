## Prebuilt Binaries

- Ubuntu: You can install via a PPA on Ubuntu 18.04 (Bionic) or later including KDE Neon.

```
# add-apt-repository ppa:krisives/applet-window-buttons
# apt install applet-window-buttons
```



## Dependencies

```
# apt install libkdecorations2-dev qtquickcontrols2-5-dev libkf5coreaddons-dev libkf5coreaddons-dev-bin qml-module-org-kde-kcoreaddons libkf5declarative-dev qtdeclarative5-dev qtdeclarative5-dev-tools libkf5plasma-dev libkf5plasmaquick5 extra-cmake-modules g++ qtbase5-dev gettext
```

 

## Requires

    Qt >= 5.9
    KF5 >= 5.38
    Plasma >= 5.12
    KDecoration2 >= 5.12

Qt elements: Gui Qml Quick

KF5 elements: CoreAddons Declarative Plasma PlasmaQuick extra-cmake-modules



## Install

```
$ git clone https://github.com/psifidotos/applet-window-buttons.git
$ cd applet-window-buttons
$ ./install.sh
```

You can execute sh install.sh in the root directory as long as you have installed the previous mentioned development packages. For more details please read INSTALLATION.md