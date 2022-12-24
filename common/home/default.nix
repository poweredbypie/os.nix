# Home manager-related config

{ ... }:

{
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./font.nix
    ./kak
    ./sway
    ./zathura.nix
  ];

  # Same as the Nix version, I've heard I shouldn't touch this.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
