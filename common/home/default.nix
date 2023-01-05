# Home manager-related config

{ ... }:

{
  imports = [
    ./alacritty.nix
    ./deno.nix
    ./firefox
    ./fish
    ./font.nix
    ./ghc.nix
    ./gtk.nix
    ./kak
    ./llvm.nix
    ./man.nix
    ./nnn.nix
    ./sway
    ./zathura.nix
  ];

  # Same as the Nix version, I've heard I shouldn't touch this.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
