## Dependencies

```
qtbase5-dev qtbase5-dev-tools qtwebengine5-dev qtwebengine5-dev-tools qml-module-qtwebengine libqt5webengine-data libqt5webengine5 libqt5webenginecore5 libqt5webenginewidgets5 libqt5webchannel5 libqt5webchannel5-dev qml-module-qtwebchannel libqt5svg5 libqt5svg5-dev libqt5location5 libqt5location5-plugins qtlocation5-dev qml-module-qtlocation qttools5-dev qttools5-dev-tools qttranslations5-l10n
```

## Build & Install

```
$ git clone https://github.com/tamlok/vnote.git
$ vnote
$ git submodule update --init
$ mkdir build && cd build
$ qmake ../VNote.pro
$ make -j8
# checkinstall -y --deldoc=yes --pkgname=vnote --pkgversion=2.8.2+git~20200128
-OR-
# make install
```