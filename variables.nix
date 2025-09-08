{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption types;
  inherit (config.liv) variables;
in
{
  options.liv.variables = {
    primaryDomain = mkOption {
      default = "liv.town";
      type = types.str;
      readOnly = true;
      description = "My primary domain";
    };

    ntfyURL = mkOption {
      default = "notify.${variables.liv.primaryDomain}";
      type = types.str;
      readOnly = true;
      description = "Notification service";
    };

    email = mkOption {
      default = "liv@liv.town";
      type = types.str;
      readOnly = true;
      description = "My primary email";
    };
    senderEmail = mkOption {
      default = "notifications@liv.town";
      type = types.str;
      readOnly = true;
      description = "Emailaddress used to send mails from the system";
    };
  };
}
