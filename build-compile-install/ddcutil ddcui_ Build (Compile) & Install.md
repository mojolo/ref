## Dependencies

```
i2c-tools libglib2.0-0 libglib2.0-bin libglib2.0-cil libglib2.0-data libgudev-1.0-0 libgudev1.0-cil libusb-1.0-0 libudev1 libdrm2 libxrandr2
```

```
libc6-dev libglib2.0-dev libglib2.0-cil-dev libglib2.0-dev-bin libgudev-1.0-dev libgudev1.0-cil-dev libusb-1.0-0-dev libudev-dev libdrm-dev libx11-dev libxrandr-dev python-all-dev python3-all-dev libpython-all-dev libpython3-all-dev libi2c-dev
```

```
autoconf automake autotools-dev libtool m4
```

## Build & Install

```
$ ./autogen.sh
$ ./configure
$ make -j8
# make install
```

```
# ldconfig
```

The install places the shared library `libddcutil.so.2.0.0` in the `usr/local/lib/` directory. By default, Ubuntu does not include that directory in the library path. Thus, when `ddcutil` or `ddcui` are run, they cannot find `libddcutil.so.2.0.0` and give an error message rather than launching. Running `sudo ldconfig` on the command line fixes this issue 

***Note2***: When building from git, it seems you can now ignore ***Note3***. The dev seems to have fixed the issues described therein.

***Note3***: The dev seems lazy and lacking attentiveness to detail. Tarball release v0.97, however, seems to contain all the required files to build the package. OTOH, v0.98 tarball is missing all the `Makefile.in` files. Therefore, for v0.98 and possibly future releases, you have to copy all the `Makefile.in` files from the v0.97 tarball release:

https://github.com/rockowitz/ddcutil/archive/v0.9.7.tar.gz



## `ddcui`

```
$ qmake -qt=qt5 /home/mojo_lo/build/ddcui/ddcui.pro
$ qtchooser -qt=5 -run-tool=qmake /home/mojo_lo/build/ddcui/ddcui.pro
# make -j8
```

There is no install function for ddcui. Instead, manually copy the binary `ddcui` to `/usr/local/bin`.