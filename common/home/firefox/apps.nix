# "Web apps" that just launch Firefox.

{ pkgs, ... }:

let
  profile = "apps";
in
{
  # TODO: Hack; If using the same profile, all other windows open in kiosk mode!
  programs.firefox.profiles."${profile}" = {
    id = 1;
  };

  home.packages = let
    inherit (pkgs) writeShellScriptBin;
    mkApp = name: url: (writeShellScriptBin name "firefox -P ${profile} --kiosk --new-window ${url}");
  in
  [
    (mkApp "discord" "https://discord.com/app")
    (mkApp "spotify" "https://open.spotify.com")
  ];
}
