# Arch Linux Dependencies
This text file shows what dependencies you need to compile qemu-3dfx on Arch-Based Distributions.
(not finished)

Please Note! that the build differs from one computer from another due to what packages you have.
So don't expect it to run your compiled package on your friend's computer or distribute it somewhere
if the computer don't have required packages. (unless you add .so files into dir (not tested))

# Required Packages
base-devel
git
gcc
gcc-libs
rsync
patch
python
sh

# Recommended Packages
capstone
fuse3
virglrenderer (For GPU)
mesa (for passthrough)

# Optional Packages
pmdk (Persistent Memory Support)
brltty (Braille Display Driver)

# Not Available
appleframeworks (only for MacOS)

