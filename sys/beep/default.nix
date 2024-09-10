{ ... }:

{
  imports = [
    ./boot.nix
    ./net.nix
    ./swap.nix
    ./hardware-configuration.nix
  ];

  pie = {
    base = {
      enable = true;
      net.enableWifi = false;
    };
    secrets = {
      enable = true;
      hasWireguard = true;
    };
  };
}
