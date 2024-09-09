{ config, lib, pkgs, ... }:

let
  cfg = config.pie.desktop.fonts;
in
{
  options.pie.desktop.fonts = {
    enable = lib.mkEnableOption "Whether to enable font customization.";
  };

  config = lib.mkIf cfg.enable {
    # Move this to home manager later on...
    # https://github.com/nix-community/home-manager/pull/1268
    fonts = {
      packages = with pkgs; [
        ibm-plex
        lxgw-neoxihei
      ];
      fontconfig = {
        enable = true;
        defaultFonts.monospace = [ "IBM Plex Mono SmBld" ];
        defaultFonts.sansSerif = [
          "DejaVu Sans"
          "LXGW Neo XiHei"
        ];
      };
    };
  };

}
