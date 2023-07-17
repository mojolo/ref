## Dependencies

```
cmake debhelper libavcodec-dev libavformat-dev libavutil-dev libcddb2-dev libcdparanoia-dev libcdio-paranoia-dev libebur128-dev libmpg123-dev libmtp-dev libmusicbrainz5-dev libphonon4qt5-dev libqt5svg5-dev libspeex-dev libspeexdsp-dev libtag-extras-dev libtag1-dev libudev-dev libvlc-dev libvlccore-dev libx11-dev pkg-config pkg-kde-tools qtbase5-dev qtbase5-dev-tools qtmultimedia5-dev libqt5multimedia5 libqt5multimedia5-plugins qttools5-dev-tools libqt5xml5 libqt5network5 libqt5dbus5 libtag1-dev libtag-extras-dev libtaglib-cil-dev libavahi-client-dev libavahi-common-dev libebur128-dev libqt5sql5 libqt5sql5-sqlite
```



## `.deb` Install Dependencies

### Depends

```
libavcodec58 (>= 7:4.2), libavformat58 (>= 7:4.1), libavutil56 (>= 7:4.0), libc6 (>= 2.14), libcddb2, libcdparanoia0 (>= 3.10.2+debian), libebur128-1 (>= 1.1.0), libgcc-s1 (>= 3.0), libmpg123-0 (>= 1.6.2), libmtp9 (>= 1.1.3), libmusicbrainz5cc2v5 (>= 5.1), libqt5core5a (>= 5.12.2), libqt5dbus5 (>= 5.0.2), libqt5gui5 (>= 5.11.0~rc1) | libqt5gui5-gles (>= 5.11.0~rc1), libqt5multimedia5 (>= 5.6.0~beta), libqt5network5 (>= 5.0.2), libqt5sql5 (>= 5.0.2), libqt5svg5 (>= 5.6.0~beta), libqt5widgets5 (>= 5.12.2), libqt5xml5 (>= 5.0.2), libstdc++6 (>= 5.2), libtag1v5 (>= 1.11), libudev1 (>= 183), zlib1g (>= 1:1.1.4), fonts-font-awesome, libqt5sql5-sqlite
```

### Recommends

```
liburi-perl, libio-socket-ip-perl
```

### Suggests

```
media-player-info, mpd
```



## Build

```
mkdir build
cd build
cmake ..
make -j16
# sudo checkinstall -y --deldoc=yes --pkgname=cantata --pkgversion=2.5.0~ubuntu22.04
```

## Result after running `cmake ..`

```
-----------------------------------------------------------------------------
-- The following external packages were located on your system.
-- This installation will have the extra features provided by these packages.
-----------------------------------------------------------------------------
   * Avahi Support - Automatic MPD-Server Detection
   * TagLib - Tag editor, file organiser, etc.
   * libcdio_paranoia - CD ripping.
   * libcddb - CD info retrieval via CDDB.
   * libmusicbrainz5 - CD info retrieval via MusicBrainz.
   * libavcodec/libavutil/libavformat - ReplayGain calculation.
   * libmpg123 - ReplayGain calculation.
   * libmtp - MTP Device Support.
   * Qt5Multimedia - MPD HTTP stream playback.
   * UDev - UDev support for Solid
   * media-player-info - Enables identification and querying of portable media players

-----------------------------------------------------------------------------
-- Congratulations! All external packages have been found.
-----------------------------------------------------------------------------

-- Configuring done
-- Generating done
-- Build files have been written to: /mnt/Data/Build/cantata/build
```

