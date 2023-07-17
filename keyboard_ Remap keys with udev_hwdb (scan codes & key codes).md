

## Intro

Key mappings can be changed using xmodmap in the Xorg layer. Sometimes, it did not work well and mappings should be changed whenever my keyboard was changed. I wanted to change the mapping in the lower level. udev gave me a solution.

## Find your device

First, you need to find your keyboard device. I used my usb keyboard, the Fnatic miniSTREAK.

With the `cat /proc/bus/input/devices` command, you can confirm the information of your keyboard. In my case, the output was like below.

```
I: Bus=0003 Vendor=2f0e Product=0102 Version=0111
N: Name="Fnatic Gear Fnatic Gear miniSTREAK Keyboard"
P: Phys=usb-0000:00:14.0-3.4/input0
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.4/3-3.4:1.0/0003:2F0E:0102.0005/input/input9
U: Uniq=D30F10B00288E2FA0ECB41B57CB1005F
H: Handlers=sysrq kbd event8 leds 
B: PROP=0
B: EV=120013
B: KEY=1000000000007 ff800000000007ff febeffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=1f
```

***NOTE***: Bus, Vendor, Product and Handlers (`event7`) will be used in the following steps.



#### Alternate Method

Another method is to use `evtest`. If it is not installed in you system, install it with `sudo apt install evtest` (Ubuntu) or `sudo dnf install evtest` (Fedora).

Running `evtest` requires an event path as a parameter. The path is something like `/dev/input/eventX` where `X` is the Handler number that we could find in the Section 1.

```
# evtest
```

```
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/...
...
/dev/input/event7:	Logitech USB Laser Mouse
/dev/input/event8:	Fnatic Gear Fnatic Gear miniSTREAK Keyboard
/dev/input/event9:	Fnatic Gear Fnatic Gear miniSTREAK Consumer Control
/dev/input/...
...
Select the device event number [0-31]:
```

```
Select the device event number [0-31]: 8
```

```
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x2f0e product 0x102 version 0x111
Input device name: "Fnatic Gear Fnatic Gear miniSTREAK Keyboard"
...
Properties:
Testing ... (interrupt to exit)

```



## Find scan codes of relevant keys

Second, we need to grasp the `scancode` and the `keycode` of the key to be remapped. In my case, I wanted to map `RIGHTMETA` key to `HANJA` key *(FYI, `HANJA` key is required in Korean keyboard)*.

`evtest` was used to get the key information.

```
# evtest /dev/input/event8
```

After running `evtest` with proper path, your prompt will wait for your keyboard input. Just type the key that you are interested  in. The prompt will show you the information of the key you typed.

E.g., a line like the following one (with `MSC_SCAN` in it) should be output:

```
Event: time 1417131619.686259, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70068
```

followed by a second one giving the current key code. If no `MSC_SCAN` line is output, this is due to a kernel driver bug, but the scancode can still be found with the `input-kbd` utility; `evtest` should have given the key code, so that it should be easy to find the corresponding line in the `input-kbd` output (e.g. by using `grep`).

Remember the values (e.g., `70042`). They will be used in the next step.

Here is the output for the Fnatic keyboard keys we are interested in:

