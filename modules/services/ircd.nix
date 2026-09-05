# https://github.com/ocf/nix/blob/29e462a682431dc0d3c4d069548779f48743e9a3/modules/irc.nix
{
  pkgs,
  lib,
  config,
  ...
}:
let
  motd = "welcome to the danger zone!";
  tcpPort = 6697;
in
{
  security.acme.defaults.reloadServices = [ "ergochat.service" ];

  system.activationScripts."irc-passwd" = ''
    secret=$(cat "${config.sops.secrets.ircPassword.path}")
    configFile=/etc/ergo.yaml
    ${lib.getExe pkgs.gnused} -i "s/@irc-passwd@/$secret/g" "$configFile"
  '';

  services.ergochat = {
    enable = true;
    settings = {
      channels = {
        operator-only-creation = false;
        auto-join = [
          "#dei"
          "#chat"
        ];
      };
      oper-classes = {
        "server-admin" = {
          title = "Server Admin";
          "capabilities" = [
            "kill" # disconnect user sessions
            "ban" # ban IPs, CIDRs, NUH masks, and suspend accounts (UBAN / DLINE / KLINE)
            "nofakelag" # exempted from fakelag restrictions on rate of message sending
            "relaymsg" # use RELAYMSG in any channel (see the `relaymsg` config block)
            "vhosts" # add and remove vhosts from users
            "sajoin" # join arbitrary channels, including private channels
            "samode" # modify arbitrary channel and user modes
            "snomasks" # subscribe to arbitrary server notice masks
            "roleplay" # use the (deprecated) roleplay commands in any channel
            "rehash" # rehash the server, i.e. reload the config at runtime
            "accreg" # modify arbitrary account registrations
            "chanreg" # modify arbitrary channel registrations
            "history" # modify or delete history messages
            "defcon" # use the DEFCON command (restrict server capabilities)
            "massmessage" # message all users on the server
            "metadata" # modify arbitrary metadata on channels and users
          ];
        };
      };
      opers = {
        olivia = {
          class = "server-admin";
          password = "@irc-passwd@";
        };
      };
      network.name = "robotgirl.zip";
      server = {
        ip-cloaking = {
          enabled = true;
        };
        name = "robotgirl.zip";
        motd = pkgs.writeText "ircd.motd" motd;
        sts.enabled = true;
        listeners.":${builtins.toString tcpPort}".tls = {
          cert = "/var/lib/acme/robotgirl.zip/fullchain.pem";
          key = "/var/lib/acme/robotgirl.zip/key.pem";
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ tcpPort ];
  users.users."ergochat" = {
    isNormalUser = true;
    createHome = true;
    group = "acme";
  };
}
