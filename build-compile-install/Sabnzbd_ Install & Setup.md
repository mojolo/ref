JCFP maintains an unofficial repository with the latest version of SABnzbd[1](https://sabnzbd.org/wiki/installation/install-ubuntu-repo#toc4). Whenever an even newer version of the program is released, you will be  automatically notified the same as with any other package update.

There are two channels on offer: regular or `nobetas`. The former includes most alpha/beta/rc releases, while the latter is a less risky option that only ever gets final releases. In order to satisfy  all dependencies, both Ubuntu's universe and multiverse repositories  must be enabled on your system.

First, some preparation to make sure your system can handle extra repositories:

```
sudo apt-get install software-properties-common
```

Then, make sure multiverse and universe are enabled:

```
sudo add-apt-repository multiverse
sudo add-apt-repository universe
```

Now add the repository. Choose either the `nobetas` channel, to receive **only final stable releases**:

```
sudo add-apt-repository ppa:jcfp/nobetas
```

**Or** if you wish to recieve alpha/beta/rc releases, go for the regular option:

```
sudo add-apt-repository ppa:jcfp/ppa
```

Next, we add the repository with [SABYenc](https://sabnzbd.org/wiki/installation/sabyenc.html), tell `apt` to update so it learns of the new packages and proceed to install the program and its dependencies:

```
sudo add-apt-repository ppa:jcfp/sab-addons
sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install sabnzbdplus python-sabyenc
```

Optionally, you can also install [Multicore Par2](https://sabnzbd.org/wiki/installation/multicore-par2) by executing:

```
sudo apt-get install par2-tbb
```



## How To Start

To start the program, find the Sabnzbd+ item in the Networking  section of your desktop menu, or from the command line just execute:

```
sabnzbdplus
```

You should run SABnzbd as a normal user: the program does not need root access or any other special permissions.



## Configure `SABnzbd` to run as a service

Edit `/etc/default/sabnzbdplus` and fill in USER, HOST and PORT as follows. Replace `$USER` with your actual username.

```
USER=$USER
HOST=0.0.0.0
PORT=8080
```

Restart the service:

```
sudo service sabnzbdplus restart
```



## How To Run as a Service

If you want the program to be started as a service (i.e., in the background on system boot), edit (as root) the text file `/etc/default/sabnzbdplus` and set the required `USER= ` and the optional settings to your liking. If your system uses systemd, which has been the default since Ubuntu 15.04, run `sudo systemctl daemon-reload` after modifying the settings.

Once configured correctly, the service can be started and stopped with the usual commands:

```
sudo service sabnzbdplus start
```

and

```
sudo service sabnzbdplus stop
```

Although for obvious reasons no browser is auto-started when running  the program like this, the web interface is still available at the usual location of `http://localhost:8080/sabnzbd/` (or whatever other host and port you configured).



