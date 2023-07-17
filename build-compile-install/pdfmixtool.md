### Installation

We’re installing PDF Mix Tool on a completely fresh installation of Ubuntu 21.10.

We first need to install the software’s dependencies and tools.  There’s quite a few we’re missing with a new installation of Ubuntu,  although some of them you may already have installed on your system,  particularly if you compile software.

```
$ sudo apt install git cmake build-essential libqpdf-dev imagemagick libmagick++-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5svg5-dev qttools5-dev qpdf libqpdf-dev
```

The build-essential package includes g++ which is needed to compile this software.

Next issue the following commands at a terminal:

```
$ git clone https://gitlab.com/scarpetta/pdfmixtool.git
$ cd pdfmixtool
$ mkdir build && cd build
$ cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
$ make -j 16
```

We’re using the make -j option as this enables the compiler to use more CPU cores, which speeds up compilation enormously.

If you don’t want to manually compile the software, you can install the software using flatpak or snap.

**Using flatpak**

If you’re never used Flatpaks before, you’ll first need to install the flatpak package. At a shell type:

```
$ sudo apt install flatpak
$ flatpak install flathub eu.scarpetta.PDFMixTool
```

Run the program with the command:

```
$ flatpak run eu.scarpetta.PDFMixTool
```

**Using Snap**

```
$ sudo snap install pdfmixtool
$ sudo snap connect pdfmixtool:removable-media
```

There may also be a convenient package available for your distribution.
