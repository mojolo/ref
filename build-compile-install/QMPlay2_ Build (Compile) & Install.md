## Install Dependencies

```
# apt install pkg-config
```

```
# apt install libavcodec-dev libavdevice-dev libavfilter-dev libavformat-dev libavifile-0.7-dev libavutil-dev libswresample-dev libswscale-dev libpostproc-dev libqt5svg5-dev
```

```
# apt install libasound2-dev qtbase5-dev qtbase5-dev-tools qttools5-dev qttools5-dev-tools qtdeclarative5-dev qtdeclarative5-dev-tools libkf5solid-dev  qtwebengine5-dev-tools qtmultimedia5-dev qtquickcontrols2-5-dev libqt5svg5-dev libqt5xmlpatterns5-dev libqt5qml5 qtxmlpatterns5-dev-tools libssl-dev libtag1-dev libass-dev libgme-dev libsidplayfp-dev libcdio-dev libcdio-utils libcddb2-dev libpulse-dev libportaudio2 portaudio19-dev libxv-dev libtag-extras-dev libtag-extras1 libva-dev libvdpau-dev libva-glx2 libegl1-mesa-dev
```



### qmplay2-git submodule update --initubuntu-18.04-amd64-19.08.27-1.deb

```
libasound2 libcddb2 libxv1 libtag-extras1 libpulse0 libgme0 libvdpau1 libsidplayfp4 libass9 libva2 libqt5widgets5 libqt5x11extras5 libqt5qml5 libva-glx2
```

### Arch

```
$ sudo pacman -S cmake make gcc pkg-config ffmpeg libass libva libxv alsa-lib libcdio taglib libcddb libpulse libgme libsidplayfp qt5-base qt5-tools
```



## Build & Install

```
git clone https://github.com/zaps166/QMPlay2.git
cd QMPlay2
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DSOLID_ACTIONS_INSTALL_PATH="/usr/share/solid/actions"
```

##### Check the summary - which features are enabled - you can set/force them manually

If CMake finishes without errors:

```
make -j16
sudo checkinstall -y --deldoc=yes --pkgname=QMPlay2 --pkgversion=23.06.04~git20230608
```



## Installation from sources

### 

### CMake requirements

For CMake build be sure that you have CMake 3.1 or higher.

### You need devel packages:

#### Necessary:

- Qt5 >= 5.6.0 (>= 5.6.3; >= 5.9.1 recommended):
  - Qt5DBus - Linux/BSD only,
  - Qt5Svg - for SVG icons,
  - Qt5Qml - for MediaBrowser,
  - Qt5WinExtras - for Windows,
- FFmpeg >= 3.3 (>= 4.0 is recommended at compilation time for VA-API and VDPAU deinterlacing filters):
  - libavformat - requires OpenSSL or GnuTLS for https support,
  - libavcodec - for FFmpeg module only,
  - libswscale,
  - libavutil,
  - libswresample or libavresample - libswresample is default,
  - libavdevice - for FFmpeg module only, optional (enabled on Linux as default),

#### Important:

- TagLib >= 1.7 (>= 1.9 recommended),
- libass - for OSD and non-graphical subtitles.

#### For modules (some of them can be automatically not used if not found):

- FFmpeg (necessary module): libva (VA-API) and libvdpau (VDPAU, X11 only),
- Chiptune: libgme (kode54 version is recommended) and libsidplayfp,
- DirectX (Windows only): DirectDraw SDK (included in mingw-w64),
- AudioCD: libcdio and libcddb,
- ALSA (Linux only): libasound,
- PulseAudio - libpulse-simple,
- PortAudio: portaudio (v19),
- XVideo (X11 only): libxv.