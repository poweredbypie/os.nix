{ pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./profile.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };
}
