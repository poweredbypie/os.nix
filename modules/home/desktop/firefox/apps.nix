# "Web apps" that just launch Firefox.

{ pkgs, ... }:

let
  profile = "apps";
in
{
  # TODO: Hack; If using the same profile, all other windows open in kiosk mode!
  programs.firefox.profiles."${profile}" = {
    id = 1;
    settings = {
      # Enable DRM for Spotify
      "media.eme.enabled" = true;
      # Disable mic indicator (it's a whole window which is annoying)
      "privacy.webrtc.legacyGlobalIndicator" = false;
      "privacy.webrtc.hideGlobalIndicator" = true;
    };
  };

  home.packages =
    let
      inherit (pkgs) writeShellScriptBin;
      mkApp = name: url: (writeShellScriptBin name "firefox -P ${profile} --kiosk --new-window ${url}");
    in
    [
      # (mkApp "discord" "https://discord.com/app")
      (mkApp "spotify" "https://open.spotify.com")
      (mkApp "netflix" "https://www.netflix.com")
    ];
}
