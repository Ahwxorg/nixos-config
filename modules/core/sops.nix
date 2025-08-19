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
          "minioRootCredentials" = { };
          "matrixRegistrationSecret" = {
            owner = "matrix-synapse";
          };
          "smbLoginDetails" = { };
        }
      else if (host == "sakura") then
        {
          "systemMailerPassword" = { };
          "dandelionSyncthingId" = { };
          "sakuraSyncthingId" = { };
        }
      else if (host == "dandelion") then
        {
          "systemMailerPassword" = { };
          "dandelionSyncthingId" = { };
          "sakuraSyncthingId" = { };
        }
      else
        { };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
