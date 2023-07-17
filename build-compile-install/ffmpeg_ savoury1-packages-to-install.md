## [One Command to Install MultiMedia Codecs in Ubuntu 19.10

```
# apt install chromium-codecs-ffmpeg-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly cabextract gstreamer1.0-gl gstreamer1.0-vaapi libgraphene-1.0-0 libgstreamer-gl1.0-0 libmspack0 rar unrar
```



## [How to Install FFmpeg 4.2](http://ubuntuhandbook.org/?s=ffmpeg)

```
sudo add-apt-repository ppa:savoury1/graphics
sudo add-apt-repository ppa:savoury1/multimedia
sudo add-apt-repository ppa:savoury1/ffmpeg4
sudo add-apt-repository ppa:savoury1/mpv
sudo add-apt-repository ppa:savoury1/vlc3
sudo apt-get update
sudo apt-get install ffmpeg
```

### [Rob Savoury](https://launchpad.net/~savoury1)

As a new Launchpad user and PPA maintainer it is my intention to  provide a selection of software packages that have been useful to me in  recent years, since switching to a Ubuntu-based operating system for day-to-day use. There is a desire to give back time and energy to the  free software community, from which I have greatly benefited in a number of ways throughout my life.

> *Linux Mint 18.1 Serena MATE (Xenial-based) is my main distro/desktop  combo. Other distros are installed and in use (a quintuple-boot  secondary computer and also in VMs), but Serena has been rock solid for  my daily work. However, my main system is actually an unusual "Serena  Enhanced" hybrid of packages & software from four distinct Ubuntu  series (see this Github project page for more details about that: https://github.com/savoury1/ubuntu-rolling).*

The table below shows most of the software published at this  Launchpad site. Source packages with their own PPA (eg. GParted) are  copied to a collection PPA (eg. GParted -> Utilities). Some software  packages with the same name are in two different PPAs to give access to  two distinct versions (eg. FFmpeg).

```
sudo add-apt-repository ppa:savoury1/gimp
sudo add-apt-repository ppa:savoury1/digikam
sudo add-apt-repository ppa:savoury1/imagej
sudo add-apt-repository ppa:savoury1/handbrake
sudo add-apt-repository ppa:savoury1/backports
sudo add-apt-repository ppa:savoury1/utilities
sudo add-apt-repository ppa:savoury1/build-tools
```

