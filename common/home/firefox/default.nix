{ ... }:

{
  imports = [
    ./apps.nix
    ./extensions.nix
    ./profile.nix
  ];

  programs.firefox.enable = true;
}
