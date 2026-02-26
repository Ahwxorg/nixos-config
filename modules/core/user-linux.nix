{ username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "dialout"
      "wheel"
    ];
    initialPassword = "temporary-password";
  };

  home-manager = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  fonts.fontconfig.antialias = false;
}
