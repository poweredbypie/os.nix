{ ... }:

{
  imports = [
    ./power.nix
    ./sound.nix
    ./sway.nix
    ./vpn.nix
    ./xdg.nix
  ];

  pie.home = {
    base.enable = true;
    desktop.enable = true;
    dev-tools.enable = true;
    games.enable = true;
  };
}
