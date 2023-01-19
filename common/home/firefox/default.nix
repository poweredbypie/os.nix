{ ... }:

{
  imports = [
    ./extensions.nix
    ./profile.nix
  ];

  programs.firefox.enable = true;
}
