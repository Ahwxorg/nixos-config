{ self, pkgs, lib, inputs, ...}: 
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # nixpkgs = {
  #   overlays = [
  #     self.overlays.default
  #     inputs.nur.overlay
  #   ];
  # };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "jitsi-meet-1.0.8043"
      "olm-3.2.16"
    ];
    overlays = [
      self.overlays.default
      inputs.nur.overlay
    ];
  };

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];
  
  # Font packages
  environment.systemPackages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ipaexfont
  ];

  time.timeZone = "Europe/Amsterdam";
  system.stateVersion = "24.05";
}
