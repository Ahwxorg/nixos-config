{ pkgs, ... }:
{
  virtualisation = {
    # vmware.host.enable = true; # Causes issues for now :p
    waydroid.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  # Enable qemu etc
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];
}
