{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.desktop.sway;
in
{
  options.pie.home.desktop.sway = {
    enable = lib.mkEnableOption "Whether to enable customization for the sway desktop.";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = with pkgs; [
        # Screenshot util
        grim
        slurp
        # Allow access to clipboard from scripts
        wl-clipboard
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
    (import ./input.nix)
    (import ./keybinds.nix { inherit lib pkgs; })
    (import ./lock.nix { inherit pkgs config; })
    (import ./style.nix { inherit pkgs config; })
  ]);
}
