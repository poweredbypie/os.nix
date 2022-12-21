# User config (pie)

{ pkgs, ... }:

{
  users.users.pie = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable doas
  };

  home.packages = with pkgs; [
    firefox
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
