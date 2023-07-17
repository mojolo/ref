#!/bin/bash

#This script will compile and install a static ffmpeg build with support for nvenc un ubuntu.
#See the prefix path and compile options if edits are needed to suit your needs.

# check versions = libva, libva-utils, cuda sdk, 

PREFIX_DIR=/mnt/Data/Build/ffmpeg
BIN_DIR=/mnt/Data/Build/ffmpeg/bin
LIB_DIR=/mnt/Data/Build/ffmpeg/lib
INCLUDE_DIR=/mnt/Data/Build/ffmpeg/include
BUILD_TOP_DIR=$PREFIX_DIR
BUILD_SOURCE_DIR=/mnt/Data/Build/ffmpeg/ffmpeg_sources
BUILD_COMPILED_DIR=/mnt/Data/Build/ffmpeg/ffmpeg_build

#install required things from apt
installLibs(){
echo -e "\nINSTALLING CORE DEPENDENCIES"
sudo apt install autoconf automake build-essential checkinstall cmake git libdrm-dev libfreetype6-dev libgnutls28-dev libsdl1.2-dev libsdl2-dev libtool libva-dev libxcb-dri3-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev meson nasm ninja-build pkg-config texinfo wget yasm
}

#install optional ffmpeg flags/features
installOptionalLibs(){
echo -e "\n\nINSTALLING OPTIONAL DEPENDENCIES"
sudo apt install libaom-dev libass-dev libbluray-dev libdav1d-dev libfdk-aac-dev libgpac-dev libmp3lame-dev libogg-dev libopus-dev libtheora-dev libvorbis-dev libvpx-dev libx264-dev libx265-dev libxml2-dev zlib1g-dev p11-kit libchromaprint-dev frei0r-plugins-dev gnutls-dev ladspa-sdk libcaca-dev libcdio-paranoia-dev libcodec2-dev libfontconfig1-dev libfribidi-dev libgme-dev libgsm1-dev libjack-dev libmodplug-dev libopencore-amrnb-dev libopencore-amrwb-dev libvo-amrwbenc-dev libopenjp2-7-dev libopenmpt-dev libpulse-dev librsvg2-dev librubberband-dev librtmp-dev libshine-dev libsmbclient-dev libsnappy-dev libsoxr-dev libspeex-dev libssh-dev libssl-dev libtesseract-dev libtwolame-dev libv4l-dev libwavpack-dev libwebp-dev libxvidcore-dev libzmq3-dev libzvbi-dev liblilv-dev libopenal-dev opencl-dev libvidstab-dev libzimg-dev libmysofa-dev cargo cargo-c libsrt-openssl-dev
#libvdpau-dev
}

#install libs needed for vaapi build
installVaapiLibs(){
echo -e "\n\nINSTALLING VAAPI DEPENDENCIES"
sudo apt install libx11-dev libpciaccess-dev libpciaccess0 libperl-dev mercurial texi2html xorg-dev
}

#Build Rav1e
# ERROR: rav1e >= 0.5.0 not found using pkg-config
# Installed rav1e-dev to resolve. Am I now using the old-ass ubuntu version?
CompileRav1e(){
echo -e "\nBuilding & installing Rav1e from repositories"
cd "$BUILD_SOURCE_DIR"
wget https://github.com/xiph/rav1e/archive/refs/tags/v0.6.6.tar.gz
tar xzvf v0.6.6.tar.gz
cd rav1e-0.6.6
cargo cinstall --prefix="$BUILD_COMPILED_DIR" --library-type=staticlib --crt-static --release
}

# Had to replace the checkinstall line but not sure why
CompileLibva(){
echo -e "\nBuilding & installing libva from repositories"
cd "$BUILD_SOURCE_DIR"
git clone https://github.com/intel/libva.git
cd libva
./autogen.sh --prefix=/usr/local --libdir=/usr/local/lib/x86_64-linux-gnu --enable-x11=yes --enable-glx=yes
time make -j$(nproc) VERBOSE=1
# sudo checkinstall -y --deldoc=yes --pkgname=libva2-git --pkgversion=2.18.2~git
sudo make -j$(nproc) install
sudo ldconfig
hash -r
}

CompileLibvaUtils(){
echo -e "\nBuilding & installing libva-utils from repositories"
cd "$BUILD_SOURCE_DIR"
git clone https://github.com/intel/libva-utils
cd libva-utils
./autogen.sh --prefix=/usr/local --libdir=/usr/local/lib/x86_64-linux-gnu
./configure
time make -j$(nproc) VERBOSE=1
sudo checkinstall -y --deldoc=yes --pkgname=libva2-utils --pkgversion=2.18.2~git
sudo ldconfig
hash -r
}

compileLibAom(){
echo -e "\n\nCOMPILING LIBAOM"
cd "$BUILD_SOURCE_DIR"
git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom
mkdir -p aom_build
cd aom_build
PATH="$BIN_DIR:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$BUILD_COMPILED_DIR" -DENABLE_TESTS=OFF -DENABLE_NASM=on ../aom
PATH="$BIN_DIR:$PATH" make -j$(nproc)
make -j$(nproc) install
}

compileSvtAv1(){
echo -e "\n\nCOMPILING LibSvtAv1"
cd "$BUILD_SOURCE_DIR"
git -C SVT-AV1 pull 2> /dev/null || git clone https://gitlab.com/AOMediaCodec/SVT-AV1.git
cd SVT-AV1/Build
PATH="$BIN_DIR:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$BUILD_COMPILED_DIR" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF ..
PATH="$BIN_DIR:$PATH" make -j$(nproc)
make -j$(nproc) install
}

