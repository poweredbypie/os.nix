# Nix / NixOS config.

{ config, lib, ... }:

let
  cfg = config.pie.base.nix;
in
{
  options.pie.base.nix = {
    enable = lib.mkEnableOption "Whether to enable extra Nix options";
  };

  config = lib.mkIf cfg.enable {
    system = {
      # I've heard I shouldn't touch this value
      stateVersion = "22.11";
      # Use unstable channel
      autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
    };

    nix = {
      # Enable new CLI interface and flakes
      settings.experimental-features = [ "nix-command" "flakes" ];
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    # Some of my packages have proprietary dependencies
    nixpkgs.config.allowUnfree = true;
  };
}
