{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    home = "/spinners/applications/nextcloud/";
    package = pkgs.nextcloud32;
    hostName = "cloud.liv.town";
    # appstoreEnable = true;
    https = true;
    maxUploadSize = "10G";
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news
        contacts
        calendar
        groupfolders
        notify_push
        ;
    };
    config = {
      adminuser = "root";
      adminpassFile = config.sops.secrets.nextcloudPassword.path;
      dbtype = "sqlite";
    };
    configureRedis = true;
    settings = {
      mail_smtpmode = "smtp";
      mail_sendmailmode = "smtp";
      mail_from_address = "noreply";
      mail_domain = "liv.town";
      mail_smtptimeout = 30;
      mail_smtphost = "smtp.migadu.com";
      mail_smtpport = 465;
      mail_smtpname = "notifications@liv.town";
      # mail_smtppassword = config.sops.secrets.systemMailerPassword.path;
      mail_smtpauth = true;
      mail_smtpsecure = "ssl";
      trusted_domains = [ "cloud.liv.town" ];
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
  };
  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    sslCertificate = "/var/lib/acme/liv.town/cert.pem";
    sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
  };
  systemd.services.nextcloud-custom-config = {
    path = [
      config.services.nextcloud.occ
    ];
    script = ''
      nextcloud-occ theming:config name "livnet"
      # nextcloud-occ theming:config description "liv to your fullest"
      nextcloud-occ theming:config url "https://cloud.liv.town";
      # nextcloud-occ theming:config privacyUrl "https://liv.town/privacy";
      nextcloud-occ theming:config color "#3253a5";
    '';
    # nextcloud-occ theming:config logo ${./logo.png}
    after = [ "nextcloud-setup.service" ];
    wantedBy = [ "multi-user.target" ];
  };

}
