# If you're looking for home manager config, that's under `home`.

{ ... }:

{
  users.users.pie = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable doas
  };
}
