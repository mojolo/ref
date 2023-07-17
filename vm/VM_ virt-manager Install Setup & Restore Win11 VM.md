# virt-manager, libvirt, QEMU & KVM - VM Setup, Win11 Install, Backup & Restore

> #### [`libvirt` Documentation](https://libvirt.org/docs.html)
>
> > [`libvirt` Storage Management reference (Pools, Shares, Volumes, Images)](https://libvirt.org/storage.html)
> >
> > [`libvirt` Storage Pool & Volume XML Format](https://libvirt.org/formatstorage.html)
>
> #### [How To Install Windows 11 On Linux Using QEMU - Leaked ISO - Best Performance](https://www.youtube.com/watch?v=q76BqwHb7JQ)
>
> > [![How To Install Windows 11 On Linux Using QEMU - Leaked ISO - Best Performance](http://img.youtube.com/vi/q76BqwHb7JQ/0.jpg)](http://www.youtube.com/watch?v=q76BqwHb7JQ)



## Install & Setup Pre-requistes

---

> [Install Windows 11 in virtual machine using virt-manager (Raddinox)](https://raddinox.com/install-windows-11-in-virtual-machine-using-virt-manager)
>
> [How To Enable TPM 2.0 on KVM and install Windows 11 (computingforgeeks)](https://computingforgeeks.com/enable-tpm-on-kvm-and-install-windows/)
>
> [Windows 11 in Virt-Manager (linustechtips)](https://linustechtips.com/topic/1379063-windows-11-in-virt-manager/)

### Install SWTPM (Emulated TPM module), OVMF, virt-manager

> * OVMF - you need this for UEFI/secureboot.
> * SWTPM - you need this for TPM emulation.

```
# apt install ovmf swtpm swtpm-tools virt-manager virt-viewer
```

### Download Windows 11 iso and Virtio drivers

Microsoft is nice to have the Windows 11 iso on [their site](https://www.microsoft.com/en-us/software-download/windows11). Just remember that you still have to own a license to use it.

The virtio driver iso can be found over at the Fedora Projects site. [virtio-win-0.1.208.iso](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.208-1/virtio-win.iso)



---

## Creating the virtual machine

### virt-manager Create a New VM (5 Steps)

Now lets create the virtual machine ![img](https://www.raddinox.com/images/8/d/c/2/f/8dc2f5d06093744cc1bbf3c7338589a185bf4468-a01-create-virtual-machine.png) 

Just continue with local install media ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A02-local-install-media.png) 

Now browse for your Windows iso ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A03-browse-for-iso.png) 

Unless you have moved your Windows iso to a location where you already have a Storage pool, you need to click Browse Local ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A04-Browse-local.png) 

Now we can finally start browsing the filesystem for our Windows 11 iso ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A05-chose-downloads.png) 

I have not moved it, so it's in my Downloads folder. This folder  location will be set as a storage pool by virt-manager. So next time you download an iso you don't have to click Browse local, just choose the  "Downloads" storage pool. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A06-choose-windows-11-iso.png) 

No one has told my virt-manager that Windows 11 exists, so it will  automatically choose Windows 10. But that is fine, just continue. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A07-ignor-win10-forward-1.png) 

Configure CPU and Memory for the VM. About half your CPUs and half your memory should be good. I gave my virtual machine a bit more ram and 8 cores should be more than enough ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A08-set-ram-and-cpu.png) 

Create a virtual disk for the VM and set the disk size. I have no idea how much space Windows 11 will need so I will create one  100Gb disk for it. Remember that the virtual machine will only use as  much space as it needs even though I set it to 100Gb here. This size is  only what Windows will think the disk is. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A09-create-disk.png) 

I have already created a Network Bridge so virtual manager has chosen  that one by default. For now it doesn't really matter what network  device you have it can be changed later.

But it is important that you chose to `Customize configuration before install` ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A10-set-name-choose-networking.png)



---

## Customizing the new VM Configuration

### Change BIOS to UEFI (OVMF/secureboot)

* Change the firmware to UEFI (not the secboot one): OVMF_CODE_4M.fd
* Confirm chipset -- choose the default Q35.

***Note***:

