{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      ibm-plex
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["IBM Plex Mono SmBld"];
    };
  }
}
