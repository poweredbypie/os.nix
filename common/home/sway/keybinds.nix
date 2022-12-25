# Preferred keybinds.

{ lib, ... }:

let
  term = "alacritty";
  web = "firefox";
  progs = "bemenu-run -b | xargs swaymsg exec --";

  meta = "Mod4+";
  ctrl = "Ctrl+";
  shift = "Shift+";
  alt = "Alt+";

  # Helper stuff
  inherit (builtins) foldl' map;
  # Folds a list of sets into a single set.
  # Not sure if this is the best way of doing it...
  concat = (left: right: left // right);
  foldList = list: func:
    foldl' concat {} (map (i: func i) list);

  # Workspace stuff
  spaces = let
    nums = map (i: toString i) (lib.lists.range 0 9);
    fold = func: foldList nums func;
  in
    # Change to workspace i.
    fold (i: {
      "${meta + i}" = "workspace ${i}";
    }) //
    # Move focused window to workspace i.
    fold (i: {
      "${meta + shift + i}" = "move container to workspace ${i}";
    });

  # Movement stuff
  move = let
    inherit (lib.strings) toLower;
    keys = ["Left" "Right" "Up" "Down"];
    fold = func: foldList keys func;
  in
    # Change focus
    fold (key: {
      "${meta + key}" = "focus ${toLower key}";
    }) //
    # Move focused window
    fold (key: {
      "${meta + alt + key}" = "move ${toLower key}";
    });
in {
  wayland.windowManager.sway.config = {
    # Disable resize mode
    modes = {};
    keybindings = {
      # Programs
      "${meta}t" = "exec ${term}";
      "${meta}f" = "exec ${web}";
      "${meta}p" = "exec ${progs}";

      # Screenshot utils
      "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
      "Shift+Print" = "exec grim -g \"$(slurp -o)\" - | wl-copy";

      # Change layout
      "${meta}w" = "layout tabbed";
      "${meta}e" = "layout toggle split";

      # Close stuff
      "${meta}x" = "kill";
      "${ctrl + alt}Delete" = "exec swaymsg exit";
    } // move // spaces;
  };
}
