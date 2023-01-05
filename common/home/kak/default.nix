{ ... }:

{
  imports = [
    ./keybinds.nix
    ./lsp.nix
    ./style.nix
  ];

  programs.kakoune.enable = true;
}
