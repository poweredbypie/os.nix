{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.desktop.firefox;
in
{
  options.pie.home.desktop.firefox = {
    enable = lib.mkEnableOption "Whether to enable customization for Firefox.";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.firefox.enable = true;
    }
    (import ./apps.nix { inherit pkgs; })
    (import ./profile.nix { inherit pkgs; })
  ]);
}
