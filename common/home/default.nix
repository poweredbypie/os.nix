# Home manager-related config

{ pkgs, ... }:

{
  imports = [
    ./env.nix
    ./sway.nix
  ];
  
  home.packages = with pkgs; [
    firefox
    alacritty
    bemenu
    grim slurp
  ];

  # Same as the Nix version, I've heard I shouldn't touch this.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
