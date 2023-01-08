# If you're looking for home manager config, that's under `home`.

{ pkgs, ... }:

{
  users.users.pie = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable doas
    shell = pkgs.fish;
  };
}
