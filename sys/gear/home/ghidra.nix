{ pkgs, ... }:

{
  home.packages = [
    # Fix tiling window manager stuff
    (pkgs.writeShellScriptBin "ghidra" ''
      _JAVA_AWT_WM_NONREPARENTING=1 ${pkgs.ghidra}/bin/ghidra
    '')
  ];
}
