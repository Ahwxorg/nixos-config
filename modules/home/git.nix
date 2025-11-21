{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Ahwx";
      user.email = "ahwx@ahwx.org";
      init.defaultBranch = "master";
      credential.helper = "store";
      alias.stat = "status";
      alias.lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit";
    };
  };

  home.packages = [
    pkgs.gh
    pkgs.git-lfs
  ];
}
