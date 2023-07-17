* [dpkg](http://en.wikipedia.org/wiki/Dpkg): low level tool

* [apt](http://en.wikipedia.org/wiki/Advanced_Packaging_Tool): dpkg front-end

* [aptitude](http://en.wikipedia.org/wiki/Aptitude_(software)): apt front-end

* `apt-get` is a package management utility used to install, update, and remove software packages on Ubuntu and Debian based Linux systems.

* `apt-cache` is a utility used for searching and getting information on available software packages on Ubuntu and Debian based Linux systems.

### Install/Update Packages

```
apt install [pkg-name]
apt install --no-install-recommends [pkg-name]
apt install --reinstall [pkg-name]
apt-get install [pkg-name]
apt-get --simulate install [pkg-name]
aptitude install [pkg-name]
dpkg -i [pkg-file.deb]
```

### Update System

```
apt update
apt upgrade
apt dist-upgrade
apt-get update
apt-get upgrade
aptitude update
```

### Remove Packages (without config files)

```
apt remove [pkg-name]
apt autoremove
apt-get remove [pkg-name]
apt-get autoremove
aptitude remove [pkg-name]
dpkg -r [pkg-name]
dpkg -r --force-depends [pkg-name]
```

### Purge Packages (with config files)

```
apt purge [pkg-name]
apt autoremove --purge
dpkg -P [pkg-name]
dpkg -P --force-depends [pkg-name]
apt-get --purge remove [pkg-name]
aptitude purge [pkg-name]
```

### Hold & Unhold Packages

```
apt-mark hold [pkg-name]
apt-mark unhold [pkg-name]
```

### Clean (old/downloaded packages)

```
apt clean
apt autoclean
apt-get clean
aptitude clean
aptitude autoclean
```

### Search for Packages

```
apt search [pkg-name]
apt search "^[pkg-name]"
aptitude search [pkg-name]
aptitude search "?name([pkg-name])"
apt-cache search [pkg-name]
apt-cache pkgnames [pkg-name]
```

### Search by File

```
apt-get file [file]
dpkg -S [file]
```

### List Packages

```
apt list
apt list --installed
apt list --installed | grep [pkg-name]
apt list --upgradable
dpkg -l
```

### List Package Files

```
dpkg -L [pkg-name]
dpkg-query -L [pkg-name]
```

### Show Package Info

```
apt show [pkg-name]
dpkg -l [pkg-name]
dpkg -s [pkg-name]
aptitude show [pkg-name]
apt-cache show [pkg-name]
apt-cache showpkg [pkg-name]
apt-cache policy [pkg-name]
```

### Show Package Dependencies & Reverse Dependencies

```
apt-cache depends [pkg-name]
apt-cache rdepends [pkg-name]
```

### Repository Management

```
cat /etc/apt/sources.list
apt-add-repository [url|ppa]
	add-apt-repository ppa:author/ppa-name
add-apt-repository "deb [URL]"
apt-add-repository [url|ppa] -r
	add-apt-repository --remove ppa:author/ppa-name
ppa-purge
```

### PGP Management

```
wget -q -O - [URL] | sudo apt-key add -
```

### Handy Aliases

A bash alias is a shortcut/abbreviation that prevents you from typing a long command sequence. Adding below snippet to your `~/.bash_profile` allows you to for example install nginx using `apti nginx` as oppose to `sudo apt-get install nginx`.

```
alias apti="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias aptar="sudo apt-get autoremove"
alias aptp="sudo apt-get purge"
alias apts="sudo apt-cache search"
alias aptinfo="sudo apt-cache show"
alias addppa="sudo add-apt-repository"
alias removeppa="sudo add-apt-repository --remove"

alias aptupgrade='sudo apt update && time sudo apt dist-upgrade'
alias aptclean='sudo apt clean && sudo apt autoclean'
alias aptclean2='sudo apt clean && sudo apt autoclean && sudo apt autoremove --purge'
```

### Handy Functions

```
aptpgp () {
        wget -q -O - $1 | sudo apt-key add -
}

aptaddppa () {
        sudo add-apt-repository:$1
}

aptaddhttp () {
        sudo add-apt-repository "deb $1"
}

aptdown () {
        sudo ppa-purge $1
}

aptsname () {
        aptitude search "?name($1)"
}

aptsstart () {
        apt search "^$1"
}
```