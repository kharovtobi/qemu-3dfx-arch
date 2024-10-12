QEMU-3dfx Wrappers Disk
===========================================================================

This disk contains wrappers used to make the VM working.

===========================================================================
Installation
For Win9x/ME:

Copy FXMEMMAP.VXD to C:\WINDOWS\SYSTEM
Copy GLIDE.DLL, GLIDE2X.DLL and GLIDE3X.DLL to C:\WINDOWS\SYSTEM
Copy GLIDE2X.OVL to C:\WINDOWS
Copy OPENGL32.DLL to Game Installation folders

For Win2k/XP:

Copy FXPTL.SYS to %SystemRoot%\system32\drivers
Copy GLIDE.DLL, GLIDE2X.DLL and GLIDE3X.DLL to %SystemRoot%\system32
Run INSTDRV.EXE, require Administrator Priviledge
Copy OPENGL32.DLL to Game Installation folders

===========================================================================
Testing

If you have done installing it. Try WGLGEARS.EXE on disk. It is expected 
to run it and see some gears rotating.

But if you see one of the errors if you did something wrong.

1. (Red) If you got illegal operation error, It means a guest problem. 
Did you follow the Installation guide properly, forget compiling one of
wrappers or compiling with diffrent hash?

2. (Yellow) If you got corrupted dll error. especially OPENGL32.DLL
It means a guest or host problem.
You use a dll compiled with different hash (best case)
This binary is a failure and must be recompiled again. (worst case)

===========================================================================
SoftGPU Support
This Binary also supports SoftGPU and now easier to install! (Win9x Only!)
https://github.com/JHRobotics/SoftGPU

1. Check for PCI bus. If you see nothing on Device Manager. Skip this step
If you see some "Plug and Play BIOS" error. follow instructions.
https://github.com/JHRobotics/SoftGPU#pci-bus-detection-fix

2. Install dependencies, This includes DirectX and more

3. Select preset to "QEMU-3dfx" and install then reboot

4. Open disk directory and go to EXTRAS\QEMU-3DFX then edit SET-SIGN.REG
based from GIT revision hash or commit. You can get it from COMMIT ID.TXT 
on Wrapper Disk or search the repository based where you compile it.
Edit "REV_QEMU3DFX"="commit id" where commit id is the first 7 characters
on a commit id!. If your done, run TESTQMFX.EXE. 
If you see triangles spinning, congrats

5. Copy FXMEMMAP.VXD and QMFXGL32.DLL to C:\WINDOWS\SYSTEM and apply file
ICD-ENABLE.REG and reboot

6. Run GLchecker or other 3D application to verify if its running

===========================================================================
Notes

- Some texts have some occasional problems due to Text Encoding.
