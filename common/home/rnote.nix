{ pkgs, ... }:

{
  home.packages = [
    # Fix weird crashing with NGL
    # https://github.com/flxzt/rnote/issues/1061
    (pkgs.writeShellScriptBin
      "rnote"
      ''
        GSK_RENDERER=gl ${pkgs.rnote}/bin/rnote
      '')
  ];
}
