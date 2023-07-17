#!/bin/bash
#
# ************************
# * Fedora KDE Installer *
# ************************
#
# Author: EMPtyMuTeX
# Description: Installs Fedora KDE and some other stuff.
#

# Funcion VAR_SETUP. Sets up variables for the script to work properly.
function var_setup(){

    # Script vars
    FEDORA_VER="$(rpm -E %fedora)"
    GPG_FOLDER="GPG"
    GPG_FINGERPRINTS_FOLDER="$GPG_FOLDER/Fingerprints"
    GPG_KEYS_FOLDER="$GPG_FOLDER/Keys"
    LOG_FOLDER="/var/log/fedora-kde-installer"
    LOG_FILE="$LOG_FOLDER/fedora_kde_installer.log"
    SCRIPT_VER="0.1.3"
    SETUP_PATH_DIRNAME="$(dirname $0)"
    SETUP_PATH="$(cd $SETUP_PATH_DIRNAME; pwd -P)"

    # Filenames
    FILENAME_RPMFUSION_FREE="RPMFUSION-FREE"
    FILENAME_RPMFUSION_NONFREE="RPMFUSION-NONFREE"

    # Links
    LNK_RPMFUSION_FREE="https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$FEDORA_VER.noarch.rpm"

    # Package vars
    PKG_REQUIRED="NetworkManager-config-connectivity-fedora adwaita-gtk2-theme at bash-completion bind-utils bluedevil breeze-gtk breeze-icon-theme btrfs-progs cagibi cifs-utils colord-kde compsize crontabs cryptsetup cups-pk-helper cyrus-sasl dhcp-client dnsmasq dolphin dos2unix ed ethtool fprintd-pam glibc-all-langpacks gnome-keyring-pam gtk3-immodule-xim iptables iptstate irqbalance jwhois kcm_systemd kde-gtk-config kde-partitionmanager kde-print-manager kde-settings-pulseaudio kde-style-breeze kdegraphics-thumbnailers kdeplasma-addons kdialog kdnssd kf5-baloo-file kf5-kipi-plugins khotkeys kmenuedit konsole5 kscreen kscreenlocker ksshaskpass kwalletmanager5 kwebkitpart kwin lsof mailcap man-pages mcelog microcode_ctl mlocate NetworkManager-bluetooth pam-kwallet passwdqc passwdqc-utils pciutils phonon-qt5-backend-gstreamer pinentry-qt plasma-breeze plasma-desktop plasma-desktop-doc plasma-drkonqi plasma-nm plasma-nm-l2tp pipewire-utils plasma-nm-openconnect plasma-nm-openswan plasma-nm-openvpn plasma-nm-pptp plasma-nm-vpnc plasma-pa plasma-systemmonitor plasma-user-manager plasma-workspace plasma-workspace-geolocation polkit-kde psacct qt5-qtbase-gui qt5-qtdeclarative qt5-qtwebengine realmd rsync rsyslog sddm sddm-breeze sddm-kcm setroubleshoot sni-qt sssd symlinks system-config-language system-config-printer-udev time tree usbutils util-linux-user words xorg-x11-drv-libinput zip @Hardware-Support @base-x @Fonts"
    PKG_REQUIRED_EXCLUSIONS="net-tools"
    PKG_RECOMMENDED="kfind kinfocenter firewall-config kwrite ark kcalc kcharselect bzip2 wget tar gwenview spectacle PackageKit-gstreamer-plugin alsa-utils gstreamer1-plugin-openh264 gstreamer1-plugins-ugly-free pipewire-gstreamer bluez-cups foomatic foomatic-db-ppds gutenprint-cups hplip mpage paps lrzsz opensc PackageKit-command-not-found smartmontools traceroute xset xrandr"
    PKG_WIFI="NetworkManager-wifi NetworkManager-wwan wpa_supplicant wireless-tools crda iw"
    PKG_SECURITY="clamav clamav-update unhide lynis"
    PKG_WORKSTATION_REPOS="fedora-workstation-repositories"
    PKG_TOOLBOX="toolbox"
    PKG_VIRTUALIZATION="virt-manager libvirt-client"
    PKG_EMPTYMUTEX_RECOMMENDED="firefox vim git zsh firejail krita f28-backgrounds-kde f28-backgrounds-extras-kde libreoffice okular dragonplayer lm_sensors rhythmbox iotop youtube-dl p7zip p7zip-plugins"
    PKG_JAVA_RECOMMENDED="java-1.8.0-openjdk java-11-openjdk"
    PKG_RPMFUSION_FREE_RECOMMENDED="ffmpeg ffmpeg-libs gstreamer1-libav"
    PKG_RPMFUSION_NONFREE_STEAM="steam"
    PKG_RPMFUSION_NONFREE_STEAM_EXCLUSIONS="flatpak"
    PKG_RPMFUSION_NONFREE_NVIDIA="akmod-nvidia xorg-x11-drv-nvidia-cuda"

    # Repo names
    REPO_RPMFUSION_FREE="rpmfusion-free"
    REPO_RPMFUSION_NONFREE_STEAM="rpmfusion-nonfree-steam"
    REPO_RPMFUSION_NONFREE_NVIDIA="rpmfusion-nonfree-nvidia-driver"

}

