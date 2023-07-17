



# [Lowering Mouse Sensitivity in Ubuntu and Fedora](https://patrickmn.com/aside/lowering-gaming-mouse-sensitivity-in-ubuntu-9-10/)

February 5, 2010 - Confirmed to still work as of April 2017

I have a Razer Deathadder. It’s a nice gaming mouse. In Ubuntu its  polling rates are through the roof, though, and the mouse is pretty much unusable even with the mouse sensitivity and acceleration settings at  their lowest.

Here’s how I regained my sanity and mouse slowness. This fix should  work for any mouse (tested with many different mouse brands, including Logitech.)

## Fix for Ubuntu 17.04+ and Fedora 22+ (libinput)

1. Open a terminal

2. Run the command: `xinput --list --short`

   ```
   ⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
   ⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
   ⎜   ↳ Razer USA, Ltd DeathAdder Mouse         	id=6	[slave  pointer  (2)]
   ⎜   ↳ Razer USA, Ltd DeathAdder Mouse         	id=7	[slave  pointer  (2)]
   ⎜   ↳ Razer DeathAdder                        	id=11	[slave  pointer  (2)]
   ⎜   ↳ Macintosh mouse button emulation        	id=12	[slave  pointer  (2)]
   ⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
       ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
       ↳ Power Button                            	id=8	[slave  keyboard (3)]
       ↳ Power Button                            	id=9	[slave  keyboard (3)]
       ↳ Dell Dell USB Keyboard                  	id=10	[slave  keyboard (3)]
   ```

3. Note the name of your device. (In my case, manipulating ‘Razer DeathAdder’ worked.)

4. Set the constant deceleration and transformation matrix for the device:

   ```
   xinput --set-prop "Device Name" "libinput Accel Speed" -0.9
   xinput --set-prop "Device Name" "Coordinate Transformation Matrix" 0.6 0 0 0 0.6 0 0 0 2
   ```

The “libinput Accel Speed” number must be an integer between 1 and  -1, and appears less flexible than the old Constant Deceleration setting (below.) Playing around with the coordinate transformation matrix  numbers may also help. You may want to apply only one or both of these  changes. (Thanks to Emanuel Steen for the tip.)

------

## Fix for Ubuntu 10.04-16.10 and Fedora 12-21

1. Open a terminal

2. Run the command: `xinput --list --short`

   ```
   ⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
   ⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
   ⎜   ↳ Razer USA, Ltd DeathAdder Mouse         	id=6	[slave  pointer  (2)]
   ⎜   ↳ Razer USA, Ltd DeathAdder Mouse         	id=7	[slave  pointer  (2)]
   ⎜   ↳ Razer DeathAdder                        	id=11	[slave  pointer  (2)]
   ⎜   ↳ Macintosh mouse button emulation        	id=12	[slave  pointer  (2)]
   ⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
       ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
       ↳ Power Button                            	id=8	[slave  keyboard (3)]
       ↳ Power Button                            	id=9	[slave  keyboard (3)]
       ↳ Dell Dell USB Keyboard                  	id=10	[slave  keyboard (3)]
   ```

3. Note the name of your device. (In my case, manipulating ‘Razer DeathAdder’ worked.)

4. Set the constant deceleration for the device:

   ```
   xinput --set-prop "Razer DeathAdder" "Device Accel Constant Deceleration" 5
   ```

That’s it. You might have to play around with the value, but 5 slowed down my mouse sufficiently.

- To see the current settings for the device:

  ```
  xinput --list-props "Razer DeathAdder"
  ```

- To turn off mouse acceleration:

  ```
  xinput --set-prop "Razer DeathAdder" "Device Accel Velocity Scaling" 1
  xinput --set-prop "Razer DeathAdder" "Device Accel Profile" -1
  ```

To perform the tuning automatically, I simply created a file `fix-mouse.sh` containing the script below, ran `chmod +x fix-mouse.sh` and added it to GNOME’s Startup Applications — `gnome-session-properties`, or System -> Preferences -> Startup Applications, or the gear in  the upper-right corner -> Startup Applications in Ubuntu’s Unity.

```
#!/bin/sh
xinput --set-prop "Razer DeathAdder" "Device Accel Constant Deceleration" 5
xinput --set-prop "Razer DeathAdder" "Device Accel Velocity Scaling" 1
xinput --set-prop "Razer DeathAdder" "Device Accel Profile" -1
```

---

In Windows Logitech also recommends setting the DPI by [sliding the Mouse Pointer Speed](http://support.logitech.com/en_us/article/Set-MX-Master-mouse-sensitivity-and-pointer-speed-with-Logitech-Options?product=a0qi0000006Njj9AAC). Specifically it says:

1. Under **Pointer speed**, adjust the slider to your  preferred DPI value. The minimum value is 400 DPI. The speed can be  increased in increments of 200, up to a maximum of 1600 DPI.

------