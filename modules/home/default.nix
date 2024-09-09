# Home manager-related config

{ ... }:

{
  imports = [
    ./base
    ./desktop
    ./dev-tools
    ./games.nix
    ../pie.nix
  ];
}
