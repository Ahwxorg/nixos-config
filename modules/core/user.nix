{
  pkgs,
  inputs,
  username,
  host,
  lib,
  system,
  ...
}:
{
  imports =
    [ inputs.home-manager.nixosModules.home-manager ]
    ++ [ ./../../roles/default.nix ]
    ++ [ ./user-linux.nix ]
    ++ [ ./sops.nix ]
    ++ [ ./../../variables.nix ];

  home-manager = {
    backupFileExtension = "bak";
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports =
        if (host == "violet") then
          [ ./../home/default.server.nix ]
        else if (host == "dandelion") then
          [ ./../home/default.server.nix ]
        else if (host == "lily") then
          [ ./../home/default.server.nix ]
        else if (host == "posy") then
          [ ./../home/default.server.nix ]
        else if (host == "hazel") then
          [ ./../home/default.server.nix ]
        else if (host == "daisy") then
          [ ./../home/default.server.nix ]
        else if (host == "flora") then
          [ ./../home/default.server.nix ]
        else if (system == "aarch64-darwin") then
          [ ./../home/default.azalea.nix ]
        else
          [ ./../home ];
      home = {
        username = "${username}";
        stateVersion = "22.11";
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          PAGER = "less";
        };
      };
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    home =
      if (system == "x64_64-linux") then
        "/home/${username}"
      else if (system == "aarch64-darwin") then
        "/Users/${username}"
      else
        "/home/${username}";
    shell = pkgs.zsh;
    description = "ahwx";
  };
  nix.settings.allowed-users = [ "${username}" ];
}
