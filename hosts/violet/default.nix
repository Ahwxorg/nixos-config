{ pkgs, config, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.violet.nix
    ./../../modules/services/violet.nix
  ];

  networking.hostName = "violet";

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];


  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    pkgs.kitty.terminfo
    acpi
    brightnessctl
    cpupower-gui
    powertop
  ];
  
  services = {    
    thermald.enable = true;
    # cpupower-gui.enable = true;
    # power-profiles-daemon.enable = true;

    # auto-cpufreq = {
    #   enable = true;
    #   settings = {
    #     battery = {
    #       governor = "powersave";
    #       turbo = "auto";
    #     };
    #     charger = {
    #       governor = "performance";
    #       turbo = "auto";
    #     };
    #   };
    # };
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
}
