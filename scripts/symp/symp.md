# Overview

Symp is a symbolic link placer - I used to keep track of symlinks across my system. It's basically my own (poor) implementation of GNU Stow. Symlinks are stored in a top level `manifest.symp` file.

# Bootstrap

If you're running symp for the first time and you don't have an existing manifest file, you should start by adding `symp.sh` to your PATH. Navigate to the directory containing the script and execute the following command with root privileges: `./symp.sh add symp.sh /usr/local/bin`. Assuming `/usr/local/bin` is on your PATH, you can now invoke the script from anywhere on the filesystem as any user, and you can begin populating your manifest file with symlinks.

If you're initializing a new system with an existing manifest file, run `symp.sh init` (you might need root privileges if any of the symlinks in the manifest are placed in privileged directories). This command will run through each entry of the manifest and create the specified symlink if it doesn't already exist.
