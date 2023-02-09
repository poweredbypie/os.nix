{ ... }:

{
  imports = [
    ./apps.nix
    ./profile.nix
  ];

  programs.firefox.enable = true;
}
