{
  pkgs,
  inputs,
  self,
  ...
}:
{
  imports = [
    # ./../../modules/core/homebrew.nix
    ./../../modules/core/user.nix
    # ./../../modules/core/skhd.nix
    ./../../modules/core/yabai.nix
    #./../../modules/core/virtualization.nix
    #./../../modules/services/tailscale.nix
    #./../../modules/services/mpd.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
  nix.settings.experimental-features = "nix-command flakes";
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
        FXPreferredViewStyle = "clmv";
      };
      iCal."first day of week" = "Monday";
      screencapture.include-date = true;
      screencapture.type = "png";
      spaces.spans-displays = false;
    };
  };
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    taps = [
      "homebrew/homebrew-core"
      "homebrew/homebrew-cask"
      # "FelixKratz/formulae"
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
      # "svim"
    ];
    casks = [
      "qbittorrent"
      "libreoffice"
      "signal"
      "ungoogled-chromium"
      # "orca-slicer"
      "element"
      "raycast"
      "anki"
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
      # "svim"
      # "font-sketchybar-app-font"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # imports = [ ../flake/modules/home/zsh.nix ];
  environment.systemPackages = [
    pkgs.vim
    inputs.nixvim.packages.${pkgs.system}.default
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
