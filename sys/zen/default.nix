{ ... }:

{
  imports = [
    ./boot.nix
    ./ccache.nix
    ./fs.nix
    ./hardware-configuration.nix
    ./postgres.nix
    ./print.nix
  ];
}
