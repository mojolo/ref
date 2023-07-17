##  [Fedora KDE without the Bloat](https://www.reddit.com/r/Fedora/comments/p0q0ya/fedora_kde_without_the_bloat/)

```bash
sudo dnf remove pim* akonadi* akregator korganizer kmail kmag kmines  kmousetool kmouth kpat kruler kamoso krdc krfb ktnef kaddressbook  konversation kf5-akonadi-server mariadb mariadb-backup mariadb-common
```

I've used the everything `iso` to install F34 kde, then deselecting all  the kde applications in there. After the initial boot I also remove the  big KDE things such as `akonadi` by running `sudo dnf autoremove \*akonadi*` . Also things such as `kget`, `kwrite` are things I don't use. Afterwards I get a pretty clean system.

Easy way is to install the KDE spin and remove stuff.

If you really want your own customized system then you will need to start  from a minimal install.  Review the list of packages that are installed  by the minimal install, remove anything you consider bloat that can be  removed.

Use `dnf grouplist` to list the available package groups.

Use `dnf groupinfo <package group name>` to see what packages a group will install and either install the group if you want all packages or  manually install the ones you want.

You will probably want to review the following groups:

1. Standard with Ansible _ 
2. Hardware Support
3. Multimedia
4. base-x
5. Fonts
6. KDE (K Desktop Environment)

If you need wifi then sort of follow the instructions in the KDE minimal install guide that was referenced earlier.

Installing packages with `--setopt=install_weak_deps=False` is your friend to limit *bloat*

If something is not working I usually install the KDE Spin to figure out  if I missed installing something.  Or just install it, get the list of  installed packages and then blow it away.  You can also use `rpm -qf  <full path to binary>` to figure out what package a binary belongs to.

## [Fedora KDE Spin Bloatware](https://www.reddit.com/r/Fedora/comments/ymvi6l/fedora_kde_spin_bloatware/)

Save to file. **NOTE**: Actually looks useful: `dnfdragora`

```
dnfdragora krusader kmouth kmag kpatience kamoso kmines kmahjongg krdc juk kaddressbook korganizer akregator ktorrent kget konversation kruler krfb kmail falkon kontact calligra-core kf5-akonadi-server k3b kpat
```



```bash
sudo dnf rm $(cat file)
```

## [Fedora-KDE-Minimal-Install-Guide](https://www.reddit.com/r/Fedora/comments/p0q0ya/fedora_kde_without_the_bloat/)

Helpful Commands

```bash
dnf grouplist (Lists all available groups to install)
dnf groupinfo "group name" (Lists all the packages and groups contained within a group. Replace group name with the actual group name)
dnf search keyword (Replace keyword with the package name, word or short phrase to search for. This is used to find packages in dnf)
df -h (Lists all file systems)
```
