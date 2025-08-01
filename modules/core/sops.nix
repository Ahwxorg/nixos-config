{
  pkgs,
  inputs,
  username,
  host,
  config,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/${host}/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    secrets =
      if (host == "violet") then
        {
          "systemMailerPassword" = { };
          "forgejoWorkerSecret" = { };
          "matrixRegistrationSecret" = {
            owner = "matrix-synapse";
          };
        }
      else if (host == "sakura") then
        {
          "systemMailerPassword" = { };
        }
      else if (host == "dandelion") then
        {
          "systemMailerPassword" = { };
        }
      else
        { };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
