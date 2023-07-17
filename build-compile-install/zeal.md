 Install dependencies:

```
# apt install cmake extra-cmake-modules libarchive-dev libsqlite3-dev libxcb-keysyms1-dev ninja-build libqt5x11extras5-dev qt5-default qtwebengine5-dev libqt5webchannel5-dev libsqlite3-dev libarchive-dev
```



Build:

```
$ cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo

$ cmake --build build
```

Install

```
# checkinstall -y --deldoc=yes --pkgname=zeal --pkgversion=1:0.6.2-git~ubuntu23.04 -D cmake --install build
```

Post-Install

```
# update-desktop-database
```
