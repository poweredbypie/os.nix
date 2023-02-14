# Fix XDG base directory stuff.
# https://wiki.archlinux.org/title/XDG_Base_Directory

{ ... }:

{
  imports = [
    ./bash.nix
    ./cargo.nix
    ./nodejs.nix
  ];
}
