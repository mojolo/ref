udevrulefile=""
udev_installed=no
libsanerule=$(ls /lib/udev/rules.d/*.rules /etc/udev/rules.d/*.rules 2> /dev/null | \
    grep libsane | head --line=1)
number=$(echo $libsanerule | \
    sed s/"\/lib\/udev\/rules.d\/"//g |\
    sed s/"\/etc\/udev\/rules.d\/"//g |\
    head --bytes=2)
chk=$(echo $number | grep "[0-9][0-9]")
if [ "$chk" = '' ];then
    libsanerule=$(ls /lib/udev/rules.d/*.rules /etc/udev/rules.d/*.rules 2> /dev/null | \
	grep sane-backends | head --line=1)
    number=$(echo $libsanerule | \
	sed s/"\/lib\/udev\/rules.d\/"//g |\
        sed s/"\/etc\/udev\/rules.d\/"//g |\
        head --bytes=2)
    chk=$(echo $number | grep "[0-9][0-9]")
fi
if [ "$chk" = '' ];then
    number=50
fi


####
udevrulefile="/etc/udev/rules.d/${number}-brother-brscan4-libsane-type1.rules"
cat <<  %%_UDEV_RULE_%% > $udevrulefile
#
#   udev rules 
#

ACTION!="add", GOTO="brother_mfp_end"
SUBSYSTEM=="usb", GOTO="brother_mfp_udev_1"
SUBSYSTEM!="usb_device", GOTO="brother_mfp_end"
LABEL="brother_mfp_udev_1"
SYSFS{idVendor}=="04f9", GOTO="brother_mfp_udev_2"
ATTRS{idVendor}=="04f9", GOTO="brother_mfp_udev_2"
GOTO="brother_mfp_end"
LABEL="brother_mfp_udev_2"
ATTRS{bInterfaceClass}!="0ff", GOTO="brother_mfp_end"
ATTRS{bInterfaceSubClass}!="0ff", GOTO="brother_mfp_end"
ATTRS{bInterfaceProtocol}!="0ff", GOTO="brother_mfp_end"
#MODE="0666"
#GROUP="scanner"
ENV{libsane_matched}="yes"
#SYMLINK+="scanner-%k"
LABEL="brother_mfp_end"
%%_UDEV_RULE_%%
####
chmod 755    $udevrulefile

echo "#! /bin/sh"  > /opt/brother/scanner/brscan4/udev_uninstall.sh
echo "rm $udevrulefile"  >> /opt/brother/scanner/brscan4/udev_uninstall.sh
echo "exit 0"  >> /opt/brother/scanner/brscan4/udev_uninstall.sh
chmod 755 /opt/brother/scanner/brscan4/udev_uninstall.sh

exit 0
