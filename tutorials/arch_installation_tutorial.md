<!-- TABLE OF CONTENTS -->
<details>
 	<summary>Table of Contents</summary>
  	<ul>
    		<li><a href='#arch-'>Arch</a></li>
		<li><a href='#starting-up-the-main-resources-that-will-be-of-use-for-the-installation-guide'>Documentation</a></li>
		<li><a href='#installation-proccess'>Installation</a></li>
		<ul>
			<li><a href='#configuring-partitions-and-filesystems-'>Configuring partitions and Filesystems</a></li>
			<li><a href='#update-the-mirrorlist-'>Update-the-Mirrorlist</a></li>
			<li><a href='#install-essential-packages-using-pacstrap-'>Pacstrap</a></li>
			<li><a href='#configure-the-system-'>Configure the System</a></li>
			<li><a href='#unmount-the-arch-partition-umount--r-mnt-and-reboot'>Unmount the Partition</a></li>
		</ul>
		<li><a href='#install-basic-packages-'>Basic Packages</a></li>
		<li><a href='#configuring-the-desktop-'>Configuring the Desktop</a></li>
    		<ul>
			<li><a href='#configuring-aur-helper-'>Aur Helper</a></li>
			<li><a href='#setting-up-video-drivers-'>Video Drivers</a></li>
			<li><a href='#configuring-xserver-and-bspwm-'>Xserver & Bspwm</a></li>
			<ul>
				<li><a href='#basic-functionality-'>Basic Functionality</a></li>
				<li><a href='#setting-up-keyboard-layouts-'>Keyboard Layouts</a></li>
				<li><a href='#setting-up-default-cursor-'>Cursor Settings</a></li>
				<li><a href='#configuring-mouse-controls-'>Mouse Settings</a></li>
				<li><a href='#setting-up-the-default-fonts-'>Default Fonts</a></li>
				<li><a href='#configuring-gtk-'>Configure Gtk</a></li>
			</ul>
		</ul>
		<li><a href='#using-pacman-'>Pacman Cheetsheet</a></li>
		<li><a href='#to-do'>Work In Process</a></li>
  	</ul>
</details>

