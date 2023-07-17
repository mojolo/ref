## Stop & disable unneeded `mpd` service & sockets

```
# systemctl stop mpd.service
# systemctl disable mpd.service
# systemctl stop mpd.socket
# systemctl disable mpd.socket

$ systemctl --user stop mpd.socket
$ systemctl --user disable mpd.socket
```

## Disable `mpd` autostart process

An automatic per-user startup is also automatically enabled in  Ubuntu. Thus, if you disable the system wide mpd service, an autostart  process will start a user-specific instance as soon as you log in.

To safely disable autostart:

- Copy `/etc/xdg/autostart/mpd.desktop` to `~/.config/autostart/mpd.desktop`
- Edit `~/.config/autostart/mpd.desktop` to change `X-GNOME-Autostart-enabled=true` to `X-GNOME-Autostart-enabled=false`, or delete the line
- Edit or add a line `Hidden=true'

A local .desktop file takes priority over a system wide launcher.  Instead of editing the system wide launcher, creating and changing a  private copy is better practice because 1) you only affect your current  user, 2) you do not need root permissions to customize the starter, and  3) your changes will not be overwritten by possible system updates.

## If `user` `service` & `socket` cannot be disabled completely

This is because only the service symlinks in `~/.config/systemd/user` are being unloaded, and there are still remnant symlinks in `/etc/systemd/user/`.

You will need to manually delete `/etc/systemd/user/default.target.wants/mpd.service` and `/etc/systemd/user/sockets.target.wants/mpd.socket` as well.

```
# rm /etc/systemd/user/default.target.wants/mpd.service
# rm /etc/systemd/user/sockets.target.wants/mpd.socket
```

## Refresh `systemd`

```
systemctl daemon-reload
systemctl reset-failed
```

### Can also try to disable the following:

```
# service mpd stop
# /etc/init.d/mpd stop
# update-rc.d mpd disable
```

### Can also try deleting:

`/etc/init.d/mpd`

```
# rm /etc/init.d/mpd
```

*Note*: You may want to delete all the `K01mpd` files (7 symlinks) in `/etc/rc0.d` - `/etc/rc6.d` as well.

---

---

`mojo_lo`'s output of `# systemctl enable mpd.service` after running `# update-rc.d mpd disable`:

```
Synchronizing state of mpd.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable mpd
Created symlink /etc/systemd/system/multi-user.target.wants/mpd.service → /lib/systemd/system/mpd.service.
Created symlink /etc/systemd/system/sockets.target.wants/mpd.socket → /lib/systemd/system/mpd.socket.
```

---

---

## Pseudo-Summary (in theory)

Disable system-wide launching of the `mpd` service

```
# systemctl disable mpd.service
```

Upon checking `# systemctl status mpd.service`, it was not inactive.

However, after the next reboot, `systemd` still spawned a process `mpd`.

The only solution that worked was:

```
# systemctl mask mpd.service
```

However, the crazy thing is: another `mpd` process is still being spawned at startup, with the folder  autostart under `~/.config` being empty and i also start with an empty  session on boot-up.

So the final question: How do i really get rid of the autostart of `mpd`? I just want to start it manually, thats all.

---

By default, Ubuntu automatically launches 2 instances of `mpd` on start-up: (1) an `mpd` system service, and a (2) `mpd` user service. Thus, if you disable the system-wide `mpd` service, an autostart process will start a user-specific instance as soon as you log in.

To safely disable autostart:

- Copy `/etc/xdg/autostart/mpd.desktop` to `~/.config/autostart/mpd.desktop`
- Edit `~/.config/autostart/mpd.desktop` to change `X-GNOME-Autostart-enabled=true` to `X-GNOME-Autostart-enabled=false`, or delete the line
- Edit or add a line `Hidden=true'

A local .desktop file takes priority over a system wide launcher.  Instead of editing the system wide launcher, creating and changing a  private copy is better practice because 1) you only affect your current  user, 2) you do not need root permissions to customize the starter, and  3) your changes will not be overwritten by possible system updates.

---

Sadly, this wasn't the solution. Although i  like your principle and also try follow it anywhere i can, it doesn't  change the situation. Even after reinstalling, disabling and masking the service and doing the changes that you proposed: after startup 2 `mpd`  processes spawn: 1 system service; and 1 user service. Running Kubuntu 19.04.

---

In your question, you did not specify the DE, so the answer was for a standard Ubuntu desktop. However, I edited my  answer: adding the line `Hidden=true' will disable autostart  irrespective of the desktop environment.

