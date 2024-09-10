# Home manager-related config

{ lib, ... }:

{
  imports = [
    ./base
    ./desktop
    ./dev-tools
    ./games.nix
    ./secrets.nix
    ../theme.nix
  ];

  # TODO: This is sort of a hack to get the hostname
  options.networking.hostName = lib.mkOption {
    description = "The name of the host computer.";
    type = lib.types.str;
    # I want this to error if not set because it's kind of critical
    default = null;
    example = "box";
  };
}
