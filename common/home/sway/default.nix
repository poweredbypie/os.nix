{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # App launcher
    bemenu
    # Status bar for brightness / volume
    wob
    # Screenshot util
    grim
    slurp
    # Brightness
    brightnessctl
    # Allow access to clipboard from scripts
    wl-clipboard
  ];

  imports = [
    ./input.nix
    ./keybinds.nix
    ./style.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    # Use nixpkgs for the actual sway package.
    package = null;
    xwayland = false;
  };
}
