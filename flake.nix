{
  description = "liv's NixOS configuration";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprsunset.url = "github:hyprwm/hyprsunset";
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland"; # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
    };
    Hyswipe = {
      url = "github:KZDKM/Hyswipe";
      inputs.hyprland.follows = "hyprland"; # Hyswipe uses latest Hyprland. We declare this to keep them in sync.
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixvim.url = "github:ahwxorg/nixvim-config";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, catppuccin, agenix, ...} @ inputs:
  let
    overlays = import ./overlays/default.nix;
    username = "liv";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;
  in
  {
    overlays.default = overlays.addition;
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
        modules = [
          (import ./hosts/sakura)
          agenix.nixosModules.default
        ];
        specialArgs = { host="sakura"; inherit self inputs username ; };
      };
      yoshino = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (import ./hosts/yoshino)
          agenix.nixosModules.default
        ];
        specialArgs = { host="yoshino"; inherit self inputs username ; };
      ichiyo = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (import ./hosts/ichiyo)
          agenix.nixosModules.default
        ];
        specialArgs = { host="sakura"; inherit self inputs username ; };
      };
      violet = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (import ./hosts/violet)
          agenix.nixosModules.default
        ];
        specialArgs = { host="violet"; inherit self inputs username; };
      };

      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [(
          import ./hosts/vm
        )];
        specialArgs = { host="vm"; inherit self inputs username ; };
      };
    };
  };
};
}
