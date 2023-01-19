{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./dirs.nix
    ./less.nix
    ./mime
  ];

  xdg.enable = true;
}
