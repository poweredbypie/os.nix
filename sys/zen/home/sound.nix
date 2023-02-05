# Declaratively set the default node in WirePlumber.

{ lib, ... }:

with lib.generators; {
  # EW?
  # I couldn't get the Lua scripting to work lol
  home.file.".local/state/wireplumber/default-nodes".text = toINI { } {
    default-nodes."default.configured.audio.sink" = "alsa_output.pci-0000_05_00.1.HiFi__hw_Generic_3__sink";
  };
}
