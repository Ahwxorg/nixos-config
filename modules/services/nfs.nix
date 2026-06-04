{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  services = {
    samba = {
      # syncPasswordsByPam = true;
      # If set, we will still need to set users with:
      # sudo smbpasswd -a yourusername
      package = pkgs.samba;
      # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`. samba4Full gives issue, however)
      # Required for samba to register mDNS records for auto discovery
      # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
      enable = true;
      openFirewall = true;
      settings.global = {
        "security" = "user";
        "invalid users" = [ "root" ];
        "server smb encrypt" = "required";
      };
      shares = {
        main = {
          path = "/spinners/rootvol/nfs";
          writable = "true";
          comment = "Hello world!";
          "guest ok" = "no";
          "read only" = "no";
          browsable = "no";
          "valid users" = "access";
        };
        violet = {
          path = "/spinners/violet";
          writable = "true";
          comment = "Hello world!";
          "guest ok" = "no";
          "read only" = "no";
          browsable = "no";
          "valid users" = "liv";
        };
        ahwx = {
          path = "/spinners/ahwx";
          writable = "true";
          comment = "Hello world!";
          "guest ok" = "no";
          "read only" = "no";
          browsable = "no";
          "valid users" = "liv";
        };
      };
    };
    avahi = {
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
      enable = lib.mkForce true;
      openFirewall = true;
    };
    samba-wsdd = {
      # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = true;
      openFirewall = true;
    };
  };

  users.users = {
    "access" = {
      isNormalUser = true;
      extraGroups = [ "samba" ];
    };
    ${username} = {
      extraGroups = [ "samba" ];
    };
  };
}
