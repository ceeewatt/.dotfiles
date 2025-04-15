# Setup

Setup for a fresh installation of Debian 12.

If you set a root password during installation, you will need to install `sudo` as it isn't installed by default. To do so, change to the root user, install sudo, and add your user account to the sudo group.

```sh
$ su -
$ apt install sudo
$ adduser <user> sudo
```

For the changes to take effect, you must log out and back in again. Ensure that you are a member of the sudo group by checking the output of the `groups` command. To execute sudo commands without requiring the root password, add an entry to the `/etc/sudoers` file. Edit this file by executing the `sudo visudo` command and place the following line at the end of the file: `<user> ALL=(ALL) NOPASSWD:ALL`.

Download and build/install the following to the `~/apps` directory:
- [Dropbox](https://linux.dropboxstatic.com/packages/debian/)
    - Installation might require the `python3-gpg` package.
- [Obsidian](https://obsidian.md/download)
- [Inkscape](https://inkscape.org/release)
- [Neovim](https://github.com/neovim/neovim/releases)
- [Yazi](https://github.com/sxyazi/yazi/releases)
- [Kitty](https://github.com/kovidgoyal/kitty/releases)
- [Tofi](https://github.com/philj56/tofi)
    - newly added in trixie repositories
- [Gomi: trash cli](https://github.com/babarot/gomi)

Download the following fonts to `~/.local/share/fonts`, and then run `fc-cache -f -v` to update the font cache. See [issue #20](https://github.com/ceeewatt/.dotfiles/issues/20) for more info.
- [Terminal font: Iosevka - Monospace, Default (Super TTC)](https://github.com/be5invis/Iosevka/releases)
- [Waybar font: Iosevka Patched Nerd Font (Proportional)](https://github.com/ryanoasis/nerd-fonts/releases)
- Tofi font: Cousine

Add `contrib` and `non-free` components to `/etc/apt/sources.list`. See [SourcesList](https://wiki.debian.org/SourcesList#Example_sources.list):

```
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
```

Install the packages listed in the [apt_packages.txt](apt_packages.txt).

For waybar, if using the keyboard state module, ensure your user is a member of the `input` group (run `usermod -aG input <username>` and log out / back in).

# Symlink Manifest

I keep a running list of all user-created symbolic links (mostly useful for keeping my dotfiles under version control) in `manifest.symp`, which I interface with using a custom shell script. See [symp](scripts/symp/symp.md).

# Printer

Install the [drivers](https://www.usa.canon.com/support/p/pixma-ts6420a) for my Canon PIXMA TS6420a wireless printer. For printing, I've mostly used the [CUPS web interface](http://localhost:631/) and the command line `lp` utility.

# Window Manager

I'm currently using sway, for i3-replacement for Wayland. If, during installation, you install any of the available desktop environments, you'll need to change the systemd default target: `systemctl set-default multi-user.target`. Now, after logging in, the login shell will execute sway (see [.profile](system/.profile)). To switch back to an installed desktop environment, execute the command `systemctl set-default graphical.target` and change the `.profile` script accordingly to avoid starting sway. Note that I'm not currently using a login manager; thus, I'm relying on my login shell to start up sway. If I decide to switch to using a login manager, I'll need to change how sway gets invoked.

Note that sway supposedly has known issue with the proprietary Nvidia drivers, so keep that in mind if I switch up my hardware.

Here are some of the sway/Wayland compatible desktop tools I use. See other useful addons [here](https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway).
- waybar: status bar
- ~~wofi~~: application launcher
    - replaced with tofi
- swaylock & swayidle: idle timeout and screenlock
- sway notification center: desktop notification daemon

Other useful tools:
- [i3keys](https://github.com/RasmusLindroth/i3keys) for visualizing sway keybindings
- `wev` for debugging Wayland events (this can be useful for seeing which keys correspond to which keycodes)
- `xeyes` will tell you when a window is using native Wayland or XWayland

# Neovim

Plugins:
- Plugin manager:
    - https://github.com/folke/lazy.nvim
- Syntax highlighting:
    - https://github.com/nvim-treesitter/nvim-treesitter
- Language server:
    - https://github.com/neovim/nvim-lspconfig
    - https://github.com/williamboman/mason.nvim
    - https://github.com/williamboman/mason-lspconfig.nvim
- Completion:
    - https://github.com/hrsh7th/nvim-cmp
- Picker + Previewer:
    - https://github.com/nvim-telescope/telescope.nvim
- Others:
    - status line: https://github.com/nvim-lualine/lualine.nvim
    - file explorer: https://github.com/mikavilpas/yazi.nvim
    - obsidian/markdown integration: https://github.com/epwalsh/obsidian.nvim
    - keybindings helper: https://github.com/folke/which-key.nvim

# Other Tools

- `sxiv`: image viewer
    - doesn't have native support for Wayland (thus, requires XWayland)
- `yazi`: file explorer
- `zathura`: pdf viewer
- `kitty`: terminal emulator
- `grim` + `slurp`: screenshots
- `zoxide`: better `cd`
- `fzf`: fuzzy finder

# Theme

- Everforest palette: https://github.com/sainnhe/everforest/blob/master/palette.md
- Desktop background: https://github.com/Apeiros-46B/everforest-walls/blob/main/other/japanese_pedestrian_street.png
- Firefox theme: https://addons.mozilla.org/en-US/firefox/addon/everforest-dark-medium-theme/
- Neovim theme: https://github.com/neanias/everforest-nvim

# TODO

- [ ] Auto-mountwng of removeable drives
    - `udisksctl` works well enough for now
- [ ] Waybar better audio control / slider
    - I'm waiting for Debian waybar package version [v0.9.23+](https://github.com/Alexays/Waybar/releases/tag/0.9.23) b/c I want the `pulseaudio/slider` module
- [ ] Login manager
- [ ] Systemd suspend, hibernate, etc integration
- [ ] Better network configuration tool
- [ ] Clipboard history manager
    - https://github.com/sentriz/cliphist
- [ ] Kitty scrollback buffer
    - https://github.com/kovidgoyal/kitty/issues/719
    - https://github.com/kovidgoyal/kitty/discussions/3786
- [ ] CLI bookmark manager
    - [nb](https://github.com/xwmx/nb)
    - [linkhut](https://linkhut.org/about/)
- [ ] RSS feed reader
    - [newsboat](https://github.com/newsboat/newsboat)
