{ inputs, pkgs, ... }:
let
  ai-robots-txt = builtins.readFile inputs.ai-robots-txt;
  blocklist_txt = pkgs.writeText "blocklist.txt" ''
    ${ai-robots-txt}
  '';
in
{
  imports = [ inputs.nixocaine.nixosModules.default ];
  services.iocaine = {
    enable = true;
    config = {
      server.default = {
        bind = "127.0.0.1:42069";
        mode = "http";
        use.handler-from = "default";
      };
      handler.default = {
        config = {
          "ai-robots-txt-path" = blocklist_txt;
        };
      };
    };
  };
}