# Function PRINTLN. Prints text and inserts newline character.
function println(){

    printf "$1\n"

}

# Function FLASH_TERM. Flashes the termnal when called.
function flash_term(){
    
    sleep 0.2
    printf "\e[?5h"
    sleep 0.2
    printf "\e[?5l"

}

# Function YESNO. Checks if user answers yes or no. If no, exit script.
function yesno(){
    
    read yesno
    case $yesno in
	    "y"|"Y");;
	    *)exit;;
    esac

}

# Function CHECK_ERROR. Checks $1. If it is not the expected 0, asks if user wants to continue.
function check_error(){

    [ $? != 0 ] && printf "An error has been detected. Continue? (y/N)" && flash_term && yesno
    println "Done!"

}

# Function CREATE_LOG. Creates the logfile and prints current date in it.
function create_log(){
    mkdir $LOG_FOLDER
    echo "Fedora KDE Installer Log" >> $LOG_FILE
    echo "========================" >> $LOG_FILE
    echo "Date of execution: $(date)" >> $LOG_FILE
    echo "" >> $LOG_FILE
    
    # Logs should only be read and written by root.
    chmod 600 $LOG_FILE >> $LOG_FILE

}

# Function DNF_INSTALL. Installs packages passed as parameter $1, excludes packages passed as parameter $2 and checks exit code to make
# sure everything went OK.
function dnf_install()
{
    local to_install="$1"
    local to_exclude="$2"
    
    dnf install $to_install --exclude=$to_exclude -y >> $LOG_FILE 2>&1
    check_error

}

# Function GPG_KEY_INSTALL. Install GPG Keys with fingerprint checking, which are located in the GPG folder.
# File naming and format MUST be the following: REPO_NAME-VERSION_NUMBER.
function gpg_key_install(){
    
    local REPO=$1
    local GPG_KEY="$GPG_KEYS_FOLDER/$REPO-$FEDORA_VER"
    local GPG_KEY_FINGERPRINT=$(cat "$GPG_FINGERPRINTS_FOLDER/$REPO-$FEDORA_VER")

    printf "Checking GPG key..."
    if [ $(gpg -n -q --homedir "$HOME" --import --import-options import-show $GPG_KEY | grep $GPG_KEY_FINGERPRINT) ]; then
		println "GPG key OK!" | tee -a "$LOG_FILE"
		printf "Importing key..."
		rpm --import $GPG_KEY >> $LOG_FILE 2>&1
		check_error
    else
		println "GPG key is bad! Installation aborted." | tee -a "$LOG_FILE"
		return 1;
    fi

}

# Function SDDM_SETUP. Sets up SDDM service and defaults to graphical.target
function setup_sddm(){
    printf "Enabling sddm..."
    systemctl enable sddm >> $LOG_FILE 2>&1
    check_error
    printf "Setting the systemd default to graphical.target..."
    systemctl set-default graphical.target >> $LOG_FILE 2>&1
    check_error
}

# Function INSTALL_REPO. Install and enable a repo using dnf. 
# The package path is passed using $1 and the gpg filename is
# passed through $2. 
# Note that the corresponding fingerprints and keys MUST be installed in 
# the GPG folder, otherwise this will fail.
# Then, the repo name has to be passed through $3 to enable the repo.
# This has been made like this because of "rpmfusion-nonfree" subrepos,
# which contain specific packages.
function install_repo(){

    local package="$1"
    local gpg_name="$2"
    local repo_name="$3"

    printf "Installing repo using dnf..."
    dnf_install "$package"
    
    gpg_key_install "$gpg_name"
    
    printf "Enabling repo..."
    dnf config-manager --set-enabled $repo_name
    check_error
}

# Function UPDATE_SYSTEM. Updates the system packages to the latest versions.
function update_system(){
    printf "Cleaning dnf cache..."
    dnf clean all >> $LOG_FILE 2>&1
    check_error

    printf "Updating system..."
    dnf update -y --refresh >> $LOG_FILE 2>&1
    check_error
}

