# Guest Wrapper Dependencies
Works only for Arch based distros with AUR.
**Required Packages**
1. base-devel (Core)
2. xxd (Extra) (Either tinyxxd or vim)
3. git (Extra)
4. mingw-w64-tools (AUR Compile)

**Mingw32 cross toolchain**
5. mingw-w64-binutils (Extra)
6. mingw-w64-gcc (Extra)

**Watcom C/C++ cross toolchain**
1. openwatcom-v2 (AUR bin)

dont forget to run command before compiling!

    $ source /opt/watcom/owsetenv.sh

**Msdosdjgpp cross toolchain**
1. djgpp-binutils (AUR Compile)
2. djgpp-djcrx (AUR Compile)
3. djgpp-gcc (AUR Compile)

**Installing djpp-djcrx**
1. Install djgpp-djcrx-bootstrap
2. Install djgpp-djcrx
3. Run command
sudo ln -sf usr/bin/i686-pc-msdosdjgpp-dxe3gen /usr/bin/dxe3gen
