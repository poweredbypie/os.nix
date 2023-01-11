{ pkgs, ... }:

{
  home.packages = [ pkgs.xdg-utils ];

  imports = [
    ./dirs.nix
    ./kak.nix
    ./mime.nix
    ./nnn.nix
  ];

  xdg.enable = true;
}
