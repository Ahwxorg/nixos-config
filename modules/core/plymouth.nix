{
  pkgs,
  lib,
  ...
}:
{
  # TODO: add https://github.com/FraioVeio/plymouth-xp-theme
  boot = {
    plymouth = {
      enable = lib.mkDefault true;
      theme = "lone";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
          # selected_themes = [ "sliced" ];
          # selected_themes = [ "rings" ];
          # selected_themes = [ "red_loader" ];
          # selected_themes = [ "dna" ];
          # selected_themes = [ "hexagon_dots" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 1;
  };
}
