{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ibm-plex
  ];
  fonts.fontconfig.enable = true;
}