```
...
Event: time 1579981486.237046, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70042
Event: time 1579981486.237046, type 1 (EV_KEY), code 67 (KEY_F9), value 1
Event: time 1579981486.237046, -------------- SYN_REPORT ------------
Event: time 1579981486.335040, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70042
Event: time 1579981486.335040, type 1 (EV_KEY), code 67 (KEY_F9), value 0
Event: time 1579981486.335040, -------------- SYN_REPORT ------------
Event: time 1579981537.879502, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70047
Event: time 1579981537.879502, type 1 (EV_KEY), code 70 (KEY_SCROLLLOCK), value 1
Event: time 1579981537.879502, -------------- SYN_REPORT ------------
Event: time 1579981537.958456, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70047
Event: time 1579981537.958456, type 1 (EV_KEY), code 70 (KEY_SCROLLLOCK), value 0
Event: time 1579981537.958456, -------------- SYN_REPORT ------------
Event: time 1579981557.792280, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70048
Event: time 1579981557.792280, type 1 (EV_KEY), code 119 (KEY_PAUSE), value 1
Event: time 1579981557.792280, -------------- SYN_REPORT ------------
Event: time 1579981557.859267, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70048
Event: time 1579981557.859267, type 1 (EV_KEY), code 119 (KEY_PAUSE), value 0
Event: time 1579981557.859267, -------------- SYN_REPORT ------------
Event: time 1579981573.631091, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70049
Event: time 1579981573.631091, type 1 (EV_KEY), code 110 (KEY_INSERT), value 1
Event: time 1579981573.631091, -------------- SYN_REPORT ------------
Event: time 1579981573.695036, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70049
Event: time 1579981573.695036, type 1 (EV_KEY), code 110 (KEY_INSERT), value 0
Event: time 1579981573.695036, -------------- SYN_REPORT ------------
Event: time 1579981588.711933, type 4 (EV_MSC), code 4 (MSC_SCAN), value 7004b
Event: time 1579981588.711933, type 1 (EV_KEY), code 104 (KEY_PAGEUP), value 1
Event: time 1579981588.711933, -------------- SYN_REPORT ------------
Event: time 1579981588.770884, type 4 (EV_MSC), code 4 (MSC_SCAN), value 7004b
Event: time 1579981588.770884, type 1 (EV_KEY), code 104 (KEY_PAGEUP), value 0
Event: time 1579981588.770884, -------------- SYN_REPORT ------------
Event: time 1579981608.465713, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70040
Event: time 1579981608.465713, type 1 (EV_KEY), code 65 (KEY_F7), value 1
Event: time 1579981608.465713, -------------- SYN_REPORT ------------
Event: time 1579981608.527665, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70040
Event: time 1579981608.527665, type 1 (EV_KEY), code 65 (KEY_F7), value 0
Event: time 1579981608.527665, -------------- SYN_REPORT ------------
Event: time 1579981641.117330, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70041
Event: time 1579981641.117330, type 1 (EV_KEY), code 66 (KEY_F8), value 1
Event: time 1579981641.117330, -------------- SYN_REPORT ------------
Event: time 1579981641.190326, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70041
Event: time 1579981641.190326, type 1 (EV_KEY), code 66 (KEY_F8), value 0
Event: time 1579981641.190326, -------------- SYN_REPORT ------------
Event: time 1579981657.372168, type 4 (EV_MSC), code 4 (MSC_SCAN), value 7004e
Event: time 1579981657.372168, type 1 (EV_KEY), code 109 (KEY_PAGEDOWN), value 1
Event: time 1579981657.372168, -------------- SYN_REPORT ------------
Event: time 1579981657.452167, type 4 (EV_MSC), code 4 (MSC_SCAN), value 7004e
Event: time 1579981657.452167, type 1 (EV_KEY), code 109 (KEY_PAGEDOWN), value 0
Event: time 1579981657.452167, -------------- SYN_REPORT ------------
Event: time 1579981677.171946, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70043
Event: time 1579981677.171946, type 1 (EV_KEY), code 68 (KEY_F10), value 1
Event: time 1579981677.171946, -------------- SYN_REPORT ------------
Event: time 1579981677.266824, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70043
Event: time 1579981677.266824, type 1 (EV_KEY), code 68 (KEY_F10), value 0
...
```



## Write configuration file

Once the scancodes of the keys to be remapped have been determined, create a config file with the remappings, such as:

```
/etc/udev/hwdb.d/98-fnatic-ministreak.hwdb
```

Note that the file may be created in any of these paths: `/usr/lib/udev/hwdb.d/`, `/run/udev/hwdb.d/`, `/etc/udev/hwdb.d/`. `/etc/udev/hwdb.d` is the most common location, and it applies the remappings at the system level (for all users).

> ***NOTE***: the default mapping file, which contains diverse keyboard mappings, is `/usr/lib/udev/hwdb.d/60-keyboard.hwdb`. It contains helpful information about the file contents/formatting.



Write the key mapping configuration. First you need to select a device. The format is like below.

