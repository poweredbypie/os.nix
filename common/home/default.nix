# Home manager-related config

{ pkgs, ... }:

{
  imports = [
    ./env.nix
    ./font.nix
    ./sway
  ];

  # Same as the Nix version, I've heard I shouldn't touch this.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
