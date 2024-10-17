{
  description = "liv's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    nixvim.url = "github:ahwxorg/nixvim-config";
  
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  
    nix-gaming.url = "github:fufexan/nix-gaming";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  
    hyprland = {
      # type = "git";
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland"; # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
    };
    Hyswipe = {
      url = "github:KZDKM/Hyswipe";
      inputs.hyprland.follows = "hyprland"; # Hyswipe uses latest Hyprland. We declare this to keep them in sync.
    };
  };

  outputs = { nixpkgs, self, catppuccin, ...} @ inputs:
  let
    selfPkgs = import ./pkgs;
    username = "liv";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in
  {
    overlays.default = selfPkgs.overlay;
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/desktop
        )];
        specialArgs = { host="desktop"; inherit self inputs username ; };
      };
      sakura = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/sakura
          #agenix.nixosModules.default # TODO: Should use this for en/decrypting secret values.
        )];
        specialArgs = { host="sakura"; inherit self inputs username ; };
      };
      violet = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/violet
        )];
        specialArgs = { host="violet"; inherit self inputs username; };
      };

      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/vm
        )];
        specialArgs = { host="vm"; inherit self inputs username ; };
      };
      server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/server
        )];
        specialArgs = { host="server"; inherit self inputs username ; };
      };

    };
  };
}
