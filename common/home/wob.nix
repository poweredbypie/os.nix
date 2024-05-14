{ ... }:
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
        # TODO: Merge with sway settings
        bar_color = "d19936";
        bar_padding = 3;
      };
    };
  };
}