---



## [I can't get mpd and ncmpcpp to work, would appreciate any help](https://www.reddit.com/r/linux4noobs/comments/4jqr03/i_cant_get_mpd_and_ncmpcpp_to_work_would/)

So I followed [this](http://www.linuxandlife.com/2012/01/simple-guide-to-set-up-mpd-with-ncmpcpp.html) tutorial but I keep getting this error:

```
[May 17 13:32 : socket: Failed  to bind to '[::]:6600': Address already in use]
```

so I then followed [this](http://ubuntuforums.org/showthread.php?t=2078297) and [this](https://bbs.archlinux.org/viewtopic.php?id=120371) and still got the same error so any help would be appreciated.

---

The tutorial you followed is for running `mpd` as a user (not a bad idea). By default `mpd` is already run as a service as root. The error message means: you started `mpd` manually (as user), but the service is already running.

---

I'm using Ubuntu Gnome, I did what you said then a load of stuff I don't understand came up and when I tried run mpd still got the same failed to bind error.

---

It's telling you that because `mpd` is already running... so you need to investigate how it is getting executed at startup.

---

Your problem is that you have mpd  start as a service upon boot, automatically. Look in your session  settings in the gnome settings GUI and change it there.

If there's no  specific reason you need it to be run as user, you can just leave it  running as root, and ncmpcpp can connect to that instance of mpd.

---

> [May 17 13:32 : socket: Failed to bind to '[::]:6600': Address already in use]

This error means a program is already using the port 6600.

Now we need to find out whether mpd is already in use. To do this, you will need to type :

```
ps -eo pid,user,command | grep mpd
```

This command does print  out the running program's username, PID (process ID) and command. Since  this command also contains the word *mpd*, there will most likely be two lines in the output.

**If there is only one line in the output**

mpd is not running and another program listens to the port 6600. Open the `mpd.conf` file you created in the tutorial and add a line containing :

```
port 12837
```

and try to run it again.

**If you have two lines in the output**

Both lines will start with a number (the process ID) followed by the  username of the user that is running the program and then the actual  program. Check the line **not containing** the word *grep*. If the username is `root`, it means that mpd is started at boot (you do not want that) and you will need to type :

```
sudo service mpd stop
sudo update-rc.d mpd disable
```

To check if mpd is now working, just type

```
mpd
```

in the command line.

If there are not errors (there will be warnings, but it is not a problem), to make these changes definive, type

```
gedit ~/.config/autostart/mpd.desktop
```

and put in that file :

```
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Music Player Daemon
Comment=Server for playing audio files
Exec=mpd
StartupNotify=false
Terminal=false
Hidden=false
```

and then log out and in again.

It should work at that point. If not, please copy-paste or screenshot all  of your commands and their output and put them in a comment here. It  would also be a good idea to provide your `mpd.conf` file.

---

Thank you for the comment, here's my output

```
 3414 mpd
 3528 mpd
 4276 grep --color=auto mpd
```

when I do

```
ps -eo pid,command | grep mpd
```

and I still got the same error when I went through your comment, I feel like I'm just doing  something stupid and easy to solve but I'm pretty new to using Linux and working with the terminal. Here's my mpd.conf

```
music_directory    "/home/andy/Music"  
playlist_directory "/home/andy/.mpd/playlists"  
db_file            "/home/andy/.mpd/mpd.db"  
log_file           "/home/andy/.mpd/mpd.log"
pid_file            "/home/andy/.mpd/mpd.pid"  
state_file         "/home/andy/.mpd/mpdstate"  
mixer_type	"software"

audio_output {  
      type  "pulse"  
      name  "mpd pulse-audio-output"  
}  

audio_output {  
      type  "alsa"  
      name  "mpd alsamixer-output"  
}  
```

---

You should remove :

```
audio_output {  
      type  "alsa"  
      name  "mpd alsamixer-output"  
}
```

from the mpd.conf  file. You only need the pulse output.

Could you please type the command

```
ps -eo user, pid,command | grep mpd
```

(Do not forget the `user,` part, since it will give important information).

If the user for the two first lines is you, run

```
pkill -KILL mpd
```

Log out and in again, retype the command (without doing anything else before) :

```
ps -eo user, pid,command | grep mpd
```

to see if mpd already started. If it has, and it is the only instance, you should be good. If it not ok yet, tell me.

---

Thank you so much for your help I think this fixed it, I mean I can play  music off ncmpcpp but I still have to entries after I put enter

```
ps -eo user, pid,command | grep mpd
```



## [ncmpcpp can't find music?](https://www.reddit.com/r/linux4noobs/comments/76winw/ncmpcpp_cant_find_music/)

 I've got mpd and ncmpcpp installed, and I can't seem to get ncmpcpp to read in any music from my ~/Music directory.

Here's my "mpd.conf" located in /home/user/.mpd/mpd.conf:

```
db_file            "~/.mpd/database"
log_file           "~/.mpd/log"

bind_to_address    "127.0.0.1"
music_directory    "~/Music"
playlist_directory "~/.mpd/playlists"
pid_file           "~/.mpd/pid"
state_file         "~/.mpd/state"
sticker_file       "~/.mpd/sticker.sql")
```

Here's my ncmpcpp config located in /home/user/.ncmpcpp/config:

```
ncmpcpp_directory = "~/.ncmpcpp"

lyrics_directory = "~/.lyrics"

mpd_host = "127.0.0.1"
mpd_port = "6600"
mpd_music_dir = "~/Music"
mpd_connection_timeout = 5
mpd_crossfade_time = 0)
```

In ~/Music I've got one  folder containing one song. I can never find this song in ncmpcpp. I  press u; ncmpcpp says that the database is updated, and still, nothing's there: https://i.imgur.com/kxRTFRm.png

I can tell that ncmpcpp is reading the right config, because it'll print  "Reading configuration from /home/user/.ncmpcpp/config..." when I run  ncmpcpp, and ncmpcpp displays "Connected to 127.0.0.1" at the bottom  (this mirrors whatever mpd_host is in the config; see at https://i.imgur.com/Oah1OFP.png). I know mpd is reading my mpd.conf because when I run plain mpd I get this:

```
socket: Failed to bind to '127.0.0.1:6600': Address already in use
```

I must be missing something major. Could you help me out? This is on Xubuntu 17.04.

Here is the output of `# systemctl status mpd service`:

```
● mpd.service - Music Player Daemon
   Loaded: loaded (/lib/systemd/system/mpd.service; enabled; vendor preset: enab
   Active: active (running) since Tue 2017-10-17 09:08:37 PDT; 1min 5s ago
     Docs: man:mpd(1)
           man:mpd.conf(5)
           file:///usr/share/doc/mpd/user-manual.html
 Main PID: 1123 (mpd)
    Tasks: 5 (limit: 4915)
   CGroup: /system.slice/mpd.service
           └─1123 /usr/bin/mpd --no-daemon

Oct 17 09:08:37 host systemd[1]: Started Music Player Daemon.
lines 1-12/12 (END)
```

---

What user is mpd running as? If started as root, it drops to user "mpd"  by default, which would not have permissions for your home folder. Also, the default port in mpd.conf is 6600 so that being used does not show  that it is reading your file specifically.

---

Ahh wow! How would I go about fixing those permissions? I'm assuming it  starts as root and dropped to mpd then, as 127.0.0.1 is already in use  when I try to run it as my user. Should mpd be able to read and write,  instead of just read?

---

It needs read (for playing files), write (for writing to databases and  tagging) and execute (for accessing folders). There are a few different  ways to allow access. The most simple and least secure would be to  simply change it so it runs as your user rather than the user mpd by  adding `user "username"` to the config file. This should be fine for home use.

Not sure if it's your problem though since apparently it can read your conf file which is in your home directory...

---

It worked! I set `user` to my username mpd.config, ran mpd, and now ncmpcpp can read and play  my stuff. Only other problem is that now I need to manually run mpd  before ncmpcpp when I boot.

XFCE's Session and Startup appears to run mpd by default, using the command `mpd`. I know it does, because when I attempt `mpd` the socket will already be in use, yet ncmpcpp will give me `ncmpcpp: Connection refused` until I exit out, run `mpd` as my user (somehow, running ncmpcpp frees up the socket again?), and  then try ncmpcpp, in which case it'll be able to connect to mpd and read music again. Bit weird, but I'm pretty satisfied; it's just a small  workaround.

---

It appears that you have the mpd service enabled with systemd, and mpd autostarting with XFCE?

I would disable the systemd service with `systemctl disable mpd` and just have xfce start it.



## Configuring MPD to run as a user service

By default ubuntu installs mpd as a system service. We don't want this, so let's remove it from startup.

If mpd is running stop it first. (not in screenshot)

```
$ /etc/init.d/mpd stop
# update-rc.d mpd disable
```

Alternatively you can edit the file `/etc/default/mpd` as root and set the value of `START_MPD` to `false`.

```
## Change this to prevent MPD from being started as a system service (for
## example, if you want to run it from a regular user account)
START_MPD=false

## The configuration file location for mpd:
# MPDCONF=/etc/mpd.conf
```

---

MPD doesn't need to run as a daemon and can be run as a regular program by  any user.  By doing this, MPD will use the users configurations and has  no need for a system-wide configuration (useful if you keep your **/home** on a separate partition. 

First stop the daemon and disable from starting on boot: 

```
sudo service mpd stop
sudo update-rc.d mpd disable
```

***NOTE***: This will probably change as of Ubuntu 11.04 (Natty) the `MPD` daemon is not yet an [upstart service yet](http://askubuntu.com/questions/19320/whats-the-recommend-way-to-enable-disable-services/20347#20347). 

Create a directory for the `mpd` files and the playlists: 

```
mkdir -p ~/.mpd/playlists
```

Copy the MPD configuration file to the home folder: 

```
gunzip -c /usr/share/doc/mpd/examples/mpd.conf.gz > ~/.mpd/mpd.conf
```

Create all of the requisite files:  

```
touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}
```

Edit the configuration file to direct to the local MPD files:  

```
gedit ~/.mpd/mpd.conf
```

```
playlist_directory "/home/user/.mpd/playlists"   # Cannot use ~/
db_file            "/home/user/.mpd/mpd.db"
log_file           "/home/user/.mpd/mpd.log"
pid_file           "/home/user/.mpd/mpd.pid"
state_file         "/home/user/.mpd/mpdstate"
```

The **music_directory** isn't required to be specified unless the music directory is in another place besides **/home/user/Music**. 

Comment the user line (unnecessary/unwanted if using as a non-daemon): 

```
#user       "mpd"
```

Comment out `alsa` `audio_output` section, select `Pulse` section: 

```
audio_output {
  type    "pulse"
  name    "MPD"                                                                 
# server    "remote_server"   # optional
# sink    "remote_server_sink"  # optional
}
```

Create a `desktop` file for `MPD` to have `MPD` load on log in: 

```
gedit ~/.config/autostart/mpd.desktop
```

and add: 

```
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Music Player Daemon
Comment=Server for playing audio files
Exec=mpd
StartupNotify=false
Terminal=false
Hidden=false
```

Now the `MPD` daemon will run in the background and a `MPD` music client can connect to it; until then `mpd` can be started by running `mpd` from the command line. 

### Bugfix: Pausing loses connection with Pulse server

This is a bug the occurs with Pulse when pausing a track and trying to play  it again that the `MPD` client will show that the track is playing but no  sound is heard (skipping to will resume contact with the Pulse sound  server, or stopping and playing will as well).  This bug effects `pulseaudio-1:09.22` and possibly later. 

To fix this modify the `MPD` configuration to use `ALSA` directly. 

In the `mpd.conf`, direct `MPD` to use `ALSA` and comment the pulse section if previously specified: 

```
audio_output {
  type    "alsa"
  name    "Sound Card"
# device    "hw:0,0"  # optional
# format    "44100:16:2"  # optional
# mixer_device  "default" # optional
# mixer_control "PCM"   # optional
# mixer_index "0"   # optional
}
```

## Configuring `MPD` to run as a system service

By default `MPD` is configured to run as a daemon to is available to all users. 

- In the configuration, many of the default options will be what is  required; however, there is still some customization needed to be done. 

### Editing the configuration

Almost all of the default settings in <tt>/etc/mpd.conf</tt> can  be left untouched, but there are some things that you may want to  change.  

```
$ sudo nano /etc/mpd.conf
```

You will need to specify the music directory: 

```
music_directory  "/home/user/Music"  # or whatever your music is located
```

The audio controller will need to be defined.  First, comment the `ALSA` section: 

```
#audio_output {
#  type    "alsa"
#  name    "Sound Card"
#  device    "hw:0,0"  # optional
#  format    "44100:16:2"  # optional
#  mixer_device  "default" # optional
#  mixer_control "PCM"   # optional
#  mixer_index "0"   # optional
#}
```

Then add Pulse Audio below it (comment out, and define name `[optional]`): 

```
audio_output {
  type    "pulse"
  name    "MPD"
# server    "remote_server"   # optional
# sink    "remote_server_sink"  # optional
}
```

Sometimes there can be a problem with sound getting processed correctly and uncommenting this line might help: 

```
#mixer_type "software"
```

### Bugfix: Giving `MPD` proper permissions

Unfortunately, by default `MPD` does not have the proper permissions to access [PulseAudio](https://help.ubuntu.com/community/PulseAudio), the default audio setup on most new Ubuntu systems. If `MPD` plays for  you without these steps, then that's great, but if you can play your  songs but no sound is emitted, try the following steps. 

What we need to do is add the user `mpd` to the groups `pulse` and `pulse-access` so that it can access the audio system. 

```
$ sudo usermod -aG pulse,pulse-access mpd
```

### `MPD` starts new `pulseserver`

Unfortunately `MPD` tries to start its own `pulseaudio` server. So if you still unlucky you could try:

```
audio_output {
  type    "pulse"
  name    "MPD"
  server  "localhost"   # optional
# sink    "remote_server_sink"  # optional
}
```

Then you need to allow access. You should install `paprefs`

```
sudo apt-get install paprefs 
```

Then run it (e.g. `alt+f2` and enter `paperfs`). Click the **Network Server** tab, then check the **Enable network access to local sound devices** box, and finally check the **Don't require authentication** box. At this point make sure to restart the `pulseaudio` daemon. 

```
sudo service pulseaudio restart
```

Now you should see `MPD` in Sound settings **Application** tab and hear music.

## [Prevent `mpd` from starting on boot in Ubuntu 14.04](https://yanhan.github.io/posts/2016-04-10-how-to-prevent-mpd-from-starting-on-boot-on-ubuntu-1404.html)

After installing mpd via `sudo apt-get install mpd`, mpd starts as a service on boot under the `mpd` user. To prevent mpd from starting as a service on boot, we have to run:

```
sudo update-rc.d mpd disable
```

But after doing this, for some reason, mpd still runs on my machine but this time, as my user, because the `~/.mpdconf` file exists. Moving it away solved the problem. Oh, in case you were thinking a `sudo service mpd stop` will solve the problem, it does not, because mpd is not being run as a service on startup.

Even though I found out that the issue lies with the existence of `~/.mpdconf`, a glance at `man mpd` shows the following line:

```
MPD searches for a config file in $XDG_CONFIG_HOME/mpd/mpd.conf then ~/.mpdconf then /etc/mpd.conf or uses CONF_FILE.
```

So it seems that other than `~/.mpdconf`, if `$XDG_CONFIG_HOME/mpd/mpd.conf` is present, it could cause mpd to start as my user as well. I moved my mpd config file over to `$XDG_CONFIG_HOME/mpd/mpd.conf`, rebooted my system and found that indeed that is the case. Hence these 2 files:

```
~/.mpdconf
$XDG_CONFIG_HOME/mpd/mpd.conf
```

must not be present in order to prevent mpd from starting as the user on boot.