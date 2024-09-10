# Home manager-related config

{ lib, ... }:

{
  imports = [
    ./base
    ./desktop
    ./dev-tools
    ./games.nix
    ./secrets
    ../theme.nix
  ];

  # TODO: This is sort of a hack to get the hostname but not really, so it might be fine? Just a little dumb to keep this here imo
  options.pie.host = lib.mkOption {
    description = "The name of the host computer.";
    type = lib.types.str;
    # I want this to error if not set because it's kind of critical
    default = null;
    example = "box";
  };
}
