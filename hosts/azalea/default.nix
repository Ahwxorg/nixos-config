{
  pkgs,
  inputs,
  self,
  username,
  ...
}:
{
  imports = [
    ./../../modules/core/default.azalea.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system = {
    primaryUser = "liv";
    stateVersion = 6;
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        show-recents = false;
        # showHidden = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        CreateDesktop = false;
        FXPreferredViewStyle = "Nlsv"; # list view
        # FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
      };
      # "com.apple.finder".NewWindowTargetPath = "file:///Users/${username}/";
      iCal."first day of week" = "Monday";
      screencapture.include-date = true;
      screencapture.type = "png";
      spaces.spans-displays = false;
      loginwindow.GuestEnabled = false;
    };
  };
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    taps = [
      "homebrew/homebrew-core"
      "homebrew/homebrew-cask"
      "FelixKratz/homebrew-formulae"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };
    brews = [
      "imagemagick"
      "virt-manager"
      "svim"
      "nowplaying-cli"
      "switchaudio-osx"
      "lua"
      "mpv"
      "syncthing"
    ];
    casks = [
      "steam"
      "kdenlive"
      "ti-connect-ce"
      "royal-tsx"
      "obs"
      "supertuxkart"
      "vial"
      "thunderbird"
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
      "darktable"
      "qbittorrent"
      "libreoffice"
      "signal"
      "ungoogled-chromium"
      "keepingyouawake"
      # "yubikey-agent"
      "docker-desktop"
      "pinta"
      "winbox"
      "orcaslicer"
      "element"
      "anki"
      "homerow"
      "firefox"
      "kitty"
      "spotify"
      "nextcloud"
      "handbrake-app"
      "tailscale-app"
      "ungoogled-chromium"
      "karabiner-elements"
      "bitwarden"
      "gimp"
      "betterdisplay"
      "mullvad-vpn"
      "maccy"
      "spotmenu"
      "utm"
      "syncthing-app"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # imports = [ ../flake/modules/home/zsh.nix ];
  environment.systemPackages = [
    pkgs.vim
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.lazygit
    pkgs.eza
    pkgs.exiftool
    pkgs.fzf
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "jitsi-meet-1.0.8043"
      "olm-3.2.16"
      "libsoup-2.74.3"
    ];
    overlays = [
      self.overlays.default
      inputs.nur.overlay
      inputs.nixocaine.overlays.default
    ];
  };
}
