{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.dev-tools.kak;
in
{
  imports = [
    ./lsp
  ];

  options.pie.home.dev-tools.kak = {
    enable = lib.mkEnableOption "Whether to enable Kakoune configuration.";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
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

      pie.home.dev-tools.kak.lsp.enable = lib.mkDefault true;
    }
    (import ./keybinds.nix)
    (import ./style.nix { inherit pkgs; })
    (lib.mkIf config.pie.home.desktop.enable (import ./desktop-entry.nix))
  ]);
}
