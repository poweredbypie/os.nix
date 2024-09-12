{ ... }:

{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./net.nix
  ];

  pie = {
    base = {
      enable = true;
      net.enableWifi = false;
    };
    secrets.enable = true;
  };
}
