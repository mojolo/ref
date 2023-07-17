

# `goldendict` 



## Dependencies (including `Qt5`):

```
# apt install git pkg-config build-essential qt5-qmake \
     libvorbis-dev zlib1g-dev libhunspell-dev x11proto-record-dev \
     qtdeclarative5-dev libxtst-dev liblzo2-dev libbz2-dev \
     libao-dev libavutil-dev libavformat-dev libtiff5-dev libeb16-dev \
     libqt5webkit5-dev libqt5svg5-dev libqt5x11extras5-dev qttools5-dev \
     qttools5-dev-tools qtmultimedia5-dev libqt5multimedia5-plugins
```



## Building with Zim dictionaries support

To add Zim and Slob formats support you need at first install lzma-dev and zstd-dev packages:

```
# apt install liblzma-dev libzstd-dev libzim-dev
```

​                     

Then pass `"CONFIG+=zim_support"` to `qmake`

```
qmake "CONFIG+=zim_support"
```



## Build

```
$ git clone https://github.com/goldendict/goldendict.git
$ cd goldendict
$ qmake "CONFIG+=zim_support"
$ make clean && make -j16
# make install
```



## Uninstall

```
# make uninstall
```



# `goldendict-ng` (aka `goldendict-wegengine`)



## Dependencies:

```
# apt install git pkg-config build-essential qt5-qmake \
        libvorbis-dev zlib1g-dev libhunspell-dev x11proto-record-dev \
        libxtst-dev liblzo2-dev libbz2-dev \
        libavutil-dev libavformat-dev libeb16-dev \
        libqt5svg5-dev libqt5x11extras5-dev qttools5-dev \
        qttools5-dev-tools qtmultimedia5-dev libqt5multimedia5-plugins libqt5webchannel5-dev qtwebengine5-dev \
        libqt5texttospeech5-dev
```

## Building with Zim dictionaries support

To add Zim and Slob formats support you need at first install lzma-dev and zstd-dev packages, then pass `"CONFIG+=zim_support"` to `qmake`

```
# apt install liblzma-dev libzstd-dev libzim-dev
```

## Build

```
$ cd goldendict
$ qmake "CONFIG+=zim_support"
$ make clean && make -j16
# make install
```

## Uninstall

```
# make uninstall
```

