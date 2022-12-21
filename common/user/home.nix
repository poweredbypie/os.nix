# Home manager config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
