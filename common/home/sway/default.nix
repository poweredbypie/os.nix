{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Screenshot util
    grim
    slurp
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
