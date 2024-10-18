# QEMU MESA GL/3Dfx Glide Pass-Through Wrapper Disk
This folder contains the source codes for wrappers that make pass-through possible and how to make one

## Content
    3dfx          - Glide wrappers for supported guest OS/environment (DOS/Windows/DJGPP/Linux)
    mesa          - MESA GL wrapper for supported guest OS/environment (Windows)
    iso           - Wrapper Disk folder
    texts         - Some texts and readme
    buildiso.sh   - Script for making Wrapper Disk
    
## Building Guest Wrappers
**Requirements:**
 - `base-devel` (make, sed, xxd etc.)
 - `gendef, shasum`
 - `mingw32` cross toolchain (`binutils, gcc, windres, dlltool`) for WIN32 DLL wrappers
 - `Open-Watcom-1.9/v2.0` or `Watcom C/C++ 11.0` for DOS32 OVL wrapper
 - `{i586,i686}-pc-msdosdjgpp` cross toolchain (`binutils, gcc, dxe3gen`) for DJGPP DXE wrappers

If you have Watcom installed, run command first

    $ source /opt/watcom/owsetenv.sh
    
**Building**

    $ cd ~/myqemu/qemu-3dfx/wrappers/3dfx
    $ mkdir build && cd build
    $ bash ../../../scripts/conf_wrapper
    $ make && make clean

    $ cd ~/myqemu/qemu-3dfx/wrappers/mesa
    $ mkdir build && cd build
    $ bash ../../../scripts/conf_wrapper
    $ make && make clean

## Packaging Guest Wrappers
**Requirements**
- `git` for stamping commit ID to text
- `mkisofs` for making iso
- `bsdtar, vmaddons.iso` for copying DirectX wrappers (optional)
- `wget` and `unzip` for copying other wrappers (optional)

**Packaging**
    
    $ cd ~/myqemu/qemu-3dfx/wrappers/iso
    $ mkdir wrapfx && cd wrapfx
    $ cp -r ../../3dfx/build/* ./
    $ rm -r lib* Makefile     

    $ cd ~/myqemu/qemu-3dfx/wrappers/iso
    $ mkdir wrapgl && cd wrapgl
    $ cp -r ../../mesa/build/* ./
    $ rm Makefile
    
    $ cd ~/myqemu/qemu-3dfx/wrappers/iso
    $ cp ../texts/readme_nodx.txt ./readme.txt
    $ echo $(git rev-parse HEAD) > ./commit\ id.txt
    $ cd ..
    $ mkisofs -o wrappers.iso ./iso
    
## Notes
 - Feel free to add anything to iso folder.
 - Run `buildiso.sh` to make a Wrapper Disk with tools installed via the internet automatically. If you have kjliew's `vmaddons.iso`, It will extract files into the iso to add WineD3D libraries. If not, it will either download JHRobotics wine9x libraries or adolfintel (Federico Dossena) WineD3D libraries instead. (Everything must be compiled first and followed the Building Guest Wrappers instructions!)
 - The buildiso.sh also works on kjliew's or any forked qemu-3dfx repository. Copy the script to the repo's wrapper folder (Required!)
 - ICD support is included via JHRobotics forked repo but disabled by default (im sorry)
 - Making mesa wrappers only compile opengl32.dll and wgltest.exe only. If you want all of them to compile including ICD support, run command in `wrappers/mesa/build` with Makefile
        
        $ make all+ && make clean
