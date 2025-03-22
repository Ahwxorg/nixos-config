{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (config.liv) variables;
in {
  options.liv.variables.dandelion = {
    thisMachine = mkOption {
      default = "dandelion.srv.${variables.primaryDomain}";
      type = types.str;
      readOnly = true;
      description = "Domain of this specific machine";
    };
  };
}
