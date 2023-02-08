# "Web apps" that just launch Firefox.

{ pkgs, ... }:

{
  home.packages = let
    inherit (pkgs) writeShellScriptBin;
    mkApp = name: url: (writeShellScriptBin name "firefox --kiosk --new-window ${url}");
  in
  [
    (mkApp "discord" "https://discord.com/app")
    (mkApp "spotify" "https://open.spotify.com")
  ];
}
