{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  services.keybase.enable = true;

  programs.gpg = {
    enable = true;
    mutableKeys = false;
    mutableTrust = false;
    publicKeys = [
      {
        source = builtins.fetchurl {
          url = "https://keybase.io/livtown/pgp_keys.asc?fingerprint=2c565233f609450e109249c4b7e0db563fd1f754";
          sha256 = "sha256-xsR6Mm5OqVLBOJB89939t7Db2Y/wBzu4Raad6O174QM=";
        };
        trust = "ultimate";
      }
    ];
  };
}
