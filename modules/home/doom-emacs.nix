{
  config,
  pkgs,
  username,
  ...
}:
let
  emacsdir = "/home/${username}/.config/emacs";
  doom-install = pkgs.writeShellApplication {
    name = "doom-install";
    runtimeInputs = [ config.programs.git.package ];
    text = ''
      EMACS=${emacsdir}

      if [ ! -f "$EMACS/bin/doom" ]; then
        git clone https://github.com/hlissner/doom-emacs.git $EMACS
        yes | $EMACS/bin/doom install
        $EMACS/bin/doom sync
      fi
    '';
  };
in
{
  services.emacs = {
    enable = true;
    package = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.treesit-grammars.with-all-grammars
    ]);
  };

  # add doom to path
  home = {
    # sessionVariables = {
    # PATH = [ "$HOME/.config/emacs/bin" ];
    # DOOMDIR = "/home/${username}/flake/modules/home/doom-config/";
    # };

    packages = [
      doom-install
      pkgs.emacs
      pkgs.shellcheck
      pkgs.symbola
      pkgs.nerd-fonts.symbols-only
    ];
  };
}
