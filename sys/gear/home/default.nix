{ ... }:

{
  imports = [
    ./bluetooth.nix
    ./ghidra.nix
    ./minecraft.nix
    ./obs.nix
    ./power.nix
    ./remmina.nix
    ./sway.nix
  ];

  pie.home = {
    base.enable = true;
    desktop.enable = true;
    dev-tools.enable = true;
    games.enable = true;
  };

  pie.secrets = {
    enable = true;
    hasIRLKey = true;
  };
}
