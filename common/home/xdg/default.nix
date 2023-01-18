{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./dirs.nix
    ./kak.nix
    ./less.nix
    ./mime.nix
    ./nnn.nix
  ];

  xdg.enable = true;
}
