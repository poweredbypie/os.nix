{ config, ... }:

{
  services.mako = {
    enable = true;
    anchor = "bottom-left";
    defaultTimeout = 3000;
    backgroundColor = config.pie.colors.darkest;
    borderColor = config.pie.colors.darkest;
  };
}
