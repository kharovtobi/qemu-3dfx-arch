# QEMU MESA GL/3Dfx Glide Pass-Through (for Arch based distros)
This is a fork of QEMU-3dfx for Arch Linux or any OS with pacman command

For more info. Refer to the original repo
## Content
    qemu-0/hw/3dfx       - Overlay for QEMU source tree to add 3Dfx Glide pass-through device model
    qemu-1/hw/mesa       - Overlay for QEMU source tree to add MESA GL pass-through device model
    scripts/sign_commit  - Script for stamping commit id
    wrappers/3dfx        - Glide wrappers for supported guest OS/environment (DOS/Windows/DJGPP/Linux)
    wrappers/mesa        - MESA GL wrapper for supported guest OS/environment (Windows)
    wrappers/buildiso.sh - Script for making Wrapper Disk
    bin/PKGBUILD         - Script for building the packages
    bin/disks/fd.ima     - Windows 9x Floppy disk with some tools included
## Patch
    00-qemu91x-mesa-glide.patch - Patch for QEMU version 9.1.x (MESA & Glide)
    00-qemu82x-mesa-glide.patch - Patch for QEMU version 8.2.x (MESA & Glide)
    01-qemu72x-mesa-glide.patch - Patch for QEMU version 7.2.x (MESA & Glide)
    02-qemu620-mesa-glide.patch - Patch for QEMU version 6.2.0 (MESA & Glide)
## QEMU Windows Guests Glide/OpenGL/Direct3D Acceleration
Witness, experience and share your thoughts on modern CPU/GPU prowess for retro Windows games on Apple Silicon macOS, Windows 10/11 and modern Linux. Most games can be installed and played in pristine condition without the hassle of hunting down unofficial, fan-made patches to play them on Windows 10/later or modern Linux/Wine. And now it's updated for rolling release and added some tools and dlls i copied on the internet to make the experience better (as long i have free time).
- Original repository ( https://github.com/kjliew/qemu-3dfx)
- YouTube channel (https://www.youtube.com/channel/UCl8InhZs1ixZBcLrMDSWd0A/videos)
- VOGONS forums (https://www.vogons.org)
- Wiki (https://github.com/kjliew/qemu-3dfx/wiki)
## Downloading QEMU
(https://github.com/kharovtobi/qemu-3dfx/releases)

This includes Binaries, Disks and PKGBUILDS

`bin-linux` for Linux

`bin-windows` for Windows
## Building QEMU
There are two ways to build this repo. While this is repo is used for Arch Linux, It can also build on other OS like Windows 10 with MSYS2. It may not be supported, yet.

**Convenience Way:**
This way is simple. Just download the PKGBUILD from GitHub. (Arch-Based distributions)

    $ mkdir ~/myqemu && cd ~/myqemu
    $ git clone https://github.com/kharovtobi/qemu-3dfx.git
    $ cd qemu-3dfx/bin
    $ makepkg -si

- This scripts builds it for you to install into your system.
- Default PKGBUILD compiles kjliew's repository!
- Chroot is recommended! for more details, Go to https://wiki.archlinux.org/title/DeveloperWiki:Building_in_a_clean_chroot

**Traditional Way:**
This way is basically the same, But less tedious and compiles only the essentials, making it much faster. (Any operating systems)

Simple guide to apply the patch:<br>
(using `00-qemu91x-mesa-glide.patch`)

    $ mkdir ~/myqemu && cd ~/myqemu
    $ git clone https://github.com/kharovtobi/qemu-3dfx.git
    $ cd qemu-3dfx
    $ wget https://download.qemu.org/qemu-9.1.1.tar.xz
    $ tar xf qemu-9.1.1.tar.xz
    $ cd qemu-9.1.1
    $ rsync -r ../qemu-0/hw/3dfx ../qemu-1/hw/mesa ./hw/
    $ patch -p0 -i ../00-qemu91x-mesa-glide.patch
    $ bash ../scripts/sign_commit
    $ mkdir ../build && cd ../build
    $ ../qemu-9.1.1/configure --target-list="i386-softmmu"
    $ make

- All patch hunks must be successful in order for the binary to run properly.

## Building Guest Wrappers
Refer to https://github.com/kharovtobi/qemu-3dfx-arch/blob/master/wrappers/README.md for more info 

## Installing Guest Wrappers
**For Win9x/ME:**  
 - Copy `FXMEMMAP.VXD` to `C:\WINDOWS\SYSTEM`  
 - Copy `GLIDE.DLL`, `GLIDE2X.DLL` and `GLIDE3X.DLL` to `C:\WINDOWS\SYSTEM`  
 - Copy `GLIDE2X.OVL` to `C:\WINDOWS`  
 - Copy `OPENGL32.DLL` to `Game Installation` folders

**For Win2k/XP:**  
 - Copy `FXPTL.SYS` to `%SystemRoot%\system32\drivers`  
 - Copy `GLIDE.DLL`, `GLIDE2X.DLL` and `GLIDE3X.DLL` to `%SystemRoot%\system32`  
 - Run `INSTDRV.EXE`, require Administrator Priviledge  
 - Copy `OPENGL32.DLL` to `Game Installation` folders

## Credits
- kjliew - For making QEMU-3dfx 
- JHRobotics - For making ICD support 
