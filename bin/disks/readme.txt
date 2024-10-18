Advanced Boot Disk version 3
======================================================================

A floppy disk with tools that helps
you install Windows on QEMU-3dfx.

======================================================================
Changelog:
- Added Drivers
- moved win98.zip to batch folder
======================================================================
Problems:
1. Reading disk is unavailable while your using Windows on VMware or Virtualbox.
2. msbatch.inf is included on win98.zip. If you dont want it, delete the file.
3. Windows NT drivers and batch not included.
4. unzip -d c:\$windir batch\win98.zip btw
