{ pkgs, ... }:

{
  imports = [
    ./env.nix
    ./net.nix
    ./user
  ];
}
