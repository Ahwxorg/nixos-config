{
  pkgs,
  lib,
  username,
  ...
}:
{
  security = {
    rtkit.enable = true;
    pam.services.swaylock = { };

    sudo = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          commands = [
            {
              command = "/etc/profiles/per-user/liv/bin/systemctl";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/home/liv/.local/src/framework-system/target/debug/framework_tool";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];

      package = (pkgs.sudo.override { withInsults = true; }).overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            substituteInPlace plugins/sudoers/logging.c \
            --replace "This incident has been reported to the administrator." "o-oops, ${username} is in trouble" \
            --replace "incorrect password attempts" "nuu silly, try again ~ >.< ~" \
            --replace "incorrect password attempt" "nuu silly, try again ~ >.< ~" \
            --replace "authentication failure" "oepsie woepsie alles is stukkie wukkie :3" \
            --replace "a password is required" "no password? 😭\n"
          '';
        configureFlags =
          (builtins.filter (x: !(lib.strings.hasPrefix x "--with-passprompt=")) old.configureFlags)
          ++ [
            "--with-badpass-message=try again silly"
            "--with-passprompt=is password for me? 🥺"
          ];
      });
    };
  };
}
