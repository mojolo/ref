#!/bin/bash
# NOTE: make sure the libinput build is configured with --prefix=/usr/. It is
# important, so libraries upon installation end up in correct locations.
set -e

if [ "$#" -ne 1 ]; then
    echo "Wrong number of parameters.
Usage: $(basename $0) build_dir"
    exit 1
fi

MESON_BUILD_ROOT=$(readlink -f $1)
PACKAGE_VERSION=$(grep -Po 'LIBINPUT_GIT_VERSION.*"\K.+(?=")' "$MESON_BUILD_ROOT"/libinput-git-version.h)
PKG_DIR="$MESON_BUILD_ROOT"/deb
mkdir -p $PKG_DIR/DEBIAN/
cat > $PKG_DIR/DEBIAN/control <<- END_OF_TEXT
PACKAGE: libinput-git
Version: $PACKAGE_VERSION
Architecture: amd64
Maintainer: Mystique Packager
Description: input device management and event handling library
Depends: libevdev2, libmtdev1, libudev1, libwacom2
Conflicts: libinput10, libinput-bin, libinput-dev, libinput-tools
Provides:  libinput10, libinput-bin, libinput-dev, libinput-tools
Homepage: https://gitlab.freedesktop.org/libinput/libinput
END_OF_TEXT

cd "$MESON_BUILD_ROOT"
DESTDIR=$PKG_DIR ninja install
fakeroot dpkg-deb --build $PKG_DIR/ libinput_$PACKAGE_VERSION.deb