> [Discussion: How to run Windows 11 in GNOME Boxes](https://comment.ctrl.blog/discussion/how-to-win11-in-gnome-boxes)

> In Debian Bookworm, in December 2022, I had to use  OVMF_CODE_4M.secboot.fd instead of OVMF_CODE.secboot.fd. More, I had to  reload the iso multiple times...

![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A12-change-to-uefi.png) 

### Add TPM 2.0

Click Add Hardware and choose TPM. If you have a real TPM module you can choose Passthrough in the Backend dropdown. I'm going to use the  emulated one. 

```
Type: Emulated
Model: CRB
Version: 2.0
```

![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A13-Add-virtual-TPM-module.png) 

### Configure CPUs - change from sockets to cores

We should research this further. The setting below uses all 8 cores of my CPU, which is good for doing CPU intensive tasks like 

Virt-manager defaults to 8 sockets, I like to change this to 8 cores. I  have no idea if this have any impact on the virtual machine.

![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A14-fix-cpu-cores.png)

### Edit XML & Improve CPU Performance

Go to XML tab. Delete:

```
    <timer name="rtc" tickpolicy="catchup"/>
    <timer name="pit" tickpolicy="delay"/>
```

Change:

`<timer name="hpet" present="no"/>` to `<timer name="hpet" present="yes"/>`



---

### Enable File/Folder Sharing

> [File Sharing with Qemu & Virt-Manger (sergeantbiggs)](https://blog.sergeantbiggs.net/posts/file-sharing-with-qemu-and-virt-manager/)

Virtiofs needs shared memory to work. This can be enabled in the hardware configuration window. Navigate to `Hardware` -> `Memory` and select `Enable shared memory`.

After that, open virt-manager and navigate to the hardware settings of the virtual machine. Click on *Add Hardware*.

![The virt-manager hardware window. The left pane contains the different categories. The right pane contains the setting for the specific category. Beneath the categore pane, there is a button called 'Add Hardware'](https://blog.sergeantbiggs.net/img/virt-manager_1.png)

Virtual Machine Manager hardware configuration window.

A dialog box should pop up. In the pane on the left, click on *Filesystem*

![The 'Add Hardware dialog'. The left pane contains a list of hardware devices that can be added. The option 'Filesystem' is selected.](https://blog.sergeantbiggs.net/img/virt-manager_2.png)

The ‘Add Hardware’ dialog window

Enter the necessary settings.

![The same window, with the apprioprate settings.](https://blog.sergeantbiggs.net/img/virt-manager_3.png)

Filesystem options

The settings are as follows:

For the *Driver*, we keep the default (virtiofs). The source path is the path on our host filesystem. The target path is a bit of a misnomer. It’s not actually a path, just an identifier that we use as a mount point in our guest file system. This will become clear when we mount the file system in the guest later.

If you want a more detailed overview of these options and some alternatives, check out the libvirt knowledge base on [virtiofs](https://libvirt.org/kbase/virtiofs.html)

#### Windows 10 Guest

Windows 10 can also use virtiofs, but it needs some additional work. First, we need to install 2 pieces of software:

- [WinFSP](https://winfsp.dev/)
- Virtio drivers

This installation can be done in two ways: manually or with chocolatey.

#### Manual install

Download `WinFSP` [here](https://winfsp.dev/rel/) and install it. The default options are fine if you just want to use the drivers.

#### Chocolatey Install

If you already have [Chocolatey](https://chocolatey.org/) installed, it’s as simple as:

```powershell
choco install virtio-drivers winfsp
```

If you don’t have Chocolatey installed, I highly recommend that you check it out. It’s a package manager for Windows that integrates quite well into the system. It makes maintaining software on Windows a lot easier! Installation instructions are [here](https://chocolatey.org/install#individual).

During the installation of the virtio-drivers it will pop up a dialog box asking if you trust the drivers. Confirm the dialog box to install them.

#### Configuration

After that, it’s a good idea to create a service for the drivers, so they are automatically loaded during system startup.

Manual:

```
> sc.exe create VirtioFsSvc binpath="C:\Program Files\VirtioWin\VioFS\virtiofs.exe" start=auto depend="WinFsp.Launcher/VirtioFsDrv" DisplayName="Virtio FS Service"
> sc.exe start VirtioFsSvc
```

Chocolatey:

```powershell
> sc.exe create VirtioFsSvc binpath="C:\ProgramData\Chocolatey\bin\virtiofs.exe" start=auto depend="WinFsp.Launcher/VirtioFsDrv" DisplayName="Virtio FS Service"
> sc.exe start VirtioFsSvc
```



---

### Replace SATA disk with Virtio disk

(*REFER TO VIDEO INSTEAD)
Should be able to just change the `SATA Disk 1` disk bus to `VirtIO`.

---

Now I want to replace the emulated SATA disk with the better virtio disk controller.

Click Add hardware again and choose Storage, click Manage... to browse for our harddrive image ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A15-add-storage-controller.png) 

select the harddrive image for this machine ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A16-choose-volume.png) 

Make sure you have changed the Bus type to VirtIO before you click Finish ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A17-change-to-virtio.png) 

We have not yet removed the default SATA disk so virt-manager will  complain that we are already using the disk image. But click Yes to  continue ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A18-use-the-disk.png) 

Now you can right-click the SATA Disk 1 and choose to remove the device. Don't click the Delete associated storage files, because that will  remove the hard disk image we are now using for the VirtIO disk. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A19-remove-SATA-disk.png)

### Add 2nd CD-Rom device for virtio drivers iso

Because Windows install iso will be placed in the default CD rom  device we have to add a second CD Rom device for the virtio device  drivers.

Click Add Hardware again and choose Storage, this time we change the  Device type to CDROM device. Then click Manage... to browse for the  virtio drivers iso ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A21-add-cdrom-virtio.png) 

Now this time the Download storage pool exists. Select that one and browse for the virtio-win drivers iso ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A22-select-virtio-win-iso-1.png)

### Change NIC to virtio

Click on NIC. Change device model (from e100e or similar) to `virtio`

### Enable VirtIO and OpenGL 3D Acceleration

> [Running VMs with VirtIO 3D Acceleration](https://ryan.himmelwright.net/post/virtio-3d-vms/)
> [How to use OpenGL/CD Acceleration in virt-manager (has XML config as well)(askubuntu)](https://askubuntu.com/questions/1348975/how-to-use-opengl-3d-acceleration-in-virt-manager-with-ubuntu)
> [Discussion: How to run Windows 11 in GNOME Boxes (has XML config as well)(ctrl.blog)](https://comment.ctrl.blog/discussion/how-to-win11-in-gnome-boxes)

#### Spice Settings

In the settings menu, open up the *Display Spice* section.

[ ![Virt-manager's Spice settings for a VM](https://ryan.himmelwright.net/img/posts/virtio-3d-vms/display_spice_config_post.png)](https://ryan.himmelwright.net/post/virtio-3d-vms/img/posts/virtio-3d-vms/display_spice_config_post.png)

In the VM's 'Display Spice' config, select 'None' for Listen type, and check the box for `OpenGL.`

Select `Spice server` for `Type:`, and `None` for `Listen type:` (virgil only works on local VMs right now). Lastly, make sure that the `OpenGL` checkbox *is* checked. Hit `Apply`.

#### Virtio Settings

Next, select the *Video QXL/Virtio* section.

[ ![Virt-manager's Video settings for a VM](https://ryan.himmelwright.net/img/posts/virtio-3d-vms/video_config_post.png)](https://ryan.himmelwright.net/post/virtio-3d-vms/img/posts/virtio-3d-vms/video_config_post.png)

In the VM's video settings, switch to Virtio and select 3D acceleration

Switch to `Virtio` for `Model:`, and make sure to check the `3D acceleration` checkbox. That’s it! Hit apply, start up the VM, and verify that it is working.

### Ready to install

In order to install Win11 from the  `.iso` image, we may have to change Boot Options so that SATA CDROM 1 is enabled and is the primary boot device. After Win11 is installed and set-up, we can disable SATA CDROM 1 as a boot device and ensure that VirtIO Disk 1 is enabled and is the primary boot device.

Almost ready to install, click Boot Options and make sure the boot order is correct with SATA CDROM 1 first. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A22-make-sure-boot-order.png) 

Now click the small Begin Installation button in the top left corner. I  wish it was in the bottom right corner like all the other "continue"  buttons has been

 ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/A23-begin-install.png)



---

## Continue Windows Install, virtio driver .iso install

Remember to press a button to boot the installer, then just install almost as on bare hardware. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/C01-just-install-windows.png) 

Click `Custom Install`. When you are going to choose where to install you need to install the Virtio drivers. Click Load driver button. Click `Load driver` > Click `OK` and select the w11 (or w10) driver `.inf` file.

OR....

![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/C02-browse-drivers.png) Browse the second CD drive with the virtio drivers and choose the folder for Windows 10 (w10) they will work ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/C03-win10-drivers.png) 

When the drivers are installed the installer can find your virtual (VirtIO) drive. Click `Next` to continue the install process. ![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/C04-just-continue-installing.png) 



Follow the Windows install prompts.



---

## Install Windows 11 & Bypass Internet Connection

> [How to bypass internet connection to install Windows 11 (Pureinfotech)](https://pureinfotech.com/bypass-internet-connection-install-windows-11/)
> [Windows 11 on KVM - Install Step by Step (getlabsdone)](https://getlabsdone.com/how-to-install-windows-11-on-kvm/)



* On the screen where it says, let’s connect to the network, choose ***"I don’t have a network"**.*

* If ***"I don't have a network is grayed out"*** or you're just stuck at a screen asking you to connect to the internet (***"Oops, you’ve lost internet connection”*** or ***“Let’s connect you to a network”***)

  * Though MSFT wants you to connect to the internet, it cannot because the KVM Win11 VM doesn’t  have network access yet. We will fix eventually by installing the drivers, however we need to bypass this step for now.

  * For that press `Shift` + `F10` (you might need to press the function key for this to work)

  * In the command prompt enter one of the following commands and hit `Enter`.

    ```
    OOBE\BYPASSNRO
    ```

    or

    ```
    oobe\bypassnro
    ```

  ![Oobe bypassnro command](https://i0.wp.com/pureinfotech.com/wp-content/uploads/2022/02/oobe-bypassnro-wndows-11-no-internet-install.webp?resize=827%2C620&quality=78&strip=all&ssl=1)

* It will restart the system  automatically to the previous initial setup wizard screen.

* After the initial selection, you will be presented with the same screen, but this time choose ***"I don't have internet"***.

  ![Windows 11 OOBE don't have internet](https://i0.wp.com/pureinfotech.com/wp-content/uploads/2022/02/windows-11-oobe-dont-have-internet.webp?resize=827%2C620&quality=78&strip=all&ssl=1)

* On the next screen, choose to ***“Continue with limited setup”***.
  **Note**: Even if you try to connect to the network, it won’t let you connect  because you don’t have windows 11 QEMU drivers installed yet, which we  will do later.

  ![Continue with limited setup](https://i0.wp.com/pureinfotech.com/wp-content/uploads/2022/02/continue-limited-setup-windows-11.webp?resize=827%2C620&quality=78&strip=all&ssl=1)

* You will have to create a local account to begin with, enter a `username` and `password`, and you also need to setup 3 security questions  as well. 

* After that privacy settings, accept the privacy setting based on your requirement.

* Wait for a couple of minutes and you will boot into the windows successfully.



And finally we have Windows 11 installed in a virtual machine on Linux

![img](https://www.raddinox.com/user/pages/01.home/install-windows-11-in-virtual-machine-using-virt-manager/C05-finally-installed.png)



---

## Post-Install -- virtio and spice drivers in Win11

> [How to run Windows 11 in GNOME Boxes (with UEFI and TPM2 emulation) (ctrl.blog)](https://www.ctrl.blog/entry/how-to-win11-in-gnome-boxes.html)
>
> [spice-space.org/download](https://www.spice-space.org/download.html)

* The VirtIO guest agent and driver set will increase the performance of most I/O operations. Install [VirtIO guest addons](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/) (look for `virtio-win-gt-x64.msi`) on the virtio `virtio-win-0.1.208.iso`  or you can get it from Fedora website. Restart the VM afterward.
* Install `Windows SPICE Guest Tools` from [spice-space.org/download](https://www.spice-space.org/download.html) (Direct link to latest version: [`spice-guest-tools`](https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe)). This installer contains some optional drivers and services that can  be installed in the Windows guest to improve SPICE performance and  integration. This includes the qxl video driver and the SPICE guest  agent (for copy and paste, automatic resolution switching, ...)
* Enable [folder sharing](https://www.spice-space.org/spice-user-manual.html#_folder_sharing) in the Windows guest by installing [`Spice WebDAV daemon`](https://www.spice-space.org/download/windows/spice-webdavd/). Restart the VM afterwards.
* Enable auto-resizing/adaptive screen resizing and clipboard integration by installing `SPICE guest VD agent`. This package is included in `Windows SPICE Guest Tools` so no need to install again.
  *For reference:* Can also install [SPICE guest VD agent](https://www.spice-space.org/download/windows/vdagent/) (look for the newest date, then `spice-vdagent-x64.msi`) from Fedora website.. Restart the VM afterward.



---

## Autostart Default Network (network 'default' is not active)

> [KVM - Fix Missing Default Network (programster)](https://blog.programster.org/kvm-missing-default-network)

1. First check if you have the network defined by running: `# virsh net-list --all`
2. If not, read the reference page above on how to define it.
3. Assuming network 'default' is defined, start it now by running: `# virsh net-start default`
4. To have the network automatically start up in the future, run: `# virsh net-autostart --network default`



---

## Creating an `fs` partition-based storage pool

> [How to Manage KVM Storage Volumes & Pools (tecmint)](https://www.tecmint.com/manage-kvm-storage-volumes-and-pools/)

When you install KVM virtualization on your computer, a directory-based storage pool named `default` with the directory path `/var/lib/libvirt/images` will be automatically created for you. In addition to this, you can set up your own storage pool(s) to better arrange your storage volumes or ISO files.

* The (**Dir**) type is very popular as it doesn’t require many modification in current storage schema you have.
* The (**FS**) type requires pre-formatted partitions. It is useful for if you want to specify an entire partition for virtual machine  disks/storage.

**1.** We will create another storage pool using per-formatted partition that is the (**(fs)** Pre-Formatted Block Device) type. You need to prepare another new partition with desired file system.

You could use “**fdisk**” or “**parted**” to create new partition and use “**mkfs**” for formatting with new file-system. For this section, (sda6) will be our new partition.

```
# mkfs.ext4 /dev/sda6
```

Also create a new directory (i.e. **SPool2**), it acts as a mount point for the selected partition.

**2.** After selecting (fs) type from the drop-menu, next provide the name of the new pool as shown

[![Add Second Storage Pool to KVM](https://www.tecmint.com/wp-content/uploads/2015/01/Second-Storage-Pool.png)](https://www.tecmint.com/wp-content/uploads/2015/01/Second-Storage-Pool.png)
Add Second Storage Pool to KVM

**3.** In the next window, you need to provide the path of your partition ‘**/dev/sda6**‘ in our case – in the “**Source Path**” field and the path of the directory which acts as a mount point **/mnt/personal-data/SPool2** in the “**Target Path**” field.

[![Add Second Storage Path](https://www.tecmint.com/wp-content/uploads/2015/01/Add-Second-Storage-Path.png)](https://www.tecmint.com/wp-content/uploads/2015/01/Add-Second-Storage-Path.png)
Add Second Storage Path

**4.** Finally, there is a third storage pool added in the main storage list.

[![Second Storage Details](https://www.tecmint.com/wp-content/uploads/2015/01/Second-Storage-Details-620x287.png)](https://www.tecmint.com/wp-content/uploads/2015/01/Second-Storage-Details.png)
Second Storage Details



---

## Backup & Restore

> * [Correct way to move kvm vm (serverfault)](https://serverfault.com/questions/434064/correct-way-to-move-kvm-vm)
> * [Backup & Restore KVM VMs (medium)](https://schh.medium.com/backup-and-restore-kvm-vms-21c049e707c1)

### Backup VM

1. Copy the VM's disks from `/var/lib/libvirt/images` on src host to the same dir on destination host
2. On the source host run `# virsh dumpxml VMNAME > XXXX.xml` and copy this xml to the destination host

### Restore VM

1. On the destination host run `# virsh define XXXX.xml`

***Note**:*

- If the disk location differs, you need to edit the VM's xml file to reference the new image (source file) location. This is done in the devices/disk node of the xml file.
- If the VM is attached to custom defined networks, you'll need to  either edit them out of the xml on the destination host or redefine them as well 
  1. On source machine `virsh net-dumpxml NETNAME > netxml.xml`
  2. copy netxml.xml to target machine
  3. On target machine `virsh net-define netxml.xml && virsh net-start NETNAME & virsh net-autostart NETNAME`)
- After completing, resetart the libvirtd service: `# systemctl restart libvirtd`
- Then restart virt-manager



---

## Change Default Storage Pool, Path, Network?

> Quick Notes 



---

## Create New VM Using Existing Disk Image

* Can do it via GUI

* Edit the default QEMU/KVM connection.

  * Storage: Can delete default without deleting associated storage files (volumes/images)
  * Can create new default where the storage volumes/images are located (/mnt/VMs)

    > [virt-manager: changing the default storage path & vit network (colerobinson)](https://blog.wikichoon.com/2014/07/virt-manager-changing-default-storage.html)
  * Can create new pool where the Win11 and VirtIO `.iso`'s are located (/mnt/WinStor/Win11)
  * May need to re-share 

* Create new VM:

  * Step 1: Import existing disk image (browse to `.qcow2` file in default storage pool)
  * Can now choose `Microsoft Windows 11` as the OS
  * You may have another TPM device that needs to be deleted. Only use the newly created TPM v2.0 device.
