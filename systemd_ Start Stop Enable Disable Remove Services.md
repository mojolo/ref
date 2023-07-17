



## [How to remove systemd services](https://superuser.com/questions/513159/how-to-remove-systemd-services)

My recipe for service obliteration (be careful with the `rm` statements!)

```
systemctl stop [servicename]
systemctl disable [servicename]
rm /etc/systemd/system/[servicename]
rm /etc/systemd/system/[servicename] symlinks that might be related
systemctl daemon-reload
systemctl reset-failed
```

> ```
> reset-failed [PATTERN...]
> ```
>
> Reset the "failed" state of the specified units, or if no unit name             is passed, reset the state of all units. When a unit fails in some             way (i.e. process exiting with non-zero error code, terminating             abnormally or timing out), it will automatically enter the "failed"             state and its exit code and status is recorded for introspection by             the administrator until the service is restarted or reset with this             command.

It is possible that the `systemd` service "*wraps*" the old style scripts in `/etc/init.d`, so you may want to clean that up too, but that is *not* where `systemd` services live.

---

Be aware that there are multiple locations where `Systemd` unit files are stored, notably `/usr/lib/systemd/system` and also  `/etc/systemd/system/`. For reference see: [access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/…](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/chap-Managing_Services_with_systemd.html#tabl-Managing_Services_with_systemd-Introduction-Units-Locations)

---

I had also to remove `/etc/init.d/[servicename]` before running `systemctl reset-failed`

---

Right, I forgot to disable before removing the unit files. BTW, to find all unit files to remove, I inspect the output of `systemctl cat [servicename]`

---

It may be a "*wrapped*" old style script in  `/etc/init.d/` but if you don't remove it you will find it still showing up under services left over from your removal.  I can tell you that was the case for me. You could simply add that to your answer to make it  more complete but hopefully the next person that needs it will look at  the comments.

---

If your `/etc/init.d` service is  still running after removing the wrapper service, then it is configured  outside the narrow scope of this question (which is simply about  `systemd`).  If you have `sym links` from `/etc/r c*` pointing to `/etc/init.d`, then you are not running `systemd`.

---

That worked, thank you, but I am not sure why I am made to clean up this garbage manually.

---

Why doesn't `systemd` provide a command to  cleanup? `Systemd` knows how to cleanup after deleted *service and *.timer files. Why does `systemd` think users know the inner workings of the  program???

---

You may need to unmask the service, if you had it masked before, to be able to disable it: `systemctl unmask [servicename]`

---

`systemctl list-unit-files | grep enabled` will list all enabled services

---

`systemctl enable` works by manipulating `symlink`s in `/etc/systemd/system/` (for system daemons). When you `enable` a service, it looks at the `WantedBy` lines in the `[Install]` section, and plops `symlink`s in those `.wants` directories.

`systemctl disable` does the opposite.

You can just remove those `symlink`s by hand, which is fully equivalent to using `systemctl disable`.

---

You can use `systemctl start ServiceName.service` and `systemctl stop Service.Name.service` to start and stop a service respectively. In contrast to `systemctl enable ...` and `systemctl disable ...`, the start and stop commands only last for the current session,  therefore when you reboot the machine the changes wont be saved.

---

### Removing a service from `systemd`

Systemd uses unit (file to define services) to remove a service the  unit have to be removed... here is a list of unit locations :

```
/etc/systemd/system/ (and sub directories)
/usr/local/etc/systemd/system/ (and sub directories)
~/.config/systemd/user/ (and sub directories)
/usr/lib/systemd/ (and sub directories)
/usr/local/lib/systemd/ (and sub directories)
/etc/init.d/ (Converted old service system)
```

### Refresh `systemd`

```
systemctl daemon-reload
systemctl reset-failed
```

**Ghost services (not-found) :**

`Systemd` can list ghost (not-found) services even if the unit is deleted for many reasons

1. unit still present on one of the systemd directory 
2. unit does not exit but a file link is still present on one of the systemd directory
3. the service is used in other unit(s)*

(*) if a service is mentioned in other unit but does not exist  systemd will still list that service with the state not-found even if  there is not unit file... you can search what unit is using that service with a text search and edit those units (not recommended if you plan to install that service later)

---

### Remove dangling `symlink`s

Look at the output of:

```
ls -l /etc/systemd/system/multi-user.target.wants
```

and delete any dangling `symlink`s for that `.service`

---

### Upstart

```
# update-rc.d [servicename] stop
# update-rc.d foo stop
```



```
# update-rc.d [servicename] disable
# update-rc.d apache2 disable
```

* If you want to specify run levels:

  ```
  # update-rc.d [servicename] disable|enable [S|2|3|4|5]
  ```

  

```
# update-rc.d -f [servicename] remove
# update-rc.d -f sunrpc remove
```



```
sudo service [servicename] restart
```