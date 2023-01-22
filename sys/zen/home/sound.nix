# Declaratively set the default node in WirePlumber.

{ pkgs, ... }:

{
  # EW?
  # I couldn't get the Lua scripting to work lol
  home.file.".local/state/wireplumber/default-nodes".source =
    let
      toINI = config: (pkgs.formats.ini { }).generate "nodes.ini" config;
      sink = "alsa_output.pci-0000_05_00.1.HiFi__hw_Generic_3__sink";
    in
    toINI {
      default-nodes."default.configured.audio.sink" = sink;
    };
}
