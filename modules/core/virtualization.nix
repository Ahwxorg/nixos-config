{ pkgs, host, ... }:
{
  virtualisation = {
    # vmware.host.enable = true; # Causes issues for now :p
    waydroid.enable = if (host == "sakura") then true else false;
    libvirtd.enable =
      if (host == "violet") then
        true
      else if (host == "sakura") then
        true
      else if (host == "yoshino") then
        true
      else if (host == "iris") then
        true
      else
        false;
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  # Enable qemu etc
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];
}
