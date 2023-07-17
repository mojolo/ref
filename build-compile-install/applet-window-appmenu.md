## Dependencies

```
# apt install cmake extra-cmake-modules g++ libkdecorations2-dev qtquickcontrols2-5-dev libkf5coreaddons-dev libkf5coreaddons-dev-bin qml-module-org-kde-kcoreaddons libkf5declarative-dev qtdeclarative5-dev qtdeclarative5-dev-tools libkf5plasma-dev libkf5plasmaquick5 extra-cmake-modules g++ qtbase5-dev gettext libqt5widgets5 libqt5x11extras5-dev libsm-dev libkf5configwidgets-dev libkf5windowsystem-dev libx11-xcb-dev libxcb1-dev libxcb-randr0-dev libxrandr-dev libkf5wayland-dev
```



## Requires

- Qt >= 5.9
- KF5 >= 5.38
- Plasma >= 5.12

**Qt elements**: Quick Widgets DBus

**KF5 elements**: Plasma WindowSystem KDecoration2 extra-cmake-modules

**X11 libraries**: XCB RandR



## Install

```
$ git clone https://github.com/psifidotos/applet-window-appmenu.git
$ cd applet-window-appmenu
$ ./install.sh
```

You can execute `sh install.sh` in the root directory as long as you have installed the previous mentioned development packages.