## Dependencies

```
# apt install git libncurses5-dev libtinfo-dev libreadline-dev pkg-config libgtk-3-dev libcanberra-gtk3-module
```

yt-dlp Install

```
# curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
# chmod a+rx /usr/local/bin/yt-dlp
```

## Build & Install

```
$ git clone https://github.com/trizen/youtube-viewer.git
$ cd youtube-viewer
# cpan install CPAN ExtUtils::PkgConfig Module::Build inc::latest PAR::Dist Term::ReadLine::Gnu Unicode::GCString libwww-perl LWP::Protocol::https Data::Dump JSON JSON::XS Gtk3 File::ShareDir LWP::UserAgent::Cached
$ perl Build.PL --gtk
$ sudo ./Build installdeps
$ sudo ./Build install
```
