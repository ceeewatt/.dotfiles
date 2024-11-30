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

# Window Manager

Here's some info from someone who has configured their Debian 12 to run Sway: https://shorturl.at/d4fuz.

I installed sway from the system package: `apt install sway`. Note that Sway has known issues with the proprietary Nvidia drivers, so keep in mind what hardware your system is using. I've initially gone through setting Sway up on my Dell Optiplex machine which uses an Intel card, so I haven't ran into any potential Nvidia issues.

I'm currently in the process of switching from the default Gnome desktop environment to the Sway tiling window manager. When I launch Sway from the Gnome Display Manager (GDM), I was running into a problem where my `~/.profile` script was not executing. I don't have much of a reason to continue using a display manager - let alone the Gnome Display Manager - so I'm currently not using one at all. I've currently disabled GDM by changing the systemd default target (See: https://shorturl.at/WlsSL). This is done by executing the following command as root: `systemctl set-default multi-user.target`.

To re-enable the display manager, use `systemctl set-default graphical.target`.

For an explanation of systemd targets, see https://shorturl.at/ZYHuK.

I thought this blogpost was pretty helpful in troubleshooting my initial issue with my `.profile` not getting sourced: https://shorturl.at/mM55T.

## Sway Keybindings

Here's a useful tool for visualizing which keybindings are currently used: [i3keys](https://github.com/RasmusLindroth/i3keys).

Additionally, `wev` is a tool for debugging Wayland events (such as keypresses). This is helpful for seeing which keys on the keyboard correspond to which keycodes.

## Addons

The downside of switching from a Desktop Environment (DE), such as Gnome, to a Window Manager (WM), such as Sway, is that you no longer have all the tools you're used to having in a normal desktop. For example, the Sway WM does not provide out of the box support for controlling the volume or configuring network settings - you must find 3rd party tools to do these things or implement them yourself.

The Sway wiki provides a list of [Useful Addons](https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway) that are known to be compatible with Sway.

### Application Launcher

The first addon I installed was an application launcher, called [wofi](https://hg.sr.ht/~scoopta/wofi). I installed it from the system package manager (`apt install wofi`). This tool provides a gui interface for launching programs, such as those that have a *.desktop file associated with them. In my Sway config file, there's a command for establishing the keybinding to launch wofi. Note that this program is no longer actively maintained, so I might need to choose a different one in the future.

### Volume Control

Concepts:
- Sound Server
- Name pipe (FIFO) for Inter Process Communication
- Systemd units

The next addon is for controlling the system volume (or anything that might need a progress bar, such as brightness). [Wob](https://github.com/francma/wob) is a daemon that adjusts the levels of a graphical progress bar when you change its input value. On the github page, there's an example of how to setup/configure this tool (See: [wob/contrib](https://github.com/francma/wob/tree/master/contrib)). The exact example I followed was for controlling the volume using PulseAudio (pamixer).

As I have recently learned, there are various Linux tools for controlling system audio. These are called [Sound Servers](https://wiki.debian.org/Sound?action=show&redirect=CategorySound). By default, my Debian 12 installation used [PipeWire](https://wiki.debian.org/PipeWire), which appears to be a more modern tool), but I decided to instead install [PulseAudio](https://wiki.debian.org/PulseAudio) (`apt install pulseaudio`). I don't think this was necessary at all, and I might in the future use the default PipeWire instead.

Pamixer (`apt install pamixer`) is a command line tool for controlling volume levels for PulseAudio. With PulseAudio and pamixer installed, I could now update my Sway config with the proper commands to adjust audio levels via some keybindings and subsequently control a wob progress bar.

Wob works by integrating with systemd to have background process (daemon) that updates a progress bar when the value of its input changes. In the Sway config, we created a name pipe (FIFO). Whenever we update the volume using pamixer, we read out the current volume level into this named pipe. The wob daemon then uses this new value to update the progress bar.

### Image Viewer

Presently, I'm using sxiv (`apt install sxiv`). This is the best image viewer I'm found so far, but unfortunately it's only build for X, meaning it requires the use of XWayland. Functionally, I don't think this matters at all, but it would be nice to use a program that works natively in Wayland. There is current a small project I found on Github that claims to port sxiv to Wayland but for now, I'm happy using sxiv + XWayland.

Note: the tool `xeyes` can be used to tell when a window is using native Wayland or XWayland. When you hover your mouse over a window that uses XWayland, the eyes will move. Otherwise, the eyes don't move when hovering your mouse over a Wayland window.

### Auto-mounting of Removable Drives

Presently, I don't have a tool installed for automatically mounting removeable drives. It's relatively painless so do so manually, though, using the `udisksctl` utility. The traditional method of mounting a removeable drive involves the following steps:

1. Plug in device.
2. Find the block device using `fdisk -l` or `lsblk`. Let's say the disk is named sdb and has a partition we want to mount named sdb1.
3. Use the `mount` command to mount the partition to a specified location on the filesystem. Typically, we want removeable drives to be mounted under `/media/<user>/<device name>`. If this directory does not exist, we must first make it before mounting.
4. When finished with the device, use the `umount` command to unmount it. Now the device can be unplugged.

With the `udisksctl`, we don't have to manually create (and remove) a directory from `/media/<user>/`. To mount a device (e.g.: /dev/sdb1), we invoke `udisksctl mount -b /dev/sdb1', and the utility will automatically mount the device somewhere in `/media/<user>/`. Likewise, to unmount a device, we invoke `udisksctl unmount -b /dev/sdb1', and the device will be unmounted and the mount point directory will be removed.

### Screenshot

There's a tool called [grim](https://git.sr.ht/~emersion/grim/) (`apt install grim`) which is designed for capturing screenshots from a Wayland window. Grim can be supplemented with a tool called [slurp](https://github.com/emersion/slurp) (`apt install slurp`), which allows you to select a region of your screen. These two tools can be easily combined to create a dynamic screenshot tool that allows you to either take a picture of your entire screen or a selected region of your screen.

Grim checks for an environment variable named `GRIM_DEFAULT_DIR`, which I presently have set to `~/Pictures/Screenshots`. I have Sway keybindings for both saving screenshots to this directory or for copying screenshots to the clipboard.

Note that presently, I'm only using a single monitor for my setup, which makes using Grim simple. If I decide to add more monitors, I'll need to update the commands I'm using in my Sway config.

Also note that presently, I have no tool for issuing a notification when a screenshot is taken.

### Notifications

### Idle/Locking

I'm using [swayidle](https://github.com/swaywm/swayidle) (`apt install swayidle`) and [swaylock](https://github.com/swaywm/swaylock) (`apt install swaylock`) for handling of locking the computer after a period of inactivity. Swayidle is daemon that runs certain commands when idle activity is detected and Swaylock locks the screen, which can then be unlocked once the user password is entered.

In the Sway config, we `exec` a swayidle command that handles the screen locking and turning off after a period of time.

The appearance of Swaylock can be configured and presently, I downloaded a random image to use as the background of the lock screen. I'll want to reconfigure this at some point.

### TODO

- [ ] Idle configuration
- [ ] Notifications
- [ ] Tool for setting background
- [ ] Tool for network configuration
- [ ] Natively-Wayland sxiv-like image viewer
- [ ] Auto-mount removeable drives
