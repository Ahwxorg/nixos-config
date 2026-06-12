{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.liv.gui;
in
{
  options.liv.fw13 = {
    enable = mkEnableOption "Enable FW13 specific options";
  };

  config = mkIf cfg.enable {
    imports = [ inputs.nixos-hardware.nixosModules.framework-13-intel ];

    # Disable light sensors and accelerometers as they are not used and consume extra battery
    hardware.sensor.iio.enable = lib.mkForce false;

    hardware.framework = {
      amd-7040.preventWakeOnAC = true;
      # laptop13.audioEnhancement.enable = true;
    };

    boot.kernelParams = [
      "acpi_osi=\"!Windows 2020\"" # otherwise GPU does weird shit that makes the computer look like the RAM is broken
    ];

    # change battery led to blue on suspend to indicate device is in suspend mode
    systemd.services."suspend-led-set" = {
      description = "blue led for sleep";
      wantedBy = [ "suspend.target" ];
      before = [ "systemd-suspend.service" ];
      serviceConfig.type = "simple";
      script = ''
        ${pkgs.fw-ectool}/bin/ectool led battery blue
      '';
    };
    systemd.services."suspend-led-unset" = {
      description = "auto led after sleep";
      wantedBy = [ "suspend.target" ];
      after = [ "systemd-suspend.service" ];
      serviceConfig.type = "simple";
      script = ''
        ${pkgs.fw-ectool}/bin/ectool led battery auto
      '';
    };
  };
}
