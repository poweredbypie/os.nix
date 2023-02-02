# Home manager-related config

{ ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox
    ./fish
    ./font.nix
    ./ghc.nix
    ./git.nix
    ./gtk.nix
    ./js.nix
    ./kak
    ./llvm.nix
    ./mako.nix
    ./man.nix
    ./osu.nix
    ./nnn.nix
    ./sway
    ./xdg
    ./zathura.nix
    ./zig.nix
  ];

  # Same as the Nix version, I've heard I shouldn't touch this.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