```
evdev:input:b<bus_id>v<vendor_id>p<product_id>e<version_id>-<modalias>
```

`<bus_id>`, `<vendor_id>` and `<product_id>` were obtained in Section 1.

If you want to change all the usb keyboard, use following configuration instead:

```
keyboard:usb:v*p*
```



After the above device selection line, key mappings are described. The format is:

```
 KEYBOARD_KEY_<scan_code>=<key_code>
```

* `<scan_code>` is the value we got with `evtest``

* `<key_code>` is the **lowercase name string** of the key to be mapped.

`evtest` shows the whole key mapping information as below:

```
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
    Event code 5 (KEY_4)
    Event code 6 (KEY_5)
    Event code 7 (KEY_6)
    Event code 8 (KEY_7)
    Event code 9 (KEY_8)
    Event code 10 (KEY_9)
    Event code 11 (KEY_0)
    Event code 12 (KEY_MINUS)
    Event code 13 (KEY_EQUAL)
    Event code 14 (KEY_BACKSPACE)
    Event code 15 (KEY_TAB)
    Event code 16 (KEY_Q)
    Event code 17 (KEY_W)
    Event code 18 (KEY_E)
    Event code 19 (KEY_R)
    Event code 20 (KEY_T)
    Event code 21 (KEY_Y)
    Event code 22 (KEY_U)
    Event code 23 (KEY_I)
    Event code 24 (KEY_O)
    Event code 25 (KEY_P)
    Event code 26 (KEY_LEFTBRACE)
    Event code 27 (KEY_RIGHTBRACE)
    Event code 28 (KEY_ENTER)
    Event code 29 (KEY_LEFTCTRL)
    Event code 30 (KEY_A)
    Event code 31 (KEY_S)
    Event code 32 (KEY_D)
    Event code 33 (KEY_F)
    Event code 34 (KEY_G)
    Event code 35 (KEY_H)
    Event code 36 (KEY_J)
    Event code 37 (KEY_K)
    Event code 38 (KEY_L)
    Event code 39 (KEY_SEMICOLON)
    Event code 40 (KEY_APOSTROPHE)
    Event code 41 (KEY_GRAVE)
    Event code 42 (KEY_LEFTSHIFT)
    Event code 43 (KEY_BACKSLASH)
    Event code 44 (KEY_Z)
    Event code 45 (KEY_X)
    Event code 46 (KEY_C)
    Event code 47 (KEY_V)
    Event code 48 (KEY_B)
    Event code 49 (KEY_N)
    Event code 50 (KEY_M)
    Event code 51 (KEY_COMMA)
    Event code 52 (KEY_DOT)
    Event code 53 (KEY_SLASH)
    Event code 54 (KEY_RIGHTSHIFT)
    Event code 55 (KEY_KPASTERISK)
    Event code 56 (KEY_LEFTALT)
    Event code 57 (KEY_SPACE)
    Event code 58 (KEY_CAPSLOCK)
    Event code 59 (KEY_F1)
    Event code 60 (KEY_F2)
    Event code 61 (KEY_F3)
    Event code 62 (KEY_F4)
    Event code 63 (KEY_F5)
    Event code 64 (KEY_F6)
    Event code 65 (KEY_F7)
    Event code 66 (KEY_F8)
    Event code 67 (KEY_F9)
    Event code 68 (KEY_F10)
    Event code 69 (KEY_NUMLOCK)
    Event code 70 (KEY_SCROLLLOCK)
    Event code 71 (KEY_KP7)
    Event code 72 (KEY_KP8)
    Event code 73 (KEY_KP9)
    Event code 74 (KEY_KPMINUS)
    Event code 75 (KEY_KP4)
    Event code 76 (KEY_KP5)
    Event code 77 (KEY_KP6)
    Event code 78 (KEY_KPPLUS)
    Event code 79 (KEY_KP1)
    Event code 80 (KEY_KP2)
    Event code 81 (KEY_KP3)
    Event code 82 (KEY_KP0)
    Event code 83 (KEY_KPDOT)
    Event code 85 (KEY_ZENKAKUHANKAKU)
    Event code 86 (KEY_102ND)
    Event code 87 (KEY_F11)
    Event code 88 (KEY_F12)
    Event code 89 (KEY_RO)
    Event code 90 (KEY_KATAKANA)
    Event code 91 (KEY_HIRAGANA)
    Event code 92 (KEY_HENKAN)
    Event code 93 (KEY_KATAKANAHIRAGANA)
    Event code 94 (KEY_MUHENKAN)
    Event code 95 (KEY_KPJPCOMMA)
    Event code 96 (KEY_KPENTER)
    Event code 97 (KEY_RIGHTCTRL)
    Event code 98 (KEY_KPSLASH)
    Event code 99 (KEY_SYSRQ)
    Event code 100 (KEY_RIGHTALT)
    Event code 102 (KEY_HOME)
    Event code 103 (KEY_UP)
    Event code 104 (KEY_PAGEUP)
    Event code 105 (KEY_LEFT)
    Event code 106 (KEY_RIGHT)
    Event code 107 (KEY_END)
    Event code 108 (KEY_DOWN)
    Event code 109 (KEY_PAGEDOWN)
    Event code 110 (KEY_INSERT)
    Event code 111 (KEY_DELETE)
    Event code 113 (KEY_MUTE)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    Event code 116 (KEY_POWER)
    Event code 117 (KEY_KPEQUAL)
    Event code 119 (KEY_PAUSE)
    Event code 121 (KEY_KPCOMMA)
    Event code 122 (KEY_HANGUEL)
    Event code 123 (KEY_HANJA)
    Event code 124 (KEY_YEN)
    Event code 125 (KEY_LEFTMETA)
    Event code 126 (KEY_RIGHTMETA)
    Event code 127 (KEY_COMPOSE)
    Event code 128 (KEY_STOP)
    Event code 129 (KEY_AGAIN)
    Event code 130 (KEY_PROPS)
    Event code 131 (KEY_UNDO)
    Event code 132 (KEY_FRONT)
    Event code 133 (KEY_COPY)
    Event code 134 (KEY_OPEN)
    Event code 135 (KEY_PASTE)
    Event code 136 (KEY_FIND)
    Event code 137 (KEY_CUT)
    Event code 138 (KEY_HELP)
    Event code 183 (KEY_F13)
    Event code 184 (KEY_F14)
    Event code 185 (KEY_F15)
    Event code 186 (KEY_F16)
    Event code 187 (KEY_F17)
    Event code 188 (KEY_F18)
    Event code 189 (KEY_F19)
    Event code 190 (KEY_F20)
    Event code 191 (KEY_F21)
    Event code 192 (KEY_F22)
    Event code 193 (KEY_F23)
    Event code 194 (KEY_F24)
    Event code 240 (KEY_UNKNOWN)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML) state 0
    Event code 1 (LED_CAPSL) state 0
    Event code 2 (LED_SCROLLL) state 0
    Event code 3 (LED_COMPOSE) state 0
    Event code 4 (LED_KANA) state 0
