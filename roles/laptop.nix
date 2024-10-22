{ lib, pkgs, config, username, home-manager, ... }:
with lib;
let
  cfg = config.liv.laptop;
in {
  options.liv.laptop = {
    enable = mkEnableOption "Enable laptop";
  };

  config = mkIf cfg.enable {
    home-manager = {
      users.${username} = {
        home.packages = with pkgs; [
          # reader
          acpi
          brightnessctl
        ];
      };
    };

    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
      powertop
    ];
    boot = {
      kernelModules = ["acpi_call"];
      extraModulePackages = with config.boot.kernelPackages;
        [
          acpi_call
        ];
      };
    services = {    
      # thermald.enable = true; # Enable if on Intel, should be a if-statement.
      power-profiles-daemon.enable = true;
 
      upower = {
        enable = true;
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 5;
        criticalPowerAction = "Hibernate";
      };
    };
    powerManagement.powertop.enable = true;
  };
}



# { config, pkgs, lib, ... }:
# with lib;
# let
#   cfg = config.liv.profiles;
#   laptopPkgs = with pkgs; [
#     acpi
#     brightnessctl
#   ];
# in
# {
#   options = {
#     liv-laptop = lib.mkOption {
#       default = false;
#       type = lib.types.bool;
#       description = ''
#         Enable this if the host is a laptop, to enable power management, extra packages, kernel modules, etc.
#       '';
#     };
#   };
# 
#   config = lib.mkIf cfg.liv-laptop {
#     home.packages = with pkgs; [
#       # reader
#       vlc
#     ] ++ optionals cfg.liv-laptop laptopPkgs;
# 
# 
#     networking.networkmanager.enable = true;
# 
#     environment.systemPackages = with pkgs; [
#       cpupower-gui
#       powertop
#     ];
#     # auto-cpufreq = {
#     #   enable = false;
#     #   settings = {
#     #     battery = {
#     #       governor = "powersave";
#     #       turbo = "auto";
#     #     };
#     #     charger = {
#     #       governor = "performance";
#     #       turbo = "auto";
#     #     };
#     #   };
#     # };
#     boot = {
#       kernelModules = ["acpi_call"];
#       extraModulePackages = with config.boot.kernelPackages;
#         [
#           acpi_call
#           cpupower
#         ]
#         ++ [pkgs.cpupower-gui];
#       };
#     services = {    
#       thermald.enable = true;
#       cpupower-gui.enable = true;
#       # power-profiles-daemon.enable = true;
#  
#       upower = {
#         enable = true;
#         percentageLow = 20;
#         percentageCritical = 5;
#         percentageAction = 3;
#         criticalPowerAction = "PowerOff";
#       };
#     };
#   };
# }
