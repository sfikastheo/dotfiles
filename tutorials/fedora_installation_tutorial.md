# [Fedora](https://fedoraproject.org/wiki/Fedora_Project_Wiki) [<img src="https://github.com/SfikasTeo/Fedora/blob/main/Fedora_Logo.png" width="350" align="right" alt="Fedora">](https://docs.fedoraproject.org/en-US/docs/)
Fedora is an open sourced project suppported and sponsored mainly by the [Red Hat Enterprise](https://www.redhat.com/en). The aim is a **leading edge** distribution with tested transitions between newer kernel versions and packages, following a **point release** methodology.  
The package management system of fedora is based on **[RPMs](https://en.wikipedia.org/wiki/RPM_Package_Manager)** with [DNF](https://dnf.readthedocs.io/en/latest/index.html) as the management tool. The fedora project offers a plethora of spins for different use cases, most commonly recommended are the **[Workstation](https://getfedora.org/en/workstation/)** for *plug and play use* or the **[Server](https://getfedora.org/en/server/)** spin for a more advanced and customized experience.  
Finally fedora by default uses **[systemd](https://docs.fedoraproject.org/en-US/quick-docs/understanding-and-administering-systemd/)** as the initialization system, and has incorporated to the use of both **[Wayland](https://wayland.freedesktop.org/)** and X11. Automatically implemented are also the firewalld, SElinux and zram utilities.

## Starting up: Most commonly referred resources

* [Fedora Quick Docs](https://docs.fedoraproject.org/en-US/quick-docs/)
* [Fedora Project Wiki](https://fedoraproject.org/wiki/Fedora_Project_Wiki)
* [DNF Package Manager](https://dnf.readthedocs.io/en/latest/index.html)
* [Fedora Packages](https://packages.fedoraproject.org/)

## Server Installation
The installation pocedure is graphical and easy based on the anaconda installer.  
Points of interest:
1. First task: Configuring the partitioning and choosing the filesystem:
It is recommended to use the [UEFI](https://www.linux-magazine.com/Online/Features/Coping-with-the-UEFI-Boot-Process) boot specification and choose between [*Ext4 / Btrfs / Xfs*](https://www.phoronix.com/review/linux-50-filesystems/4). *( Benchmarks correspond to 5.0 kernel. Newer implementation of the FS might variate the results )*. The fedora project and Red Hat mainly recommends [Ext4 and Xfs](https://access.redhat.com/articles/3129891). A typical partition shceme follows, change it to your needs.
   * `/boot/efi` -> EFI system boot Partition.
   * `/` -> Root partition ( Chosen filesystem )
   * `/home` -> Home partition ( Chosen filesystem )
   * `/boot, /var and swap` are optional ( Chosen filesystem )
2. Configure Keyobard layouts, Language Support, DateTime.
3. Change network Host Name.
4. Under Software Selection, nothing is mandatory but may opt for Network Submodules, if the wanted use if a Desktop Environment.

## Creating a minimal desktop
1. Configure [**Dnf**](https://github.com/SfikasTeo/dotfiles/blob/main/tutorials/fedora_installation_tutorial.md#fedora-package-management-and-dnf) to speed up the process and upgrade the system.
2. Installation of Basic Packages
```
#!/bin/bash

### Cli- Utilities
sudo dnf install \
git GraphicsMagick vim btop unzip ripgrep fzf \
wl-clipboard brightnessctl light rofi-wayland \
lm_sensors inxi grim slurp helix zsh curl rustup

### Desktop packages
sudo dnf install \
wl-clipboard hyprland xdg-desktop-portal-hyprland \
pavucontrol foot thunar thunar-volman thunar-archive-plugin \
blueman flatpak swaybg polkit-gnome

### Corps:
# Notification Center
dnf copr enable erikreider/SwayNotificationCenter
dnf install SwayNotificationCenter
# Bottom
sudo dnf copr enable atim/bottom
sudo dnf install bottom
# Bibata Cursor theme
sudo dnf copr enable peterwu/rendezvous
sudo dnf install bibata-cursor-themes

```
4. Configure the system.
  * Change the default shell *( Optional )* : `chsh -s $(which zsh)`
  * Update or move necessary files to `~/.config`
  * Install a Dispaly manager *( Optional )*:
```
sudo dnf install lightdm
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target
```
  * Changing the keyboard-layout:
    * Either use user-space remappers like [xremap](https://github.com/k0kubun/xremap)
    * Change it on kernel-level: `/usr/lib/kdb..`   

## Fedora Package management and [DNF](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
DNF is generally considered one of the **slowest** package management systems. The first time DNF is used, a relatively **big size of metadata** from every repository must be updated, giving the first truth to the statement above. After the first use and after determining the fastest mirrors, although the package management is quite faster, **compared** to other package managers like **apt** or **pacman**, dnf lacks behind in speed. Configuring DNF with the following arguments is always recommended.
* **Add** the following options to DNF configuration file `sudo nano /etc/dnf/dnf.conf`
```
fastestmirror=True
max_parallel_downloads=5
defaultyes=True
metadata_expire=-1
```
* Reevaluating repositories metadata for faster mirrors may be advised: `dnf clean metadata`
* Most commonly used commands: 
    * `dnf info <package>` Display information about installed packages
    * `dnf check-update` Update package cache
    * `dnf search <package>` Search repositories for specific package
    * `dnf install <package>` Install specific package from a repository
    * `dnf remove <package>` Remove a specific package and its dependencies
    * `dnf upgrade` Upgrade system or specific package
    * `dnf list installed` Lists installed packages
    * `dnf provides <file>` Similar to pkgfile in Arch
    * `dnf group <above commands>` Refers to predefined groups
* Stop DNF from always updating Metadata:
**Optional:** DNF uses two sevices to automatically update the metadata of your repositories on start up and after a predefined amount of time based on `metadata_timer_sync` you can disable the services by:
```
systemctl disable dnf-makecache.timer
```
While using DNF, the metadata from each repository will also be updated. \
* Altering the metadata expiration date in `/etc/dnf/dnf.conf` will stop the constant updates. However this option will override the expiration settings but they can also be **alterred** under `/etc/yum.repos.d/<*>.repo`.
* Using the `-C` *aka --cacheonly* flag is an alternative that can be set as an alias to specific commands.
* Updating the system now would **require** to update the metadata. Aliasing `dnf upgrade --refresh` or using `dnf clean metadata` before the upgrade should do the job.

## Enable [RPM Fusion](https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/) and [flathub](https://flathub.org/home)
In case the flatpak package is missing, it can be installed using `sudo dnf install flatpak`
* **RPM Fusion** repositories:
```
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```
* **Flathub** repositories: 
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
 
## Install additional [media Codecs](https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/) From RPM Fusion
Several offline media players *like vlc or mpv* bundle all the relevant codecs by themselves.
```
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia --allowerasing
 ```
 
## Install [Visual-Studio-Code](https://code.visualstudio.com/docs/setup/linux)
Install the provided yum repository and PGP key: 
```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```
Then update the **package cache** and install the package:
```
dnf check-update
sudo dnf install code 
```
