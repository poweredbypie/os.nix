# Global environment config.

{ pkgs, ... }:

{
  environment = {
    # Get rid of Perl (ew)
    defaultPackages = [];
    # Global packages (mostly just handy for root to have)
    systemPackages = with pkgs; [
      kakoune
      usbutils
      # This is required for nixos-rebuild with flakes.
      gitMinimal
    ];
  };
}
