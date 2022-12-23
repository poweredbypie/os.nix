# Font, colors, bar config, etc.

{ ... }:

let
  fonts = {
    names = ["monospace"];
    size = 10.0;
  };
  text = "#ffffff";
  light = "#d19336";
  middle = "#966924";
  dark = "#353535";
  darkest = "#000000";
in {
  wayland.windowManager.sway.config = {
    # Default environment behavior stuff
    workspaceLayout = "tabbed";
    focus.mouseWarping = "container";

    # Window / bar style and colors
    inherit fonts;

    window.border = 0;
    bars = [{
      inherit fonts;

      position = "top";
      statusCommand = "while echo $(date +'%d.%m.%Y %H:%M:%S'); do sleep 1; done";

      colors = {
        statusline = text;
        background = darkest;
        inactiveWorkspace = {
          background = dark;
          border = dark;
          inherit text;
        };
        activeWorkspace = {
          background = darkest;
          border = darkest;
          inherit text;
        };
        focusedWorkspace = {
          background = middle;
          border = middle;
          inherit text;
        };
      };
    }];

    colors = {
      focused = {
        background = light;
        border = light;
        childBorder = light;
        indicator = light;
        inherit text;
      };
      focusedInactive = {
        background = dark;
        border = dark;
        childBorder = dark;
        indicator = dark;
        inherit text;
      };
      unfocused = {
        background = dark;
        border = dark;
        childBorder = dark;
        indicator = dark;
        inherit text;
      };
    };
  };
}
