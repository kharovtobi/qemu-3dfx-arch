#!/bin/sh
# Build Wrapper Disk script
# it should have been smaller
NXVER=40
D3DVERN=9.19
D3DVER=
CDIR=$(pwd)
FXBDIR=$(pwd)/3dfx/build
MSBDIR=$(pwd)/mesa/build
TXTDIR=$(pwd)/texts
ISO=$(pwd)/iso
KJISO=$(pwd)/vmaddons

# Function to install wrappers
function wrapinstall {
echo "Installing compiled wrappers"
rm -rf $ISO/wine $ISO/wrapfx $ISO/wrapgl $ISO/readme.txt $ISO/license.txt $ISO/commit\ id.txt
mkdir -p $ISO/wrapfx $ISO/wrapgl
cp -rf $FXBDIR/* $ISO/wrapfx/
rm -rf $ISO/wrapfx/lib* $ISO/wrapfx/Makefile
cp -f $MSBDIR/* $ISO/wrapgl/
rm -f $ISO/wrapgl/Makefile
cp -f $TXTDIR/LICENSE $ISO/license.txt

}

# Function to make menu
function wineinstall {
echo "Installing wine libraries!"
PS3='Please enter your choice: '
OPTION1="Install kjliew's libraries (vmaddons.iso required!)"
OPTION2="Install JHRobotics's libraries"
OPTION3="Install adolfintel's libarires"
OPTION4="Skip"
options=( "$OPTION1"
                    "$OPTION2"
                    "$OPTION3"
                    "$OPTION4"

)
# Options
select opt in "${options[@]}"
do
    case $opt in
        "$OPTION1")
            if [ -f "/bin/bsdtar" ]; then
                if [ -f "$(pwd)/vmaddons.iso" ]; then
                    kjwine
                    break
                else
                     echo "vmaddons.iso not found"
                fi
            else
            echo  "bsdtar not found! Please install it"
            fi
            ;;
        "$OPTION2")
            if [ -f "/bin/wget" ]; then
                if [ -f "/bin/unzip" ]; then
                    jhwine
                    break
                else
                    echo "unzip not found! Please install it"
                fi
            else
                echo "wget not found! Please install it"
            fi
            ;;
        "$OPTION3")
            if [ -f "/bin/wget" ]; then
                if [ -f "/bin/unzip" ]; then
                    aiwine
                    break
                else
                    echo "unzip not found! Please install it"
                fi
            else
                echo "wget not found! Please install it"
            fi
            ;;
        "$OPTION4")
            echo "Skipping wine libraries"
            break
            ;;
        *) echo "$REPLY is not a valid option!";;
    esac
done

}
# Function to handle kjliew's wine libraries
function kjwine {
    echo "vmaddons.iso found! Extracting optional wrappers"
    mkdir $CDIR/vmaddons
    bsdtar xf vmaddons.iso --directory $CDIR/vmaddons

    echo "Installing optional wrappers"
    cp -rf $KJISO/win32/wine $ISO/
    cp -f $TXTDIR/readme_kjwine.txt $ISO/readme.txt
    for f in $ISO/wine/*/build-timestamp; do
        mv -- "$f" "${f%}.txt"
    done
    rm -rf $KJISO
    rm -f $ISO/wine/wine-get
}

# Function to handle adolfintel's wine libraries
function aiwine {
    if [ -f "$(pwd)/wined3d-$D3DVERN.zip" ]; then
        echo "zip file found"
       aiwineinstall
    else
        echo "Downloading adolfintel's wine libraries"
        wget -q --show-progress https://downloads.fdossena.com/Projects/WineD3D/Builds/WineD3DForWindows_$D3DVERN.zip --output-document=wined3d-$D3DVERN.zip
        aiwineinstall
    fi
}

function aiwineinstall {
    echo "Installing wrappers"
    mkdir -p $ISO/wine
    unzip wined3d-$D3DVERN.zip -d $ISO/wine
    mv -f  $ISO/wine/wined3d $ISO/wine/$D3DVERN
    cp -f $TXTDIR/readme_aiwine.txt $ISO/readme.txt
}


