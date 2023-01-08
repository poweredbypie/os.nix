# Nix / NixOS config.

{ ... }:

{
  system = {
    # I've heard I shouldn't touch this value
    stateVersion = "22.11";
    # Use unstable channel
    autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Enable new CLI interface and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # TODO: Configure nix store gc stuff
}