Key repeat handling:
  Repeat type 20 (EV_REP)
    Repeat code 0 (REP_DELAY)
      Value    250
    Repeat code 1 (REP_PERIOD)
      Value     33
...
```



Example: `<bus_id>=0003`, `<vendor_id>=2F0E`, `<product_id>=0102`, `<scan_code>=700e7`, `<key_code>=hanja`

```
evdev:input:b0003v2F0Ep0102*
 KEYBOARD_KEY_70047=f14         # UprRightDOWN (ScrollLock): F14
 KEYBOARD_KEY_70048=f15         # UprRightUP (Pause): F15
 KEYBOARD_KEY_70040=f16         # WinPadTOPRIGHT (F7): F16
 KEYBOARD_KEY_70041=f17         # WinPadBOTLEFT (F8): F17
 KEYBOARD_KEY_70043=f18         # WinPadBOTRIGHT (F10): F18
```

* The `evdev:` string must be at the beginning of the line.
* The letters in the vendor and product id ***MUST*** be capital letters.
* Each `KEYBOARD_KEY_` settings should have exactly one space  before (note: a line with no spaces will give an error message, and a  line with two spaces were *silently* ignored with old `udev` versions).
* `KEYBOARD_KEY_` is followed by the scancode in hexadecimal (like what both `evtest` and `input-kbd` give).
  Valid values could be obtained from either the `evtest` output or the `input-kbd` output, or even from the `/usr/include/linux/input.h` file: for instance, `KEY_102ND` would give `102nd` (by removing `KEY_` and converting to lower case), which I used above.
* You can add more lines of key mappings continuously.

***NOTE***: Before `udev` v220, I had to use `keyboard:usb:v05ACp0221*` for the first line.



## Apply your config

After saving the `.hwdb` file, you need to apply the configuration to your system.

Update `hwdb.bin` file with the written configuration file. Re-build the `hwdb.bin` database `/etc/udev/hwdb.bin` with your newly created config file (you can check `hwdb.bin`'s timestamp to confim).

```
# udevadm hwdb --update
```

or

```
# systemd-hwdb update
```



Reload the `hwdb.bin` file to your system:

```
# udevadm trigger
```

or

```
# udevadm trigger --sysname-match="event*"
```



***NOTE***: In 2014, the released udev had incomplete/buggy information in `/lib/udev/hwdb.d/60-keyboard.hwdb`, but you can look at [the latest development version of the file](https://cgit.freedesktop.org/systemd/systemd/tree/hwdb/60-keyboard.hwdb) and/or [my bug report and discussion](https://bugs.freedesktop.org/show_bug.cgi?id=82311) concerning the documentation and spacing issues.

If this doesn't work, the problem might be found after temporarily increasing the log level of `udevd` with `udevadm control` (see the udevadm(8) man page for details).

For old `udev` versions such as v204, [this method](https://www.vinc17.net/unix/xkb.en.html#udev) should still work.



## Confirm the key mapping

Just check if the key works as you wanted.

or

You can check with `evtest`.

or

```
udevadm info /dev/input/by-path/*-usb-*-kbd | grep KEYBOARD_KEY
```

or

```
udevadm info /dev/input/eventX | grep KEYBOARD_KEY
```

will show the applied key mappings. `eventX` should be yours.

Done.



---

For the `evdev:input:bZZZZvYYYYpXXXX`, `ZZZZ`, `YYYY` and `XXXX` and are the 4-digit hex <u>***UPPERCASE***</u> bus, vendor and product ID (they are explained in `/lib/udev/hwdb.d/60-keyboard.hwdb`). To obtain these values of your keyboard, first use `evtest` to identify the event number `eventX` of it, then check files under `/sys/class/input/eventX/device/id/`.

Note that is is necessary to use the format `evdev:input:b*v*p*` since `udev` v220. [unix.stackexchange.com/a/216811/168688](https://unix.stackexchange.com/a/216811/168688)

---

Thanks for the reminder about the change in `udev` v220; I've now updated my answer (I forgot to do this when I updated my config). `70039` is here the scancode, and 58 (event code) is the  keycode; for instance, you can use "***58***" instead of "***capslock***" (in the  past, I had to use "***86***" instead of "***102nd***" due to [this bug](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=654947)). Note that the scancodes depend on the keyboard.

---

I used `evdev:input:b*v*p*` directly so I did not need to figure out the specific values to fill in to identify my keyboard.

---

When I run the udevadm commands, the file that gets updated is `/lib/udev/hwdb.bin`, I looked with `bless` and the `KEYBOARD_KEY_70085` appears at its end. I think ubuntu 14.04 is configured (protected?) this way. I tried `udevadm control --log-priority=debug`. based on `lsusb` (`045e:0750`) my keyboard gets like `keyboard:usb:v045ep0750*`, but I tried with `keyboard:usb:v*p*` too. My guess is this `/etc/udev/hwdb.bin` should be updated but doesnt even exist.

As I read [here](http://www.freedesktop.org/software/systemd/man/udevadm.html) it could be like I was using this command `udevadm hwdb --usr --update`, despite I was not.

Then, after `udevadm hwdb --update` I copied `/lib/udev/hwdb.bin` to `/etc/udev/hwdb.bin` and ran `strace udevadm trigger --sysname-match="event*"` and the file `hwdb.bin` seems have not been read by it (if it is like this works).

Since it works for others, my guess is my system is bugged (as this functionality seems somewhat bugged), as soon I can, I  will see if I can upgrade my packages and may be this can work! my `udevadm --version` is v204 btw.

---

Yes, there may be an Ubuntu specific bug (I'm using Debian/unstable). To see whether the database is read when doing `udevadm trigger ...`, see [my test here](https://bugs.freedesktop.org/show_bug.cgi?id=82311#c6). Note that before running `udevadm trigger ...`, you need to make sure that the modification time of the file has been  updated, otherwise the access time will not be updated when the file is  read.

---

oh, while I was testing, I checked if the hwdb.bin was being updated with `bless` hexeditor; I saw at its end the `KEYBOARD_KEY_70085` that I was trying to remap had been written there. And that file had  its timestamp updated! :). it really looks like a bug or a limitation  here. What is your `udevadm --version`?

btw, I did not reboot as I need this to be  changeable without rebooting, on the fly. May be this is intended to  only work with a reboot?

---

`udevadm --version`: 215 (and `udev` package version: 215-7). Thanks to `udevadm trigger ...`, you shouldn't need to reboot (unless you want to remove settings,  AFAIK). But you may want to try a reboot to see if there is any effect.

---

I think that is it, on my system the highest version possible to install thru package manager is v204! [here](http://packages.ubuntu.com/search?keywords=udev&searchon=names&exact=1&suite=all&section=all) I found that v215 is the latest `udev` and is on the `ubuntu vivid` that unfortunately is not LTS. I have to think on this, may be a  version between 204 and 215 may work and is installable without too much trouble here. May be also a fix may be provided for this v204 old version too! Thx!

---

I've added an alternate method at the end of my answer for old udev versions.

---

cool, I created this file `/etc/udev/keymaps/mykeymaps.cfg`  with `0x70085 grave`, and this file `/etc/udev/rules.d/98-my-custom-keyboard.rules` with `ACTION!="remove", SUBSYSTEMS=="usb", ENV{ID_VENDOR_ID}=="045e", ENV{ID_MODEL_ID}=="0750", RUN+="keymap $name /etc/udev/keymaps/mykeymaps.cfg"`; I saw on  the README that udev should monitor and apply such rules but nothing  happened yet, any idea? any way to force/check if it is being  read/applied?

---

I don't know why it doesn't work for you.  Still nothing after reboot? This method worked very well for me under  Debian up to `udev` v204, and when I upgraded to `udev` v215, I had to use the new `hwdb` method. Check in `dmesg` output that there's a "*New USB device found*" line corresponding to your `idVendor`/`idProduct`. If  not, this may be a kernel/driver bug. Otherwise you should see with a `udev` developer.

---

yes, I found it on `dmesg` and with `lsusb`, I think my kernel or driver is buggy or there is something else that  ubuntu does to protect the system from being easily tweaked like that  :/. As soon I can I will try a boot with a liveCD that has udev 215+ and see what happens :D.

oh btw, I would like to add that after reboot, the udev 204 says that `/etc/udev/keymaps/mykeymaps.cfg` was not found! that seems a serious bug or may be it should be  configured in some other undocumented way... Anyway, I think messing too much with a buggy app is not good idea unless on critical situations;  better is try to update it as soon I can...

---

Question: What's the difference between `KEYBOARD_KEY_70039` from `MSC_SCAN, value 70039` and `KEYBOARD_KEY_58` from `code 58 (KEY_CAPSLOCK)`

---

Note that when using evtest to get the  scancodes, the value of the EV_MSC,MSC_SCAN line is the scancode, and  the value of the EV_KEY line (the next/second line) is the keycode, and  the hwdb rule maps scancodes (former) to keycodes (latter). I got  confused because my USB keyboard gave scancodes in the form of "70032",  while my laptop gave me scancodes of the form "1d". I must have tested  wrong, and KEYBOARD_KEY_58 shouldn't have worked.