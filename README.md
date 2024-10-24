# Setup

Setup for a fresh installation of Debian 12.

If you set a root password during the Debian installation, you will need to install `sudo` because it isn't installed by default. To do so, change to the root user, install sudo, and add your user account to the sudo group.

```sh
$ su -
$ apt install sudo
$ adduser colin sudo
```

For the changes to take effect, you must log out and back in again. Ensure that you are a member of the sudo group by executing the `groups` command. Now, to execute sudo commands without requiring the root password, you can do so by editing the `/etc/sudoers` file. Edit this file by executing the `sudo visudo` command and place the following line at the end of the file: `colin ALL=(ALL) NOPASSWD:ALL`.

Install one of the dropbox releases from [here](https://linux.dropboxstatic.com/packages/debian/). Dropbox might require the `python3-gpg` package, in which case it will notify you that this package is missing when you try to install the daemon.

Install the `DroidSansM` nerd font a place it in `~/.local/share/fonts`. Execute `fc-cache -v` to now update the font cache.

Now begin installing additional tools/applications. Make a directory called `~/apps` to house all user-specific binaries not installed through the system package manager.

Install Obsidian. I've been using the AppImage without issue and then use a desktop entry to launch Obsidian from the desktop environment application launcher.

Install Neovim. I've installed the latest stable release from [here](https://github.com/neovim/neovim/blob/master/INSTALL.md). Install it to `~/apps/nvim`.

Neovim doesn't integrate with the system clipboard by default, so a system package must be installed to allow Neovim an interface to the Wayland clipboard, allowing copying/pasting of text to/from Neovim. We can install `wl-clipboard` for this. Heres a list of packages to install for Neovim. Having these installed will help with Neovim healthchecks:

```sh
sudo apt install wl-clipboard luarocks ripgrep
```

Install Kitty terminal emulator. The binary provided by the Debian package manager was really out of date when I tried it, so I installed it from [here](https://sw.kovidgoyal.net/kitty/binary/).

**TODO**: install the kitty binary to `~/apps` instead of `~/.local/kitty.app`.

Install Yazi. I built it from source as described [here](https://yazi-rs.github.io/docs/installation/#build-from-source). The build process requires the Rust toolchain, and installing Rust might make changes to your `.bashrc` and/or `.profile` to ensure that environment variables for the toolchain are defined. If the toolchain is installed at `~/.cargo`, my `.profile` should already be configured to source the necessary shell script, so whatever changes are made the to the shell scripts from the Rust installation *should* be able to be removed. I placed the install directory in `~/apps/yazi`. The build process will require `make` and `gcc`, so make sure these are installed as such: `sudo apt install gcc build-essential`.

If it doesn't already exist, create `~/.local/bin` directory. This is where we should place symlinks to user-specific applications. This directory should already be on our `$PATH`. Each binary that we have in our `~/apps` directory should have a corresponding symlink placed in the `~/.local/bin` directory. Here's a list of symlinks this directory should have so far:

```sh
$ ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
$ ln -s ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten
$ ln -s ~/apps/yazi/target/release/yazi ~/.local/bin/yazi
```

# Symlink Manifests

Each configuration file in this repo should have a corresponding symlink placed somewhere on the filesystem. I presently have manifest containing a list of each symlink file and it's location on the file system. In the future, I need to make some script for easily adding/removing symlinks from the filesystem.
