{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.dev-tools.kak.lsp;
in
{
  options.pie.home.dev-tools.kak.lsp = {
    enable = lib.mkEnableOption "Whether to enable a language server for Kakoune.";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (import ./hooks.nix { inherit pkgs; })
    (import ./langs.nix { inherit pkgs lib; })
  ]);
}
