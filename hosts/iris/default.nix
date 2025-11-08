{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/home/steam.nix
    ./../../modules/core/virtualization.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/ollama.nix
  ];

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  networking = {
    hostName = "iris";
    networkmanager.enable = true;
  };

  networking = {
    interfaces.ens4d1 = {
      ipv4.addresses = [
        {
          address = "192.168.1.101";
          prefixLength = 24;
        }
      ];
    };
  };

  liv = {
    desktop.enable = true;
    creative.enable = true;
    amdgpu.enable = true;
    wine.enable = false; # use VM for this
    gui.enable = true;
  };

  # Enable ROCM support
  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = with pkgs; [
    pkgs.davinci-resolve
  ];

  boot = {
    kernelParams = [ ];
    kernelModules = [ "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
        v4l2loopback
      ]
      ++ [ pkgs.cpupower-gui ];
  };
}