compileLibDav1d(){
echo -e "\n\nCOMPILING LIBDAV1D"
cd "$BUILD_SOURCE_DIR"
git -C dav1d pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/dav1d.git
mkdir -p dav1d/build
cd dav1d/build
meson setup -Denable_tools=false -Denable_tests=false --default-library=static .. --prefix "$BUILD_COMPILED_DIR" --libdir="$BUILD_COMPILED_DIR/lib"
ninja
ninja install
}

compileLibVmaf(){
echo -e "\n\nCOMPILING LIBVMAF"
cd "$BUILD_SOURCE_DIR"
wget https://github.com/Netflix/vmaf/archive/v2.1.1.tar.gz
tar xvf v2.1.1.tar.gz
mkdir -p vmaf-2.1.1/libvmaf/build
cd vmaf-2.1.1/libvmaf/build
meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static .. --prefix "$BUILD_COMPILED_DIR" --bindir="$BIN_DIR" --libdir="$BUILD_COMPILED_DIR/lib"
ninja
ninja install
}

getAmfHeaders(){
echo -e "\n\nGETTING AMF"
cd "$BUILD_SOURCE_DIR"
wget https://github.com/GPUOpen-LibrariesAndSDKs/AMF/archive/refs/tags/v1.4.29.tar.gz
tar xvf v1.4.29.tar.gz
mkdir -p $BUILD_COMPILED_DIR/include/AMF
mv AMF-1.4.29/amf/public/include/* "$BUILD_COMPILED_DIR/include/AMF/"
}

compileFfmpeg(){
echo -e "\n\nCOMPILING FFMPEG"
cd "$BUILD_SOURCE_DIR"
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$BIN_DIR:$PATH" PKG_CONFIG_PATH="$BUILD_COMPILED_DIR/lib/pkgconfig:$BUILD_COMPILED_DIR/lib/x86_64-linux-gnu/pkgconfig:PKG_CONFIG_PATH" ./configure \
  --prefix="$PREFIX_DIR" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$BUILD_COMPILED_DIR/include" \
  --extra-ldflags="-L$BUILD_COMPILED_DIR/lib" \
  --ld="g++" \
  --enable-gpl \
  --enable-version3 \
  --enable-nonfree \
  --enable-gpl \
  --enable-gnutls \
  --enable-libdav1d \
  --enable-libaom \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-vaapi \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libsvtav1 \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-chromaprint \
  --enable-frei0r \
  --enable-gmp \
  --enable-ladspa \
  --enable-libcaca \
  --enable-libcdio \
  --enable-libcodec2 \
  --enable-libfontconfig \
  --enable-libfribidi \
  --enable-libgme \
  --enable-libgsm \
  --enable-libjack \
  --enable-libmodplug \
  --enable-libopencore-amrnb \
  --enable-libopencore-amrwb \
  --enable-libvo-amrwbenc \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-libpulse \
  --enable-librsvg \
  --enable-librubberband \
  --enable-librtmp \
  --enable-libshine \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libssh \
  --enable-libtwolame \
  --enable-libv4l2 \
  --enable-libwebp \
  --enable-libxvid \
  --enable-libxml2 \
  --enable-libzvbi \
  --enable-lv2 \
  --enable-libmysofa \
  --enable-openal \
  --enable-opencl \
  --enable-opengl \
  --enable-libdrm \
  --enable-libbluray \
  --enable-librav1e \
  --enable-libvidstab \
  --enable-libzimg \
  --enable-libsrt \
  --enable-pthreads \
  --disable-debug \
  --disable-doc \
  --disable-ffnvcodec \
  --enable-libvmaf \
  --enable-amf \
  --disable-static \
  --enable-shared
#  --disable-shared
#  --enable-libtesseract \
#  --enable-libzmq \
#  --enable-libnpp \
#  --enable-avisynth \
#  --disable-ffnvcodec
#  --enable-small \
#  --bindir="$BINDIR" \
#  --enable-nvenc \
#  --enable-cuda-sdk \
#  --enable-cuvid \
#  --extra-cflags="-I/usr/local/cuda/include/" \
#  --extra-ldflags=-L/usr/local/cuda/lib64/ 
#  --enable-openssl \
PATH="$BINDIR:$PATH" make -j$(nproc)
# sudo checkinstall -y --deldoc=yes --pkgname=ffmpeg-custom-build --pkgversion=6.0~ubuntu23.04
# sudo make -j$(nproc) install
make -j$(nproc) install
make -j$(nproc) distclean
}

# echo -e "\nUPDATING APT PACKAGES"
# sudo apt update
mkdir "$BUILD_TOP_DIR"
cd "$BUILD_TOP_DIR"
mkdir "$BUILD_SOURCE_DIR"
mkdir "$BUILD_COMPILED_DIR"
mkdir "$BIN_DIR"
mkdir "$LIB_DIR"
mkdir "$INCLUDE_DIR"
installLibs
installOptionalLibs
# installVaapiLibs
CompileLibva
CompileLibvaUtils
CompileRav1e
compileLibAom
compileLibDav1d
compileSvtAv1
compileLibVmaf
getAmfHeaders
compileFfmpeg
sudo ldconfig
hash -r
echo "Complete!"
