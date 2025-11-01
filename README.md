# QEMU MESA GL/3Dfx Glide Pass-Through

This is a fork of QEMU-3dfx for Arch Linux or any OS with pacman command and tries to add more documentation. (and binaries)

For more info. Refer to the [original repo](https://github.com/kjliew/qemu-3dfx).

## Content

    bin/disks            - Floppy Disks to make installation better
    qemu-0/hw/3dfx       - Overlay for QEMU source tree to add 3Dfx Glide pass-through device model
    qemu-1/hw/mesa       - Overlay for QEMU source tree to add MESA GL pass-through device model
    qemu-exp             - Experimental Folders and deprecated files
    MINGW-packages       - PKGBUILD Script for building the packages (Windows)
    packages             - PKGBUILD Script for building the packages (Arch Linux)
    scripts/sign_commit  - Script for stamping commit id
    virgl3d              - VirGL with SDL2 EGL/OpenGL patches
    wrappers/3dfx        - Glide wrappers for supported guest OS/environment (DOS/Windows/DJGPP/Linux)
    wrappers/mesa        - MESA GL wrapper for supported guest OS/environment (Windows)

## Patches

This repository includes patches from upstream and my patches that work on latest version.

### My patches

     00-qemu110x-mesa-glide.patch - Patch for QEMU version 10.1.x (MESA & Glide)
     01-qemu100x-mesa-glide.patch - Patch for QEMU version 10.0.x (MESA & Glide)
     02-qemu92x-mesa-glide.kht.patch - Patch for QEMU version 9.2.x (MESA & Glide) (deprecated)

### KJ Liew's patches

    00-qemu92x-mesa-glide.patch - Patch for QEMU version 9.2.x (MESA & Glide)
    01-qemu82x-mesa-glide.patch - Patch for QEMU version 8.2.x (MESA & Glide)
    02-qemu72x-mesa-glide.patch - Patch for QEMU version 7.2.x (MESA & Glide)

## QEMU Windows Guests Glide/OpenGL/Direct3D Acceleration

Witness, experience and share your thoughts on modern CPU/GPU prowess for retro Windows games on Apple Silicon macOS, Windows 10/11 and modern Linux. Most games can be installed and played in pristine condition without the hassle of hunting down unofficial, fan-made patches to play them on Windows 10/later or modern Linux/Wine. And now it's updated for rolling release and added some tools and libraries I copied on the internet to make the experience better (as long i have free time).

- Original repository (<https://github.com/kjliew/qemu-3dfx>)
- YouTube channel (<https://www.youtube.com/@qemu-3dfx/videos>)
- VOGONS forums (<https://www.vogons.org>)
- Wiki (<https://github.com/kjliew/qemu-3dfx/wiki>)
- Repository's Wiki (<https://github.com/kharovtobi/qemu-3dfx-arch/wiki>)

## Downloading QEMU

**[Download Stable Build](https://github.com/kharovtobi/qemu-3dfx-arch/releases/latest)**

Includes released Standalone Windows Binaries, Wrappers, Add-ons and old PKGBUILD files

**[GitHub Actions Build](https://github.com/kharovtobi/qemu-3dfx-arch/actions/workflows/build.yaml/)**

Includes latest commit Windows Binaries and Wrappers (requires a GitHub Account)

## Building QEMU

There are two ways to build this repo. While this is repo is used for Arch Linux, It can also build on other OS like Windows 10 with MSYS2 too.

### Convenience Way

This way is simple. Just download the PKGBUILD from GitHub. (Arch-Based distributions)

    mkdir ~/myqemu && cd ~/myqemu
    git clone https://github.com/kharovtobi/qemu-3dfx-arch.git
    cd qemu-3dfx-arch/packages/qemu-3dfx
    makepkg -si

- This defaults to making kjliew's repository.
- This script builds it for you to install into your system.
- Chroot is recommended! For more details, Go to <https://wiki.archlinux.org/title/DeveloperWiki:Building_in_a_clean_chroot>

### Traditional Way

This way is basically the same, But less tedious and compiles only the essentials and installs to a folder making it much faster. (Any operating systems)

Simple guide to apply the patch:
(using `00-qemu110x-mesa-glide.patch`)

    mkdir ~/myqemu && cd ~/myqemu
    git clone https://github.com/kharovtobi/qemu-3dfx-arch.git
    cd qemu-3dfx-arch
    wget https://download.qemu.org/qemu-10.1.0.tar.xz
    tar xf qemu-10.1.0.tar.xz
    cd qemu-10.1.0
    rsync -r ../qemu-0/hw/3dfx ../qemu-1/hw/mesa ./hw/
    patch -p0 -i ../00-qemu110x-mesa-glide.patch
    bash ../scripts/sign_commit
    mkdir ../build && cd ../build
    ../qemu-10.1.0/configure --target-list=i386-softmmu --prefix=$(pwd)/../install_dir
    make install

- This guide makes and installs binaries to install_dir
- You can also patch any versions in 10.1.x
- All patch hunks must be successful in order for the binary to run properly, or you may have BSOD when running Windows 98 for the first time and not work as intended.

### VirGL with SDL2 OpenGL Support

This way adds VirGL patches for the binary (Windows and MacOS)

- Recommended for 8.2.x or 7.2.x only?
- Not Tested yet...
- If you compile the binary using patched VirGL package without patching it first will have an error. ([reference](https://github.com/msys2/MINGW-packages/issues/10547))

## Building Guest Wrappers

Refer to [Wrapper README](wrappers/README.md) for more info.

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

- KJ Liew - For making QEMU-3dfx
- JHRobotics - For making ICD support
- cyanea-bt - For script reference used for `build.yaml`
- xutaxkamay - For making SDL clipboard support
