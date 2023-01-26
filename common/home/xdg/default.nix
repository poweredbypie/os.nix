{ ... }:

{
  imports = [
    ./bash.nix
    ./dirs.nix
    ./mime
  ];

  xdg.enable = true;
}
