{ pkgs, inputs, config, username, host, ...}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ] ++ [ ./../../roles ] ++ [./../../variables.nix];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = 
        if (host == "desktop") then 
          [ ./../home/default.desktop.nix ] 
        else if (host == "violet") then
          [ ./../home/default.server.nix ]
        else if (host == "dandelion") then
          [ ./../home/default.server.nix ]
        # else if (host == "yoshino") then
          # [ ./../home/default.nix ]
        else [ ./../home ];
        home = {
          username = "${username}";
          homeDirectory = "/home/${username}";
          stateVersion = "22.11";
        };
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
