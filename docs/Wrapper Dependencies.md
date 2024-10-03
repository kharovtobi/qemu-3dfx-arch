# Guest Wrapper Dependencies
Works only for Arch based distros with AUR.

**Required Packages**

base-devel (Core)

perl (Core)

xxd (Extra) (Either tinyxxd or vim)

git (Extra)

mingw-w64-tools (AUR Compile)

**Mingw32 cross toolchain**

mingw-w64-binutils (Extra)

mingw-w64-gcc (Extra)

**Watcom C/C++ cross toolchain**

openwatcom-v2 (AUR bin)

dont forget to run command before compiling!

        $ source /opt/watcom/owsetenv.sh

**Msdosdjgpp cross toolchain**

djgpp-binutils (AUR Compile)

djgpp-djcrx (AUR Compile)

djgpp-gcc (AUR Compile)

**Installing djpp-djcrx**
1. Install djgpp-djcrx-bootstrap
2. Install djgpp-djcrx
3. Run command

        $ sudo ln -sf usr/bin/i686-pc-msdosdjgpp-dxe3gen /usr/bin/dxe3gen
