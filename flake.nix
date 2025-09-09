{
  description = "liv's NixOS configuration";

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprsunset.url = "github:hyprwm/hyprsunset";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixvim.url = "github:ahwxorg/nixvim-config";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko/latest";
    iamb.url = "github:ulyssa/iamb";
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      disko,
      iamb,
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
      nixosConfigurations = {
        sakura = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/sakura)
          ];
          specialArgs = {
            host = "sakura";
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
            inherit self inputs username;
          };
        };
      };
    };
}
