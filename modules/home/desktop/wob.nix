{ config, lib, ... }:
{
  services.wob = {
    enable = true;
    systemd = true;
    settings = {
      "" = {
        border_offset = 0;
        border_size = 0;
        width = 300;
        height = 15;
        anchor = "bottom left";
        margin = 15;
        bar_color = lib.strings.removePrefix "#" config.pie.colors.light;
        bar_padding = 3;
      };
    };
  };
}
