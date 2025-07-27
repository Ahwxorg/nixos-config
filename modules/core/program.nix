{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = "";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    dig
    traceroute
  ];
}
