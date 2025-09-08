{
  pkgs,
  config,
  ...
}:
{
  programs.msmtp = {
    enable = true;
    accounts.default = {
      auth = true;
      tls = true;
      port = 465;
      host = "smtp.migadu.com";
      from = config.liv.variables.senderEmail;
      user = config.liv.variables.senderEmail;
      passwordeval = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.systemMailerPassword.path}";
    };
  };
}
