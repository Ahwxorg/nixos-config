{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  services.keybase.enable = true;

  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    publicKeys = [
      {
        # own key
        source = builtins.fetchurl {
          url = "https://keybase.io/livtown/pgp_keys.asc?fingerprint=904af20ad2fd157cea8f76276d3c3d797793190c";
          sha256 = "sha256-6cJmBMe2yCRip+Id4lCaep/0H8IUfKKzmYx6ExMEeUI=";
        };
        trust = 5;
      }
      {
        # natalie
        source = builtins.fetchurl {
          url = "https://git.gay/0x6e6174/natalieee.net/raw/branch/main/website/site-data/pubkey.asc";
          sha256 = "sha256-THQRICPANA4iv4k9bKdjAc3GMbaN6FPjwxptgGMRxbc=";
        };
        trust = 4;
      }
    ];
  };
}
