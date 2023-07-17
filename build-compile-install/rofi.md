## Install dependencies

```
# apt install bison flex libxcb-xkb-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xrm-dev libxcb-xinerama0-dev libstartup-notification0-dev libxcb-cursor-dev
```



## Building/Installing a checkout from `git`

If you don't have a checkout:

```
git clone --recursive https://github.com/DaveDavenport/rofi
cd rofi/
```

If you already have a checkout:

```
cd rofi/
git pull
git submodule update --init
```

For Autotools you have an extra step (compared to building from a release), to generate build system:

```
autoreconf -i
```

From this point, use the same steps you use for a release:

#### Autotools

Create a build directory and enter it:

```
mkdir build && cd build
```

Check dependencies and configure build system:

```
../configure --disable-check
```

Build Rofi:

```
make -j16
```

The actual install, execute as root (if needed):

```
# checkinstall -y --deldoc=yes --pkgname=rofi --pkgversion=1.7.5~git-2023-06-24
~OR~
# make install
```

*The default installation prefix is: `/usr/local/` use `./configure --prefix={prefix}` to install into another location.*

#### Meson

Check dependencies and configure build system:

```
meson setup build
```

Build Rofi:

```
ninja -C build
```

The actual install, execute as root (if needed):

```
ninja -C build install
```

*The default installation prefix is: `/usr/local/` use `meson setup build --prefix={prefix}` to install into another location.*

### Options for configure

#### Disabling `check`

`check` can be disabled using the `--disable-check` configure flag. You will not need to install the `check` dependency. `check` is only used for build-time tests and does not affect functionality.

```
# Autotools
../configure --disable-check

# Meson
meson setup build --disable-check
```

#### Install prefix (don't need to set -- default is `/usr/local`)

```
# Autotools
../configure --prefix=/usr/local

# Meson
meson setup build --prefix /usr/local
```



## Uninstalling

#### Autotools

```
# make install
```

----



# `rofi-file-selector`

## Install dependencies

`PyGobject`, `xsel`, `choose`

```
# apt install python3-gi python3-gi-cairo gir1.2-gtk-4.0 xsel
$ cargo install choose
```

`fd`

```
already installed with zinit
```

git clone https://gitlab.com/matclab/rofi-file-selector.git

advanced:

https://github.com/adi1090x/rofi

other:

https://www.reddit.com/r/qtools/comments/pu1a4v/how_do_i_capture_a_variable_with_rofiscript/

https://www.reddit.com/r/i3wm/comments/b33713/dmenurofi_for_filenames_and_possibly_filecontent/

https://www.reddit.com/r/i3wm/comments/4j3n8j/searching_for_files/

https://www.reddit.com/r/i3wm/comments/1334f9w/recent_files_search_for_rofi/

fd:

https://gitlab.com/matclab/rofi-file-selector (trying; python)
https://www.reddit.com/r/i3wm/comments/ll2trj/rofi_file_selector/

https://github.com/cjbassi/rofi-files/blob/master/rofi-files (tried; python)

find:

https://github.com/jpantao/rofi-find/blob/master/rofi-find.sh

https://github.com/davatorium/rofi-scripts/tree/master/rofi-finder (tried, weird)

recoll:

https://github.com/csantosb/myscripts/blob/master/search-recoll-dmenu.sh

https://github.com/andersju/zzzfoo

locate:

https://github.com/gotbletu/shownotes/blob/master/rofi-scripts-collection/rofi-locate.sh
https://github.com/gotbletu/shownotes/blob/master/rofi_locate.md

https://www.reddit.com/r/qtools/comments/mky0wp/combine_regular_rofi_with_locate/

https://unix.stackexchange.com/questions/493487/truncate-from-beginning-in-rofi

file browser:

https://github.com/davatorium/rofi/blob/master/Examples/rofi-file-browser.sh

https://github.com/marvinkreis/rofi-file-browser-extended
