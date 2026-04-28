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
          "atticdEnvironment" = { };
          "nextcloudPassword" = { };
          "gluetunEnvironment" = { };
          "matrixRegistrationSecret" = {
            owner = "matrix-synapse";
          };
          "matrixWhatsAppBridgeSecret" = {
            owner = "mautrix-signal";
          };
          "matrixSignalBridgeSecret" = {
            owner = "mautrix-whatsapp";
          };
          "smbLoginDetails" = { };
          "syncplay" = { };
          "funkwhaleDjangoSecret" = { };
          "desecToken" = { };
        }
      else if (host == "sakura") then
        {
          "systemMailerPassword" = { };
          "dandelionSyncthingId" = { };
          "sakuraSyncthingId" = { };
          "homeExternalIPv4" = { };
        }
      else if (host == "dandelion") then
        {
          "systemMailerPassword" = { };
          "dandelionSyncthingId" = { };
          "sakuraSyncthingId" = { };
        }
      else if (host == "fragile") then
        {
          "systemMailerPassword" = { };
          "yubikeySecret" = {
            owner = username;
            path = "/home/${username}/.config/Yubico/u2f_keys";
          };
        }
      else
        { };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
