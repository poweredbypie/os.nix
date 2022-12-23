# Font, colors, bar config, etc.

{ ... }:

let
  fonts = {
    names = ["monospace"];
    size = 10.0;
  };
in {
  wayland.windowManager.sway.config = {
    inherit fonts;
    bars = [{
      inherit fonts;
      position = "top";
      statusCommand = "while echo $(date +'%d.%m.%Y %H:%M:%S'); do sleep 1; done";
      command = "swaybar";
      #
    }];
  };
}
