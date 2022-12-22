{ pkgs, ... }:

{
  imports = [
    ./env.nix
    ./i18n.nix
    ./net.nix
    ./user
  ];
}
