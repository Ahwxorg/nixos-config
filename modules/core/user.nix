{ pkgs, inputs, config, username, host, ...}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = 
        if (host == "desktop") then 
          [ ./../home/default.desktop.nix ] 
        else if (host == "violet") then
          [ ./../home/default.violet.nix ]
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
    # extraGroups = if (config.virtualisation.docker.enable == true) then
      # [ "networkmanager" "wheel" "docker" ]
    # else
      # [ "networkmanager" "wheel" ];
    # if (config.virtualisation.docker.enable = true) then
      # extraGroups = [ "docker" ];
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
