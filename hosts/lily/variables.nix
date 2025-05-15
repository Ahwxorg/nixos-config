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
  options.liv.variables.lily = {
    thisMachine = mkOption {
      default = "lily.srv.${variables.primaryDomain}";
      type = types.str;
      readOnly = true;
      description = "Domain of this specific machine";
    };
  };
}
