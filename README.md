<h1 align="center">
   <img src="./.github/assets/logo/nixos-logo.png  " width="100px" /> 
   <br>
      Ahwxorg/NixOS-config
   <br>
      <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px" /> <br>
   <div align="center">

   <div align="center">
      <p></p>
      <div align="center">
         <a href="https://github.com/Ahwxorg/nixos-config/stargazers">
            <img src="https://img.shields.io/github/stars/Ahwxorg/nixos-config?color=F5BDE6&labelColor=303446&style=for-the-badge&logo=starship&logoColor=F5BDE6">
         </a>
         <a href="https://github.com/Ahwxorg/nixos-config/">
            <img src="https://img.shields.io/github/repo-size/Ahwxorg/nixos-config?color=C6A0F6&labelColor=303446&style=for-the-badge&logo=github&logoColor=C6A0F6">
         </a>
         <a = href="https://nixos.org">
            <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3">
         </a>
         <a href="https://github.com/Ahwxorg/nixos-config/blob/main/LICENSE">
            <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=313244&colorB=F5A97F&logo=unlicense&logoColor=F5A97F&"/>
         </a>
      </div>
      <br>
   </div>
</h1>

### Gallery

<p align="center">
   <img src="./.github/assets/screenshots/sakura-desktop.png" /> <br>
   Screenshots last updated <b>2024-09-04</b>
</p>

# Overview

> [!WARNING]
> This flake/config has quite high "sometimes I want to quit technology and become a farmer" levels. Stability is not guaranteed.

### Layout

- [flake.nix](flake.nix): base of the configuration
- [variables.nix](variables.nix): base variables useful for all hosts
- [hosts](hosts): per-host configurations that contain host specific settings
  - [yoshino](hosts/yoshino/): Desktop (yoshino) specific configuration
  - [sakura](hosts/sakura/): Laptop (sakura) specific configuration
  - [ichiyo](hosts/ichiyo/): Laptop (ichiyo) specific configuration
  - [violet](hosts/violet/): Server (violet) specific configuration
  - [dandelion](hosts/dandelion/): Server (dandelion) specific configuration
- [modules](modules): modularized NixOS configurations
  - [core](modules/core/): core NixOS configuration
  - [homes](modules/home/): my [Home-Manager](https://github.com/nix-community/home-manager) config
  - [services](modules/services/): services ran on my servers
- [pkgs](flake/pkgs): packages exported by my flake
- [roles](roles/): roles to easier define tasks per host

### Components

|                             |          NixOS + Hyprland          |
| --------------------------- | :--------------------------------: |
| **Compositor**              |        [hyprland][hyprland]        |
| **Bar**                     |          [waybar][waybar]          |
| **Application launcher**    |          [bemenu][bemenu]          |
| **Notification daemon**     |          [swaync][swaync]          |
| **Terminal emulator**       |           [kitty][kitty]           |
| **Shell**                   |             [zsh][zsh]             |
| **Text editor**             |          [neovim][neovim]          |
| **Network management tool** |  [networkmanager][networkmanager]  |
| **File manager**            |          [thunar][thunar]          |
| **Fonts**                   |      [nerd fonts][nerd fonts]      |
| **Lockscreen**              |        [hyprlock][hyprlock]        |
| **Image viewer**            |           [nsxiv][nsxiv]           |
| **Media player**            |             [mpv][mpv]             |
| **Screenshot software**     |       [grimblast][grimblast]       |
| **Clipboard**               | [wl-clip-persist][wl-clip-persist] |
| **Color picker**            |      [hyprpicker][hyprpicker]      |

### Shell aliases

<details>
<summary>
NixOS (expand)
</summary>

> TODO: ${host} is one of the above-defined hosts

- `ns` $\rightarrow$ `nix-shell --run zsh`
- `nix-switch` $\rightarrow$ `sudo nixos-rebuild switch --flake ~/nixos-config#${host}`
- `nix-clean` $\rightarrow$ `sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d`
</details>

### Scripts

All the scripts are in `modules/home/scripts/scripts/` and are exported as packages in `modules/home/scripts/default.nix`

<details>
<summary>
toggle_blur.sh 
</summary>

**Description:** This script toggles the Hyprland blur effect. If the blur is currently enabled, it will be disabled, and if it's disabled, it will be turned on.

**Usage:** `toggle_blur`

</details>

<details>
<summary>
toggle_oppacity.sh 
</summary>

**Description:** This script toggles the Hyperland oppacity effect. If the oppacity is currently set to 0.90, it will be set to 1, and if it's set to 1, it will be set to 0.90.

**Usage:** `toggle_oppacity`

</details>

<details>

# Installation

> This is unchanged of Frost-Phoenix's dots, needs to be remade but don't feel like spending that time currently.

> **⚠️ Use this configuration at your own risk! ⚠️** <br>
> Applying custom configurations, especially those related to your operating system, can have unexpected consequences and may interfere with your system's normal behavior. While I have tested these configurations on my own setup, there is no guarantee that they will work flawlessly on all systems. <br> > **I am not responsible for any issues that may arise from using this configuration.**

> It is highly recommended to review the configuration contents and make necessary modifications to customize it to your needs before attempting the installation.

1. **Install NixOS**

   First install nixos using any [graphical ISO image](https://nixos.org/download.html#nixos-iso).

2. **Clone the repo**

   ```
   nix-shell -p git
   git clone https://github.com/ahwxorg/nixos-config
   cd nixos-config
   ```

3. **Install script**

   > TODO: change the install script to work with all hosts, allow for new host creation, etc.

   Execute and follow the installation script :

   ```
   ./install.sh
   ```

4. **Reboot**

5. **Manual config**

> Even though I use home manager, there is still a little bit of manual configuration to do, namely SSH keys and browser configuration.

# 👥 Credits

Other dotfiles that I learned / copy from:

- [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config): This is the repository that I cloned and changed to my needs. Their credits are in their repository's readme.
- [notthebee/nix-config](https://github.com/notthebee/nix-config)
- [mrusme/dotfiles](https://github.com/mrusme/dotfiles)

<!-- Links -->

[hyprland]: https://github.com/hyprwm/Hyprland
[kitty]: https://github.com/kovidgoyal/kitty
[waybar]: https://github.com/Alexays/Waybar
[bemenu]: https://github.com/Cloudef/bemenu
[zsh]: https://en.wikipedia.org/wiki/Z_shell
[hyprlock]: https://github.com/hyprwm/hyprlock
[mpv]: https://github.com/mpv-player/mpv
[VSCodium]: https://vscodium.com/
[neovim]: https://github.com/neovim/neovim
[grimblast]: https://github.com/hyprwm/contrib
[htop]: https://github.com/htop-dev/htop
[thunar]: https://docs.xfce.org/xfce/thunar/start
[nsxiv]: https://nsxiv.codeberg.page
[swaync]: https://github.com/ErikReider/SwayNotificationCenter
[nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[networkmanager]: https://wiki.gnome.org/Projects/NetworkManager
[network-manager-applet]: https://gitlab.gnome.org/GNOME/network-manager-applet/
[wl-clip-persist]: https://github.com/Linus789/wl-clip-persist
[hyprpicker]: https://github.com/hyprwm/hyprpicker
