{
  description = "FrostPhoenix's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
  
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  
    nix-gaming.url = "github:fufexan/nix-gaming";
  
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, self, agenix, catppuccin, ...} @ inputs:
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
          agenix.nixosModules.default
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
          # agenix.nixosModules.default
        )];
        specialArgs = { host="violet"; inherit self inputs username ; };
      };

      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/vm
          agenix.nixosModules.default
        )];
        specialArgs = { host="vm"; inherit self inputs username ; };
      };
      server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/server
          # agenix.nixosModules.default
        )];
        specialArgs = { host="server"; inherit self inputs username ; };
      };

    };
  };
}
