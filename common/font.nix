{ pkgs, ... }:

{
  # Move this to home manager later on...
  # https://github.com/nix-community/home-manager/pull/1268
  fonts = {
    packages = with pkgs; [
      ibm-plex
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "IBM Plex Mono SmBld" ];
    };
  };
}
