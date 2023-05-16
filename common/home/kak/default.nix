{ ... }:

{
  imports = [
    ./keybinds.nix
    ./lsp
    ./style.nix
  ];

  programs.kakoune = {
    enable = true;
    extraConfig =
      let
        inherit (builtins) map readFile concatStringsSep;
        files = [ ./buffers.kak ./sv.kak ];
        contents = map (f: readFile f) files;
      in
      concatStringsSep "\n" contents;
  };
}
