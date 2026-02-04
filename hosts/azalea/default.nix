{ username, ... }:
{
  imports = [
    #./hardware-configuration.nix
    #./../../modules/core
    #./../../modules/core/virtualization.nix
    #./../../modules/services/tailscale.nix
    #./../../modules/services/mpd.nix
    #./../../modules/services/smart-monitoring.nix
    #./../../modules/services/mullvad.nix
    #./../../modules/home/steam.nix
    #./../../modules/services/ollama.nix
    #./../../modules/services/automount.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;
  system.primaryUser = username;
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };
    casks = [
      # "steam"
      "libreoffice"
      "signal"
      "handbrake"
      "tailscale"
      "ungoogled-chromium"
      # "orca-slicer"
      "element"
      "raycast"
      "anki"
    ];
  };
}