# Function INSTALL_REQUIRED_PACKAGES. Installs the required packages for KDE to work.
function install_required_packages(){
    printf "Installing KDE required packages..."
    dnf_install "$PKG_REQUIRED" "$PKG_REQUIRED_EXCLUSIONS"
}

# Function INSTALL_RECOMMENDED_PACKAGES. Checks which packages have been selected and installs them.
function install_recommended_packages(){
    local params=$1

    IFS_BAK=$IFS
    IFS=', '
    params=(${params})
    IFS=$IFS_BAK
    for param in "${params[@]}"
    do
        case $param in
            1) printf "Installing recommended packages..." && dnf_install "$PKG_RECOMMENDED";;
            2) printf "Installing wifi packages..." && dnf_install "$PKG_WIFI";;
            3) printf "Installing security packages..." && dnf_install "$PKG_SECURITY";;
            4) printf "Installing workstation repositories..." && dnf_install "$PKG_WORKSTATION_REPOS";;
            5) printf "Installing toolbox..." && dnf_install "$PKG_TOOLBOX";;
            6) printf "Installing virtualization packages..." && dnf_install "$PKG_VIRTUALIZATION";;
            7) printf "Installing EMPtyMuTeX's recommended packages..." && dnf_install "$PKG_EMPTYMUTEX_RECOMMENDED";;
            8) printf "Installing Java recommended versions..." && dnf_install "$PKG_JAVA_RECOMMENDED";;
            9) println "Installing RPMFusion-Free recommended packages...";
                    install_repo "$LNK_RPMFUSION_FREE" "$FILENAME_RPMFUSION_FREE" "$REPO_RPMFUSION_FREE";
                    printf "Installing packages...";
                    dnf_install "$PKG_RPMFUSION_FREE_RECOMMENDED";;
            10) println "Installing Steam...";
                    install_repo "$PKG_WORKSTATION_REPOS" "$FILENAME_RPMFUSION_NONFREE" "$REPO_RPMFUSION_NONFREE_STEAM";
                    printf "Installing packages...";
                    dnf_install "$PKG_RPMFUSION_NONFREE_STEAM" "$PKG_RPMFUSION_NONFREE_STEAM_EXCLUSIONS";;
            11) println "Installing nVidia drivers with CUDA support...";
                    install_repo "$PKG_WORKSTATION_REPOS" "$FILENAME_RPMFUSION_NONFREE" "$REPO_RPMFUSION_NONFREE_NVIDIA";
                    printf "Installing packages...";
                    dnf_install "$PKG_RPMFUSION_NONFREE_NVIDIA";;
            *);;
        esac
    done

}

# Function MAIN. It's the main program.
function main(){
    [ "$(id -u)" != "0" ] && println "Please, run as root." && exit
    var_setup
    create_log
    clear
    println "************************"
    println "* Fedora KDE Installer *"
    println "************************"
    println ""
    println "Version $SCRIPT_VER"
    println ""
    println "The following packages are available as [OPTIONAL]:"
    println "1. Recommended Packages: Packages recommended to make your KDE experience better."
    println "2. WiFi Packages: Packages required to make some wifi setups work." 
    println "   It is highly advised to install this if you are using a laptop."
    println "3. Security Packages: Packages that include some security tools."
    println "4. Workstation repos: Installs the Fedora Workstation Repos. Useful for setups which need PyCharm," 
    println "   Chrome, Steam or nVidia's Proprietary drivers with CUDA support"
    println "5. Toolbox: Installs Fedora's Toolbox utility."
    println "6. Virtualization: Installs a virt-manager and the libvirt-client."
    println "7. EMPtyMuTeX's Recommended Packages: Useful packages, recommended"
    println "   by EMPtyMuTeX."
    println "8. Java Recommended Versions: Recommended Java versions for Fedora."
    println "9. RPMFusion Free Recommended: Recommended packages from the RPMFusion-"
    println "   Free repository."
    println "10. Steam: Installs Steam from the RPMFusion-nonfree-steam repository."
    println "11. nVidia: Installs the proprietary nVidia drivers from the RPMFusion-"
    println "    nonfree-nvidia repository."
    println ""
    println "Please, select the optional packages to install, separated by commas, or"
    println "leave blank to install only the minimal setup."
    printf "Packages [1-11]: "
    read selected_packages
    clear
    update_system
    install_required_packages
    setup_sddm
    install_recommended_packages $selected_packages
    flash_term
    println "It is now recommended to REBOOT. Press RETURN to exit."
    read
}

# Run the main function.
main
