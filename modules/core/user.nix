{
  pkgs,
  inputs,
  config,
  username,
  host,
  ...
}:
{
  imports =
    [ inputs.home-manager.nixosModules.home-manager ]
    ++ [ ./../../roles/default.nix ]
    ++ [ ./sops.nix ]
    ++ [ ./../../variables.nix ];
  home-manager = {
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
        # else if (host == "yoshino") then
        # [ ./../home/default.nix ]
        else
          [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "22.11";
      };
      programs.home-manager.enable = true;
    };
  };

  fonts.fontconfig.antialias = false;

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "dialout"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
