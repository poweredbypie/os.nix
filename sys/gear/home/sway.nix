{ ... }: {
  wayland.windowManager.sway.config =
    let
      main = "eDP-1";
      top = "DP-6";
    in
    {
      output."${main}" = {
        scale = "1.3";
        pos = "0 1080";
      };
      output."${top}" = {
        res = "1920x1080@240Hz";
        pos = "0 0";
      };
    };
}