# Function to handle JHRobotics's wine libraries
function jhwine {
    if [ -f "$(pwd)/mmx-$NXVER.zip" ] && [ -f "$(pwd)/sse3-$NXVER.zip" ]; then
        echo "zip file found"
        jhwineinstall
    else
        echo "Downloading JHRobotics's wine libraries"
        wget -q --show-progress https://github.com/JHRobotics/wine9x/releases/download/v1.7.55.40/wine9x-1.7.55.$NXVER-mmx.zip --output-document=mmx-$NXVER.zip
        wget -q --show-progress https://github.com/JHRobotics/wine9x/releases/download/v1.7.55.40/wine9x-1.7.55.$NXVER-sse3.zip --output-document=sse3-$NXVER.zip
        jhwineinstall
    fi
}

function jhwineinstall {
    echo "Installing wrappers"
    mkdir -p $ISO/wine/mmx $ISO/wine/sse3
    unzip mmx-$NXVER.zip -d $ISO/wine/mmx
    unzip sse3-$NXVER.zip -d $ISO/wine/sse3
    cp -f $TXTDIR/readme_jhwine.txt $ISO/readme.txt
}

# Function to download wglgears if unavailable
function gearinstall {
if [ -f "$MSBDIR/wglgears.exe" ] || [ -f "$MSBDIR/wgltest.exe" ] || [ -f "$ISO/wrapgl/wglgears.exe" ]; then
        echo "wglgears or wgltest found!"
    else
        echo "wglgears or wgltest not found! Downloading"
        curl -o "$ISO/wrapgl/wglgears.exe" http://www2.cs.uidaho.edu/~jeffery/win32/wglgears.exe
fi
}

# Function to add commit ID
function commit {
    echo "Adding commit ID"
    echo $(git rev-parse HEAD) > $ISO/commit\ id.txt

}

# Function to create the ISO
function makeiso {
    echo "Making wrapper iso"
    mkisofs -JR -V 3DFX-WRAPPERS -o $CDIR/wrappers.iso $ISO/
}
## First step install
# Checking if folder exist
if [ -f "$ISO/qemu.ico" ] && [ -f "$ISO/autorun.inf" ] && [ -f "$ISO/open.bat" ] && [ -f "$TXTDIR/LICENSE" ] && [ -f "$TXTDIR/readme_aiwine.txt" ] && [ -f "$TXTDIR/readme_kjwine.txt" ] && [ -f "$TXTDIR/readme_jhwine.txt" ] && [ -f "$TXTDIR/readme_nodx.txt" ]; then
    echo "folders found!"
    wrapinstall
else
    if [ -f "/bin/git" ] && [ -f "/bin/curl" ]; then
        echo "downloading folders"
        mkdir -p $ISO $TXTDIR
        curl -o $ISO/autorun.inf https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/iso/autorun.inf
        curl -o $ISO/open.bat https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/iso/open.bat
        curl -o $ISO/qemu.ico https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/iso/qemu.ico
        curl -o $TXTDIR/LICENSE https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/texts/LICENSE
        curl -o $TXTDIR/readme_aiwine.txt https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/texts/readme_aiwine.txt
        curl -o $TXTDIR/readme_jhwine.txt https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/texts/readme_jhwine.txt
        curl -o $TXTDIR/readme_kjwine.txt https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/texts/readme_kjwine.txt
        curl -o $TXTDIR/readme_nodx.txt https://raw.githubusercontent.com/kharovtobi/qemu-3dfx/refs/heads/master/wrappers/texts/readme_nodx.txt
        wrapinstall
    else
        echo "git or curl not found! Please install it. Exiting"
        exit
    fi
fi


## Second step install
# Check for required binaries and run corresponding functions
wineinstall
gearinstall

if [ -f "/bin/git" ]; then
    commit
else
    echo "git not found! Skipping adding commit id"
fi

if [ -f "/bin/mkisofs" ]; then
    makeiso
else
    echo "mkisofs (cdrtools) not found! Please install it or manually make iso disk of the folder"
fi

echo "Installation Finished!"
