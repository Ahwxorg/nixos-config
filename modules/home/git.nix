{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "Ahwx";
    userEmail = "ahwx@ahwx.org";
    
    extraConfig = { 
      init.defaultBranch = "master";
      credential.helper = "store";
    };
  };

  home.packages = [ pkgs.gh pkgs.git-lfs ];
}
