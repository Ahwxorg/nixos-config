{
  description = "liv's Nix configuration";

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixvim.url = "github:ahwxorg/nixvim-config";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko/latest";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    oisd.url = "https://big.oisd.nl/domainswild";
    oisd.flake = false;
    nixocaine.url = "https://git.madhouse-project.org/iocaine/nixocaine/archive/stable.tar.gz";
    ai-robots-txt.url = "github:ai-robots-txt/ai.robots.txt";
    ai-robots-txt.flake = false;
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    skhd-zig.url = "github:sebb3/skhd-zig.nix";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      ...
    }@inputs:
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
      darwinConfigurations = {
        "azalea" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            (import ./hosts/azalea)
          ];
          specialArgs = {
            host = "sakura";
            system = "aarch64-darwin";
            inherit self inputs username;
          };
        };
      };
      nixosConfigurations = {
        sakura = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/sakura)
          ];
          specialArgs = {
            host = "sakura";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        yoshino = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/yoshino)
          ];
          specialArgs = {
            host = "yoshino";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        ichiyo = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/ichiyo)
          ];
          specialArgs = {
            host = "ichiyo";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        violet = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/violet)
          ];
          specialArgs = {
            host = "violet";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        dandelion = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/dandelion)
          ];
          specialArgs = {
            host = "dandelion";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        lily = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/lily)
          ];
          specialArgs = {
            host = "lily";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        zinnia = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/zinnia)
          ];
          specialArgs = {
            host = "zinnia";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        posy = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            (import ./hosts/posy)
          ];
          specialArgs = {
            host = "posy";
            system = "aarch64-linux";
            inherit self inputs username;
          };
        };
        hazel = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/hazel)
          ];
          specialArgs = {
            host = "hazel";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        daisy = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/daisy)
          ];
          specialArgs = {
            host = "daisy";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        iris = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/iris)
          ];
          specialArgs = {
            host = "iris";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        sunflower = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/sunflower)
          ];
          specialArgs = {
            host = "sunflower";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        imilia = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/imilia)
          ];
          specialArgs = {
            host = "imilia";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
        april = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/april)
          ];
          specialArgs = {
            host = "april";
            system = "x86_64-linux";
            inherit self inputs username;
          };
        };
      };
    };
}
