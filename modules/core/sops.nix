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

  users = {
    users = {
      lldap.isNormalUser = true;
    };
  };

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
      else if (host == "flora") then
        {
          "systemMailerPassword" = { };
          "forgejoWorkerSecret" = { };
          "minioRootCredentials" = { };
          "atticdEnvironment" = { };
          "nextcloudPassword" = {
            owner = "nextcloud";
          };
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
          "radicaleSecret" = { };
          "tinyauthEnvironment" = { };
          "lldapUserPass" = {
            owner = "lldap";
          };
          "lldapJwtSecret" = {
            owner = "lldap";
          };
          "lldapPrivateKey" = {
            owner = "lldap";
          };
          "ldapObserver" = {
            owner = "tinyauth";
          };
          "minifluxAdminCredentials" = {
            # owner = "miniflux";
          };
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
