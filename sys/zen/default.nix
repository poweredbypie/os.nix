{ ... }:

{
  imports = [
    ./android.nix
    ./boot.nix
    ./bluetooth.nix
    ./ccache.nix
    ./drives.nix
    ./hardware-configuration.nix
    ./power.nix
    ./print.nix
    ./tablet.nix
  ];

  pie = {
    base.enable = true;
    desktop.enable = true;
  };
}
