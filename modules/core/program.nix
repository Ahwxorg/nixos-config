{ pkgs, agenix, ... }:
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
    # agenix.packages.x86_64-linux.default
  ];
}
