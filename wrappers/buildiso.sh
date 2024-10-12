#!/bin/sh
WINE9XVER=40
#CODE=WINDOWS-1252
CDIR=$(pwd)
FXBDIR=$(pwd)/3dfx/build
MSBDIR=$(pwd)/mesa/build
TXTDIR=$(pwd)/texts
ISO=$(pwd)/iso
KJISO=$(pwd)/vmaddons

# Function to handle kjliew's wine libraries
function kjwine {
    echo "vmaddons.iso found! Extracting optional wrappers"
    mkdir $CDIR/vmaddons
    bsdtar xf vmaddons.iso --directory $CDIR/vmaddons

    echo "Installing optional wrappers"
    cp -rf $KJISO/win32/wine $ISO/
    cp -f $KJISO/win32/wrapgl/wglgears.exe $ISO/wrapgl/wglgears.exe
 #   patch -p0 -i 01-readme-vmaddons.patch -o $CDIR/output.txt
    cp -f $TXTDIR/readme_kjwine.txt $ISO/readme.txt
    for f in $ISO/wine/*/build-timestamp; do
        mv -- "$f" "${f%}.txt"
    done
    rm -rf $KJISO
    rm -f $ISO/wine/wine-get
}
# Function to handle JHRobotics's wine libraries
function jhwine {
    echo "vmaddons.iso not found! Downloading alternative optional wrappers"
    wget -q --show-progress https://github.com/JHRobotics/wine9x/releases/download/v1.7.55.40/wine9x-1.7.55.$WINE9XVER-mmx.zip --output-document=mmx.zip
    wget -q --show-progress https://github.com/JHRobotics/wine9x/releases/download/v1.7.55.40/wine9x-1.7.55.$WINE9XVER-sse3.zip --output-document=sse3.zip
    wget -q --show-progress http://www2.cs.uidaho.edu/~jeffery/win32/wglgears.exe --output-document=wglgears.exe

    echo "Installing optional wrappers"
    mkdir -p $ISO/wine/mmx $ISO/wine/sse3
    unzip mmx.zip -d $ISO/wine/mmx
    unzip sse3.zip -d $ISO/wine/sse3
    mv -f  wglgears.exe $ISO/wrapgl/wglgears.exe
#    patch -p0 -i 00-readme-wine9x.patch -o $CDIR/output.txt
    cp -f $TXTDIR/readme_jhwine.txt $ISO/readme.txt

    echo "Deleting zip files"
    rm -rf $CDIR/*.zip
}

# Function to add commit ID
function commit {
    echo "Adding commit ID"
    echo $(git rev-parse HEAD) > $ISO/commit\ id.txt

}
# Function to encode text files (Failure)
#function encode {
 #   echo "Encoding text files to $CODE "
 #   iconv -f UTF-8 -t $CODE $ISO/readme.txt -o $ISO/readme.txt --verbose
 #   iconv -f UTF-8 -t $CODE  $ISO/license.txt -o $ISO/license.txt --verbose
#  iconv -f UTF-8 -t $CODE  $ISO/commit\ id.txt -o $ISO/commit\ id.txt --verbose
#  for g in $ISO/wine/*/build-timestamp.txt; do
#      iconv -f UTF-8 -t WINDOWS-1252 $g  -o $g --verbose
#  done
#}

# Function to create the ISO
function makeiso {
    echo "Making wrapper iso"
    mkisofs -JR -V 3DFX-WRAPPERS -o $CDIR/wrappers.iso $ISO/
}

# First step install
echo "Installing compiled wrappers"
rm -rf $ISO/wine $ISO/wrapfx $ISO/wrapgl $ISO/readme.txt $ISO/license.txt $ISO/commit\ id.txt
mkdir -p $ISO/wrapfx $ISO/wrapgl $ISO/wine
cp -rf $FXBDIR/* $ISO/wrapfx/
cp -rf $MSBDIR/* $ISO/wrapgl/
cp -f $TXTDIR/LICENSE $ISO/license.txt

# Second step install
# Check for required binaries and run corresponding functions
if [ -f "$(pwd)/vmaddons.iso" ] && [ -f "/bin/bsdtar" ]; then
    kjwine
else
    if [ -f "/bin/wget" ] && [ -f "/bin/unzip" ]; then
         jhwine
    else
        echo "wget, unzip or bsdtar not  found! Skipping optional wrappers"
        cp -f $CDIR/readme.txt $ISO/readme.txt
    fi
fi

if [ -f "/bin/git" ]; then
    commit
else
    echo "git not found! Skipping adding commit id"
fi

#if [ -f "/bin/iconv" ]; then
#    encode
#else
 #   echo "iconv (glibc) not found! Please install it or text files will be a mess"
#fi

if [ -f "/bin/mkisofs" ]; then
    makeiso
else
    echo "mkisofs (cdrtools) not found! Please install it or manually make iso disk of the folder"
fi

echo "Installation Finished!"
