# Font, colors, bar config, etc.

{ pkgs, pie, lib, ... }:

let
  fonts = {
    names = [ "monospace" ];
    size = 10.0;
  };
  text = "#ffffff";
  light = "#d19336";
  middle = "#966924";
  dark = "#353535";
  darkest = "#000000";
in
{
  # TODO: Split this out
  xdg.configFile."wob/wob.ini".text = lib.generators.toINIWithGlobalSection { } {
    globalSection = {
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
  # Cursor (macOS)
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS-Monterey-White";
    # TODO: I don't know why but in GTK apps this is SLIGHTLY smaller than outside. WHY???
    size = 16;
    gtk.enable = true;
  };
  wayland.windowManager.sway.config = {
    # Default environment behavior stuff
    workspaceLayout = "default";
    focus.mouseWarping = "container";

    # Window / bar style and colors
    inherit fonts;

    window.border = 1;

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

    output."*".bg = "${pie}/imgs/yellowstone.jpg fill";
  };
}
