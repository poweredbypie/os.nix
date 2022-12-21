# User config (pie)

{ pkgs, ... }:

{
  users.users.pie = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable doas
  };
}
