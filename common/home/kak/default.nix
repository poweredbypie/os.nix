{ ... }:

{
  imports = [
    ./keybinds.nix
    ./lsp
    ./style.nix
  ];

  programs.kakoune = {
    enable = true;
    extraConfig = builtins.readFile ./buffers.kak;
  };
}
