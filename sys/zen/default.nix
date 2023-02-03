{ ... }:

{
  imports = [
    ./boot.nix
    ./ccache.nix
    ./docker.nix
    ./drives.nix
    ./hardware-configuration.nix
    ./postgres.nix
    ./power.nix
    ./print.nix
  ];
}
