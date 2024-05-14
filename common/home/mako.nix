{ pie, ... }:

{
  services.mako = {
    enable = true;
    anchor = "bottom-left";
    defaultTimeout = 3000;
    backgroundColor = pie.lib.colors.darkest;
    borderColor = pie.lib.colors.darkest;
  };
}
