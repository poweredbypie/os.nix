# Home manager-related config

{ ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox
    ./fish
    ./font.nix
    ./git.nix
    ./go.nix
    ./gtk.nix
    ./hs.nix
    ./iwgtk.nix
    ./js.nix
    ./kak
    ./latex.nix
    ./llvm.nix
    ./locale.nix
    ./mako.nix
    ./man.nix
    ./osu.nix
    ./rust.nix
    ./nnn.nix
    ./sway
    ./tla.nix
    ./vifm.nix
    ./xdg
    ./zathura.nix
    ./zig.nix
  ];

  # Same as the Nix version, I've heard I shouldn't touch this.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
