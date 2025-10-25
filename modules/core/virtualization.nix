{
  pkgs,
  host,
  config,
  username,
  ...
}:
{
  virtualisation = {
    # vmware.host.enable = true; # Causes issues for now :p
    waydroid.enable = if (host == "sakura") then true else false;
    libvirtd.enable =
      if (host == "violet") then
        true
      else if (host == "dandelion") then
        true
      else if (host == "sakura") then
        true
      else if (host == "yoshino") then
        true
      else if (host == "iris") then
        true
      else if (host == "imilia") then
        true
      else
        false;
    spiceUSBRedirection.enable =
      if (config.virtualisation.libvirtd.enable == true) then true else false;
  };

  programs.virt-manager.enable =
    if (config.virtualisation.libvirtd.enable == true) then true else false;
  #dconf.settings."org/virt-manager/virt-manager/connections" =
  #  if (config.programs.virt-manager.enable == true) then
  #    {
  #      autoconnect = [ "qemu:///system" ];
  #      uris = [ "qemu:///system" ];
  #    }
  #  else
  #    { };

  users.groups.libvirtd.members =
    if (config.virtualisation.libvirtd.enable == true) then [ username ] else [ ];

  # Enable qemu etc
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];
}
