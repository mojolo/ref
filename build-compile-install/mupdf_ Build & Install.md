* Download latest version of `mupdf` source tarball:

  https://www.mupdf.com/downloads/index.html



## Dependencies

```
apt install xorg-dev mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev libxrandr-dev libxinerama-dev libfreetype6-dev
```



## Compiling `mupdf` on Linux

If you are compiling from source you will need several third party libraries: `freetype2`, `jbig2dec`, `libjpeg`, `openjpeg`, and `zlib`. These libraries are contained in the source archive. If you are using git, they are included as git submodules.

You will also need the X11 headers and libraries if you're building on Linux. These can typically be found in the `xorg-dev` package. Alternatively, if you only want the command line tools, you can build with `HAVE_X11=no`.

The new OpenGL-based viewer also needs OpenGL headers and libraries. If you're building on Linux, install the `mesa-common-dev`, `libgl1-mesa-dev` packages, and `libglu1-mesa-dev` packages. You'll also need several X11 development packages: `xorg-dev`, `libxcursor-dev`, `libxrandr-dev`, and `libxinerama-dev`. To skip building the OpenGL viewer, build with `HAVE_GLUT=no`.

* For `zathura`, `mupdf` has to be built with `-fPIC` before it can be linked successfully to the `zathura` plugin. Set environment variables: `export CFLAGS="-fPIC"` to resolve errors about missing a definition for `NAN` symbol in the `thirdparty/mujs` folder.

* Run the initial make: `make -j8 prefix=/usr/local`

  ***Note***: this will lead to an install of the viewer, command line tools, libraries, and header files on your system.

* If no issues occur install: `sudo make prefix=/usr/local install`

***NOTE***: To install only the command line tools, libraries, and headers invoke make like this:

```
make HAVE_X11=no HAVE_GLUT=no prefix=/usr/local install
```



## Compiling `pymupdf` on Linux

### Dependencis

```
apt install python3-pip swig libjpeg-dev libjpeg-turbo8-dev libjpeg8-dev libjpeg9-dev libjbig2dec0-dev libssl-dev libfreetype6-dev
```

### Build & Install

- Get the corresponding version of `PyMuPDF` here: https://github.com/pymupdf/PyMuPDF/releases

  ***Note***: The major and minor versions of `PyMuPDF` and `MuPDF` will always be the same. Only the third qualifier (patch level) may be different from that of `MuPDF`. 

- If necessary, edit the `setup.py` to point to the correct directories as indicated by the prefix used when making. For example:

      include_dirs=["/usr/local/include/mupdf", "/usr/local/include"],
      library_dirs=["/usr/local/lib"],
      libraries=["mupdf", "mupdf-third"],

- Run `python3 setup.py build`
- If no exception is thrown install either with `python setup.py install` or `pip3 install /home/mojo_lo/build/PyMuPDF-1.16.10`.