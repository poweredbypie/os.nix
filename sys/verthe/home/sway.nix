# Monitor positioning for desktop

{ ... }:

{
  wayland.windowManager.sway.config =
    let
      left = "DP-3";
      right = "DP-2";
    in
    {
      output = {
        "*".res = "1920x1080@60Hz";
        "${left}".pos = "0 0";
        "${right}".pos = "1920 0";
      };
      workspaceOutputAssign = [
        {
          output = left;
          workspace = "1";
        }
        {
          output = right;
          workspace = "2";
        }
      ];
    };
}
