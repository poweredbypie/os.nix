# Font, colors, bar config, etc.

{ pkgs, config, ... }:

let
  fonts = {
    names = [ "monospace" ];
    size = 10.0;
  };
  inherit (config.pie.colors) text light middle dark darkest;
  cursorTheme = "macOS-White";
  # TODO: Make this customizable
  cursorSize = 24;
in
{
  # Cursor (macOS)
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = cursorTheme;
    size = cursorSize;
    gtk.enable = true;
  };

  wayland.windowManager.sway.config = {
    seat."*".xcursor_theme = "${cursorTheme} ${builtins.toString cursorSize}";
    # Default environment behavior stuff
    workspaceLayout = "default";
    focus.mouseWarping = "container";

    # Window / bar style and colors
    inherit fonts;

    # Let firefox PiP show on top of other windows
    window = {
      border = 1;
      commands = [{
        criteria = {
          app_id = "firefox";
          title = "Picture-in-Picture";
        };
        command = "floating enable";
      }];
    };

    gaps.inner = 5;

    bars = [{
      inherit fonts;

      position = "top";
      statusCommand = "while true; do ${pkgs.statxt}/bin/statxt; sleep 1; done";

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

    output."*".bg = "${config.pie.background} fill";
  };
}
