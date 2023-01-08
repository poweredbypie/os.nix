# Sway overrides for my laptop config.

{ ... }:

{
  wayland.windowManager.sway.config = let
    top = "HDMI-A-1";
    bot = "eDP-1";
  in {
    output = {
      "*".res = "1920x1080@60Hz";
      "${top}".pos = "0 0";
      "${bot}".pos = "0 1080";
    };
    workspaceOutputAssign = [{
      output = "${top}";
      workspace = "0";
    }];
  };
}
