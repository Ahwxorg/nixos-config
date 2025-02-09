{ pkgs, config, lib, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];


  # kvm/qemu doesn't use UEFI firmware mode by default.
  # so we force-override the setting here 
  # and configure GRUB instead.
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = true;
      device = "/dev/vda";
      useOSProber = false;
    };
  };

  # allow local remote access to make it easier to toy around with the system
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      # PasswordAuthentication = lib.mkOverride true;
      AllowUsers = null;
      # PermitRootLogin = "yes";
    };
  };
}
