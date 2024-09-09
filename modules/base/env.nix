# Global environment config.

{ config, lib, pkgs, ... }:

let
  cfg = config.pie.base.env;
in
{
  options.pie.base.env = {
    enable = lib.mkEnableOption "Whether to set handy default environment packages.";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      # Get rid of Perl (ew)
      defaultPackages = [ ];
      # Global packages (mostly just handy for root to have)
      systemPackages = with pkgs; [
        kakoune
        usbutils
        pciutils
        file
        # This is required for nixos-rebuild with flakes.
        gitMinimal
      ];
    };
  };
}
