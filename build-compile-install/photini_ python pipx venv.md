# Install System-Wide Dependencies:

```bash
# apt install libgphoto2-dev 
```



### PyQt5

Not sure which packages need to be installed. Installing all of the following from `1.` and `2.` will do it though.

1. I know this two need to be installed:

```
pyqt5.qtwebengine pyqt5.qtwebchannel
```

2. I already had these installed:

```
python3-pyqt5 python3-pyqt5.sip python3-pyqt5.qtsvg python3-dbus.mainloop.pyqt5
```



### ~~PySide2~~ (BROKEN) (DO NOT USE)

PySide2 fails to show the titlebar hamburger menu.

```
# apt install python3-pyside2.qtcore python3-pyside2.qtgui python3-pyside2.qtwidgets python3-pyside2.qtnetwork python3-pyside2.qtwebengine python3-pyside2.qtwebenginecore libpyside2-py3-5.15 python3-pyside2.qtwebenginewidgets python3-pyside2.qtprintsupport python3-pyside2.qtwebchannel libshiboken2-py3-5.15
```



# `pipx` Install Methods

Install using system-site-packages when available. Install new packages into our `photini` virtualenv. (16 folders, 2 files)

```bash
$ pipx install --system-site-packages --verbose "photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"
```

Normal install using system-site-packages (8 folders, 2 files initially. and then 16 folders, 2 files after running `photini-configure`)

```bash
$ pipx install --system-site-packages photini
```



Install photini + extras using system-site-packages if available. Also upgrade with eager strategy so that newer pypi versions of packages get installed in our `photini` virtualenv.  (41 folders, 2 files)

```
$ pipx install --system-site-packages --pip-args='--upgrade --upgrade-strategy eager' --verbose "photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"
```

***~OR~***

```
$ pipx install --system-site-packages --verbose "photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"

$ pipx upgrade --pip-args='--upgrade-strategy eager' --verbose photini
```

Install photini + extras (or without extras should work too) using system-site-packages and then inject upgraded packages (if a newer version is available via **pypi**) by installing them into the `photini` virtualenv.

```
$ pipx install --system-site-packages --verbose "photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"

# Inject Upgraded packages specified without upgrading their dependencies (25 folders, 2 files)

$ pipx inject --pip-args='--upgrade' --verbose photini appdirs cachetools chardet exiv2 requests requests-oauthlib requests-toolbelt keyring gphoto2 pyenchant gpxpy Pillow

# Inject Upgraded packages and their upgraded dependencies (41 fol, 2 fil)

$ pipx inject --pip-args='--upgrade --upgrade-strategy eager' --verbose photini appdirs cachetools chardet exiv2 requests requests-oauthlib requests-toolbelt keyring gphoto2 pyenchant gpxpy Pillow
```



Install using system-site-packages for PyQt5/PySide2/PySide6. Install all other extras into our `photini` virtualenv. (55 folders, 2 files)

```
$ pipx install --system-site-packages --pip-args='--ignore-installed' --verbose "Photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"
```



### Optional packages

1. Run `$ photini-configure`. Select option #1 for PySide2. Select `y` for everything else to automatically install into the `pipx` `virtualenv`.

***~OR~***

2. Install all dependencies (in `pipx` virtualenv) in one fell swoop:

```
$ pipx install "photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"

$ sed -i 's|include-system-site-packages = false|include-system-site-packages = true|g' /home/mojo_lo/_local/pipx/venvs/photini/pyvenv.cfg
```

***~OR~***

3. Install all dependencies (using system-site-packages, if available; otherwise install into `pipx` virtualenv) in one fell swoop:

```
$ pipx install "photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]" --system-site-packages
```

***THEN***

```
$ photini-configure
```



# `pipx` + `pip` Install Methods 

##### First:

```
$ pipx install photini

$ pipx inject --verbose photini requests-oauthlib requests-toolbelt keyring gphoto2 pyenchant gpxpy Pillow
```

~OR~

```
$ pipx install "Photini[flickr,google,importer,ipernity,pixelfed,spelling,gpxpy,Pillow]"
```

~OR~

```
$ pipx install photini

$ source /home/mojo_lo/_local/pipx/venvs/photini/bin/activate

(venv)$ python -m pip install --ignore-installed --verbose requests-oauthlib requests-toolbelt keyring gphoto2 pyenchant gpxpy Pillow

(venv)$ deactivate
```



##### Then:

```
$ sed -i 's|include-system-site-packages = false|include-system-site-packages = true|g' /home/mojo_lo/_local/pipx/venvs/photini/pyvenv.cfg
```

```
$ photini-configure
```

### Various `pip` install methods

1. `python -m pip install --ignore-installed` or `pip install -I`

2. `python -m pip install --upgrade` or `pip install -U`

   * I arrived at this post while looking for how to force install  something in a virtualenv despite it being already installed in the  global python. This happens when the virtual env was created with `--system-site-packages`.

     In this situation, for certain packages it may be important to have a local version within the virtualenv, even if for many other packages we can share the global versions. This is the case of `pytest`, for example. However, pip will refuse to install a package in the  virtualenv if it can already find the most recent version in the system  site.

     The solution is to use `python -m pip install --ignore-installed mypackage`.

   * Simple upgrade can be done by adding: `--upgrade` or `-U`

   * Create the environment with `virtualenv --system-site-packages` . Then, activate the virtualenv and when you want things installed in the virtualenv rather than the system python, use `python -m pip install --ignore-installed` or `python -m pip install -I` . That way pip will install what you've requested locally even though a system-wide version exists. Your python interpreter will look first in  the virtualenv's package directory, so those packages should shadow the  global ones.

   * By using -I, you will always reinstall  packages, even if they already exist in the systemwide site-packages  directory. If you use -U (--upgrade) instead, it will install newer versions of  packages into your virtualenv, but won't reinstall any packages that are already available in the system with the required version.

   * Thanks for this. A note regarding -I vs -U:  Sometimes a project depends on a specific version (or range of versions) of a package, in which case -I with a version selector is the right  choice.

3. `python -m pip install --force-reinstall`

   * Forcing reinstall of the package(s). Uninstalls and reinstalls a package.

   * "Overinstalls" packages already in system-site-packages: Will force install a local version of the package from pypi. Will attempt to uninstall global (system-wide) package but will fail because insufficient (sudo/admin) privileges.

4. `python -m pip install --upgrade --ignore-installed`
   * Probably not necessary to add the `--upgrade` flag as `--ignore-installed` will already install what you want locally, whether there is a version upgrade or not.
5. `python -m pip install --upgrade --force-reinstall`
   - `--upgrade --force-reinstall` is a bit of an overkill in case of fresh environment, but it will do no harm

# OLD (Do not use)

### Optional packages

```
$ pipx inject photini requests-oauthlib requests-toolbelt keyring gphoto2 pyenchant gpxpy Pillow
```

# OLD (Do not use)

``` 
$ pipx install Photini
```

```
$ pipx inject photini requests-oauthlib requests-toolbelt keyring PyQt5 gphoto2 pyenchant gpxpy Pillow PySide6
```

