{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # App launcher
    bemenu
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
    ./lock.nix
    ./keybinds.nix
    ./style.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    # Use nixpkgs for the actual sway package.
    package = null;
    # xwayland = false;
    systemd = {
      enable = true;
      xdgAutostart = true;
    };
  };
}
