{ config, pkgs, lib, inputs, ... }:{
  environment.systemPackages = [
    inputs.agenix.packages."${system}".default
  ];
}
