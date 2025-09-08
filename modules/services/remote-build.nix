{
  config,
  pkgs,
  username,
  ...
}:
{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";
    openssh.authorizedKeys.keys = config.users.users.${username}.openssh.authorizedKeys.keys ++ [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINKI2KQn97mykFLIaMUWMftA1txJec9qW56hAMj5/MhE liv@dandelion
"
    ];
  };

  users.groups.remotebuild = { };

  nix = {
    nrBuildUsers = 64;
    settings = {
      trusted-users = [ "remotebuild" ];

      min-free = 10 * 1024 * 1024;
      max-free = 200 * 1024 * 1024;

      max-jobs = "auto";
      cores = 0;
    };
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };

  # add to clients:
  # nix.distributedBuilds = true;
  # nix.settings.builders-use-substitutes = true;
  # nix.buildMachines = [
  #   {
  #     hostName = "violet";
  #     sshUser = "remotebuild";
  #     sshKey = "/home/liv/.ssh/id_ed25519"; # Make sure to give a key that works for this user.
  #     system = pkgs.stdenv.hostPlatform.system;
  #     supportedFeatures = [
  #       "nixos-test"
  #       "big-parallel"
  #       "kvm"
  #     ];
  #   }
  # ];
}
