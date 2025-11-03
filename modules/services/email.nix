{
  pkgs,
  config,
  username,
  ...
}:
{
  environment.systemPackages = [ pkgs.mailutils ];
  programs.msmtp = {
    enable = true;
    defaults = {
      auth = "on";
      tls = "on";
      logfile = "/var/log/msmtpd.log";
    };

    accounts.${username} = {
      tls_starttls = "off";
      port = 465;
      host = "smtp.migadu.com";
      from = config.liv.variables.senderEmail;
      user = config.liv.variables.senderEmail;
      passwordeval = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.systemMailerPassword.path}";
    };
  };
}
