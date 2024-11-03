{ ... }:

{
  imports = [
    ./android.nix
    ./boot.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./net.nix
    ./power.nix
    ./steam.nix
    ./tablet.nix
  ];

  pie = {
    base.enable = true;
    desktop.enable = true;
    secrets = {
      enable = true;
      hasWireguard = true;
    };
  };

  # iPhone
  services.usbmuxd.enable = true;
  services.fwupd.enable = true;
  # For serial connections
  users.users.pie.extraGroups = [ "dialout" ];
}