# [Arch](https://wiki.archlinux.org/title/Arch_Linux) [<img src="https://github.com/SfikasTeo/Arch/blob/main/Arch_Logo.png" width="220" align="right" alt="Arch">](https://wiki.archlinux.org/)
Arch Linux is a barebone linux distribution with a **minimal** ISO focused on the KISS and 'Do-it-yourself' principles.  
Striving to provide the latest software releases, the distribution is based on a **rolling release** model.  
Arch uses **[systemd](https://wiki.archlinux.org/title/Systemd#Basic_systemctl_usage)** as the init process and provides [journal](https://wiki.archlinux.org/title/Systemd/Journal) as a logging system.  
Lastly Arch follows Linux Foundation's Filesystem Hierarchy Standard ([FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)), and the package management is based on [**Pacman**](https://wiki.archlinux.org/title/Pacman).  
    
**Disclaiming**: The following guide will be customized and specific for my set-up process.  Alternating the guide to your needs is advisable. 

## Starting up: The main resources that will be of use for the installation Guide

* [Arch Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
* [Arch Wiki](https://wiki.archlinux.org/)
* [Arch Package Manager](https://wiki.archlinux.org/title/Pacman)
* [EFI System Partition](https://wiki.archlinux.org/title/EFI_system_partition#GPT_partitioned_disks)
* [BootLoaders Comparisson](https://wiki.archlinux.org/title/Arch_boot_process#Boot_loader)

## [Installation](https://wiki.archlinux.org/title/Installation_guide#Boot_the_live_environment) Proccess
* Set Console Keymap ( US by default ) and select fonts :
	*  List of available Keymaps: 	`ls /usr/share/kbd/keymaps/**/*.map.gz` . Change using `loadkeys <name>` command.
	*  List of available Fonts:	`ls /usr/share/kbd/consolefonts/`. Change using `setfont <name>` command.
* Verify EFI boot mode:	`ls /sys/firmware/efi/efivars` . If the directory exists you are booted into UEFI disk firmware.
* Ensure internet access : `ip a`
	* For wired connections, internet should be configured automatically
	* For wireless connections the use of [iwd](https://wiki.archlinux.org/title/Iwd#iwctl) utility is advised `iwdctl` :
		* List available devices : `device list` 
		* Initiate a scan for networks : `station <device name> scan`
		* Display available networks : `station <device name> get-networks`
		* Connect to chosen network: `station <device name> connect SSID`
* Update the system clock: `timedatectl set-ntp true`
* ##### Configuring **Partitions** and **Filesystems** :
	* `lsblk -f` or `fdisk -l` -> List drives  
	* `blkdiscard /dev/sda` -> Updates the drives firmware to signify that the drive is empty (**SSD** or **NVME** only).  
	* The two most open sourced and advocated filesystems, tuned for desktop use, are [**Ext4**](https://wiki.archlinux.org/title/Ext4) and [**Btrfs**](https://wiki.archlinux.org/title/Btrfs)  
	While the the first offers a reliable and accepably fast filesystem, the second provides a series of quality of life improvements, at the cost of some speed,
  	* [Partition Disk](https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks) ( `/dev/sda` ):    
          Any supported partition utility could be used. We will default to GNU **parted** -> `parted /dev/sda`  
		* Create a **gpt** partition table -> `mklabel gpt`
		* Create the partitions :  
		```
		#Create a GPT Partition Table
		mklabel gpt
	
		# Create the Boot Partition
		mkpart BOOT fat32 4mb 1gb
		set 1 esp on
		
		# [Optional] Swap Partition
		mkpart SWAP linux-swap 1gb Xgb
		
		# Choose a Root Partition
		mkpart BTRFS btrfs Xgb 100%
		mkpart EXT4 ext4 Xgb 100%
		```
		* [Optional] Make a Swap partition **at least the same size** as your RAM for **[Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation)**.
	* Format the partitions :
	```
	# Format the EFI Boot Partition
	mkfs.fat -F32 -n EFI /dev/sda1
	
	# Format the ROOT Partition
	mkfs.btrfs -L ROOT /dev/sda3
	mkfs.ext4 -L ROOT -m 1 /dev/sda3
	
	# Format and enable Swap Partition
	mkswap -L SWAP /dev/sda2
	swapon /dev/sda2	   
	```
	* Create the Btrfs subvolumes :
	```
	mount /dev/sda3 /mnt
	btrfs su cr /mnt/@
	btrfs su vr /mnt/@home
	umount /mnt
	```
	* Tune The Ext4 performance:
	```
	# Check all Options:
	tune2fs -l /dev/sda3 | grep features
	
	tune2fs -O fast_commit /dev/sda3
	
	# Disabling Journal may lead to data loss
	# It is not advised but will enhance performance
	tune2fs -O "^has_journal" /dev/sda3
	```
	* Mount the Filesystems :
	```
	# Mount Btrfs
	mount -o rw,ssd,noatime,space_cache=v2,discard=async,compress=zstd:1,subvol=@ /dev/sda3 /mnt
	mkdir /mnt/home
	mount -o rw,ssd,noatime,space_cache=v2,discard=async,compress=zstd:1,subvol=@home /dev/sda3 /mnt/home
		
	# Mount Ext4
	mount -o rw,noatime,commit=60 /dev/sda3 /mnt
	
	# Mount the Boot Partition
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
	```
	Should you use btrfs [compression](https://www.reddit.com/r/btrfs/comments/kul2hh/btrfs_performance/) ? What about the other btrfs [mount options](https://btrfs.readthedocs.io/en/latest/btrfs-man5.html) ?
* ##### Update the mirrorlist :
	* Edit `/etc/pacman.d/mirrorlist` manually
	* [Reflector](https://man.archlinux.org/man/reflector.1) : `reflector -l 40 --verbose --sort rate --save /etc/pacman.d/mirrorlist`
* ##### Install Essential packages using pacstrap :
 ```
 pacstrap -i /mnt base sudo linux linux-firmware neovim {amd-ucode or intel-ucode}
 ```
 * ##### Configure The system :
 	* Generate and edit **fstab** : `genfstab -L /mnt >> /mnt/etc/fstab` && `cat /mnt/etc/fstab`
 	* **Change root into the new system :** `arch-chroot /mnt`
 		* Create symlink for timezone : `ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localetime`
 		* Synchronize hardware and system clock : `hwclock --systohc`
 			* [Troubleshooting](https://wiki.archlinux.org/title/System_time#Troubleshooting): `timedatectl set-timezone Europe/Athens` or `ntpd -qg` 
 		* Edit `/etc/locale.gen` and **uncomment** `en_US.UTF-8 UTF-8`
		* Create the [locale](https://wiki.archlinux.org/title/Locale): `locale-gen` and `echo "LANG=en_US.UTF-8" >> /etc/locale.conf`
 		* If keyboard layout was changed edit `/etc/vconsole.conf`
 		* Edit Hostname : `echo "SF-Arch" >> /etc/hostname`
 		* Edit LocalHost : `nvim /etc/hosts`
 		```
		#Standard host addresses				# Simpler Configuration 
		127.0.0.1	localhost 				127.0.0.1	localhost 
		::1		localhost ip6-localhost ip6-loopback	::1		localhost
		ff02::1	ip6-allnodes				127.0.1.1	SF-Arch.localdomain	SF-Arch	
		ffo2::2	ip6-allrouters
		#This Host Address
		127.0.1.1	SF-Arch
		```
		* Set root  password: `passwd`
		* Install **minimal Packages** :
		```
		pacman -S base-devel linux-headers networkmanager 	\
			wpa_supplicant fish git dialog ( btrfs-progs )	\
		```
		* Set up the initramfs :
			* **Update** `/etc/mkinitcpio.conf` with `MODULES=(btrfs)`, if Btrfs is used and remove `HOOKS=( ..fsck )`
			* [Optional] For Hibernation add the **resume** hook after udev `HOOKS=( ..udev ..resume )`
			* Recreate initramfs with `mkinitcpio -p linux`
		* Create **user**: `useradd -mG users,wheel,audio,video -s /bin/fish sfikas` and `passwd sfikas`
		* Edit `/etc/sudoers` file: `EDITOR=nvim visudo` and **uncomment** `%wheel ALL=(ALL) ALL`
		* Set up **systemd-boot**
			* **Warning**  This will work only on UEFI.
			* Setup systemd-boot : `bootctl --path=/boot install`
			* Create your bootloader enty : `nvim /boot/loader/entries/arch.conf`
			```
			title Arch Linux
			linux /vmlinuz-linux
			initrd {/amd-ucode.img or /intel-ucode.img}
			initrd /initramfs-linux.img
			# Option for Btrfs
			options root=LABEL=ROOT rootflags=subvol=@ rw
			# Option For Ext4 And Swap
			options root="LABEL=ROOT" rw resume="PARTLABEL=SWAP"
			
			```
			* Set the default bootloader entry : `nvim /boot/loader/loader.conf`   

			```
			default	arch.conf
			timeout	4
			console-mode	max
			editor		no
			```
			* Start NetworkManager Service : `systemctl enable NetworkManager`
		* **Exit** the chroot environment: `exit`
* ##### Unmount the arch partition `umount -R /mnt` and `reboot`
* ##### Set up System's power behavior by editing `/etc/systemd/logind.conf` and restarting `systemd-logind` service.

## Install **Basic Packages** :
```
pacman -S inetutils lm_sensors man-pages man-db 	\
openssh reflector dosfstools ntfs-3g parted 		\
```
## Configuring the Desktop :
* #### Configuring [AUR helper](https://wiki.archlinux.org/title/AUR_helpers) :
The suggested aur helpers are either [Yay](https://github.com/Jguer/yay), based on Go, or [Paru](https://github.com/Morganamilo/paru) based on Rust.  
The installation process is almost the same for both.
```
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

* #### Setting up Video drivers :
	* [Intel](https://wiki.archlinux.org/title/intel_graphics#Installation) : `pacman -S xf86-video-intel`   
	Intel graphical drivers are mostly plug and play, Installing the **optional** package dependencies may be worth looking into.
	* [Nvidia](https://wiki.archlinux.org/title/NVIDIA) / [Nouveau](https://wiki.archlinux.org/title/Nouveau)
	* [AMD](https://wiki.archlinux.org/title/AMDGPU) : `pacman -S xf86-video-amdgpu`

* #### Configuring [Xserver](https://wiki.archlinux.org/title/Category:X_server) and [BSPWM](https://wiki.archlinux.org/title/Bspwm) :   
	##### Basic Functionality :	
	* Install **Xorg** : `pacman -S xorg xorg-xinit xclip xorg-xrandr` 
	* Install the **Window manager** :  `pacman -S  bspwm sxhkd picom polybar kitty fontconfig feh`
	* Install **Audio** functionality : `pacman -S alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth`
	* Install **Bluetooth** functionality : `pacman -S bluez bluez-utils`  
	* Install **Desktop** packages: 
	```
	paru -S brave-bin inxi btop bat flameshot ttf-fira-code ttf-font-awesome mpv timeshift timeshift-autosnap
	```
	* The **lack** of Display Manager is complemented by the **xorg-xinit** package as means of initializing the Xserver.  
	After configurating the system, the `startx` command **starts** the X environment and the Window manager of choise.  
	The **startx wrapper** uses the `~/.xinitrc` configuration file. The running configs are located at the [**dots**](https://github.com/SfikasTeo/Arch/tree/main/dots) folder.  
	**Dont forget that the sourced configuration files must be executable**.
	* In order to set the desired resolution, use `xrandr -s <width x height>` at **startup** or look into [xorg.conf](https://wiki.archlinux.org/title/Multihead#Extended_Screen_using_XRandR_and_an_xorg.conf_file)
	* ##### Setting up **[keyboard layouts](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration)** :
		* Using `setxkbmap -layout us,gr -option win_space_toggle` sets the layouts for the current X session.  
		This can be made **pseudo-permanent** by including this command at `~/.xinitrc`
		* Using **X configuration files** at `/etc/X11/xorg.conf.d/00-keyboard.conf` as follows:
		```
		Section "InputClass"
        		Identifier "system-keyboard"
        		MatchIsKeyboard "on"
        		Option "XkbLayout" "us,gr"
        	        Option "XkbOptions" "grp:win_space_toggle"
		EndSection
		```
	* ##### Setting up default **[Cursor](https://wiki.archlinux.org/title/Cursor_themes)** :
		* Find installed themes : `find /usr/share/icons ~/.local/share/icons -type d -name "cursors"`
		* For GTK-3 applications edit `~/.config/gtk-3.0/settings.ini`
		* Generally configure the cursor theme through [**Xresources**](https://wiki.archlinux.org/title/Cursor_themes#X_resources)
		* Lastly include `xsetroot -cursor_name { left_ptr or pirate }` in the **xinitrc** file.
	* ##### Configuring [Mouse](https://wiki.archlinux.org/title/Mouse_buttons) controls :
	* ##### Setting up the **Default Fonts** :
		* **setfont command** :  
		The use of `setfont <name>` command is adviced to change **terminal fonts** and mainly refers to TTY.  
		Font names can be found using the `ls /usr/share/kbd/consolefonts/` command.
		* **Fontconfig package** :  
		Some applications read the [**fontconfig**](https://wiki.archlinux.org/title/Font_configuration) configuration files to determine the default Fonts.    
		The **default** font configuration can be determined either on system or on [user level](https://wiki.archlinux.org/title/Font_configuration#Fontconfig_configuration) using 
		the `/etc/fonts/local.conf` and `~/.config/fontconfig/fonts.conf` configuration files respectively.   
		After the installation of **fontconfig** the commands `fc-list` and `fc-match <Font type>` can be used to determine **installed fonts**, and the **fonts in use** respecively.    
		In order for the configuration files to take effect, you must create a symbolic link to the `/etc/fonts/conf.d` directory with either
		`50-user.conf` or `51-local.conf` from the `usr/share/fontconfig/conf.avail/` directory.  
		Alternatively you can create configuration files inside the `etc/fonts/conf.d` directory.  
		* **[Gtk](https://wiki.archlinux.org/title/GTK#Configuration) Applications** :   
		All GTK applications need to be configured with the coresponding configuration settings based on the GTK version in use.
		
	* ##### Configuring [GTK](https://wiki.archlinux.org/title/GTK#Themes) :
		GTK applications function using **Themes**. The default Theme for GTK-{3,4} is **Adwaita**.   
		Generally for GTK-2 the default theme is **Raleigh**, but Arch has a custom configuration file at
		`/usr/share/gtk-2.0/gtkrc` which sets the default theme to Adwaita.  
		**Manual** Configuration of GTK :   
		*  **GTK-2** : User specific: `~/.gtkrc-2.0` Or system wide: `/etc/gtk-2.0/gtkrc`
		*  **GTK-3** : User specific: `/.config/gtk-3.0/settings.ini` Or system wide: `/etc/gtk-3.0/settings.ini`

## Using [Pacman](https://wiki.archlinux.org/title/Pacman) :
* Pacman Configuration `/etc/pacman.conf` : **Misc Options - Uncomment** : `ILoveCandy, Color, ParallelDownloads = 5`  
* In order to **ignore** packages from beeing **updated**, add them in `/etc/pacman.conf` under option: `IgnorePkg= <p1> <p2>`
* Basic pacman instructions :
	* `pacman -Syu` : Full system update.
	* `pacman -S or -Sw <package>` : Install package or simply download it.
	* `pacman -U <path/to/package>` : Install a local package.
	* `pacman -Rns <package>` : Remove package, its orphaned dependencies and default configuration backup files.
	* `pacman -Ss or -Qs` : Search for package in the repositories or locally respectively.
	* `pacman -Si or -Qi` : Display package's detailed information.
	* `pacman -Qdt` : List orphane packages.
	* `pacman -Scc` : Clean aggresively pacman's cache directory.
* [Pacman Tips and Tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#) offers a deeper dive into the package manager.


## To Do
* Guide for Nvidia. AMD or Intel GPU.
* Configure Mouse.
* [General Recommendations](https://wiki.archlinux.org/title/General_recommendations)
* [Power Management](https://wiki.archlinux.org/title/Category:Power_management)
	* [Power Management Through Systemd - Laptop Utilities](https://wiki.archlinux.org/title/Power_management#Power_management_with_systemd)
	* [General Page About Laptops](https://wiki.archlinux.org/title/Category:Laptops)
	* [Specific documentation for Laptops](https://wiki.archlinux.org/title/Laptop)
* [SSD General Settings](https://wiki.archlinux.org/title/Solid_state_drive)
* [Performance](https://wiki.archlinux.org/title/Improving_performance)
	
				
