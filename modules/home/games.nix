{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.games;
in
{
  options.pie.home.games = {
    enable = lib.mkEnableOption "Whether to enable various games.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      osu-lazer-bin
      (retroarch.withCores (cores: [ libretro.vba-next ]))
    ];
  };
}
