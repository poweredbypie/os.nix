# Global environment config.

{ pkgs, ... }:

{
  # Get rid of Perl (ew)
  environment.defaultPackages = [];

  # Global packages (mostly just handy for root to have)
  environment.systemPackages = with pkgs; [
    kakoune
    elvish
    usbutils
    # This is required for nixos-rebuild with flakes.
    gitMinimal
  ];

  # Replace nano with kakoune
  environment.variables.EDITOR = "kak";
}
