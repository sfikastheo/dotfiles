### [Qemu](https://www.qemu.org/): Quick Emulation
Qemu mainly focuses on full system emulation and user mode emulation, utilizing
when possible *KVM* and *Xen* virtual machines for **near native performance.**  
Virtualization must be enabled through the **bios** with either *AMD-V / VT-x / SVM*.
Enabling Intel *VT-d or AMD IOMMU* if available may be recommended.  
Check whether Virtualization if supported in your hardware: `egrep -q 'vmx|svm' /proc/cpuinfo`

### [Virt-Manager](https://virt-manager.org/): Front-End Virtual Machine Manager
Virt-Manager consists of many tools *( terminal and Graphical based )* for managing
virtual machines through **libvirt**. Virt-Viewer is the lightweight UI interface for
interacting with the graphical display of the virtualized guest OS.

### Installation Steps:
#### 1. Needed Packages:
* Fedora: `dnf install @virtualization`
* Debian: `apt-get install qemu virt-manager`
* Arch:
```
pacman -S archlinux-keyring
pacman -S qemu virt-manager virt-viewer vde2 dnsmasq bridge-utils libguestfs
```
#### 2. Enable Normal Users to Use KMV:
```
sudo vim /etc/libvirt/libvirtd.conf

# Uncomment the lines 85 and 108
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```
#### 3. Libvirt Group:
Add wanted user to the libvirt groups, allow them to handle Virtual Machines.
```
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
```
#### 3. Enable Service to establish Virtualization:
```
sudo systemctl enable --now libvirtd
```
