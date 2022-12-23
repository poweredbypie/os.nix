# Preferred keybinds.

{ lib, ... }:

let
  term = "alacritty";
  web = "firefox";
  progs = "bemenu-run -b | xargs swaymsg exec --";

  # TODO: Make use of this! It looks nicer
  # meta = keys: "Mod4+${keys}";
  meta = "Mod4+";
  ctrl = "Ctrl+";
  shift = "Shift+";
  alt = "Alt+";

  # Helper stuff
  inherit (builtins) foldl' map;
  concat = (left: right: left // right);
  fold = list: func: foldl' concat {} (map (i: func i) list);

  # Workspace stuff (with loops)
  spaces = let
    nums = map (i: toString i) (lib.lists.range 0 9);
  in {
    # Change to workspace i.
    change = fold nums (i: {
      "${meta + i}" = "workspace number ${i}";
    });
    # Move focused window to workspace i.
    move = fold nums (i: {
      "${meta + shift + i}" = "move container to workspace number ${i}";
    });
  };

  # Movement stuff (also with loops)
  move = let
    inherit (lib.strings) toLower;
    keys = ["Left" "Right" "Up" "Down"];
  in {
    # Change focus
    change = fold keys (key: {
      "${meta + key}" = "focus ${toLower key}";
    });
    # Move focused window
    move = fold keys (key: {
      "${meta + alt + key}" = "move ${toLower key}";
    });
  };
in {
  wayland.windowManager.sway.config.keybindings = {
  # Programs
  "${meta}t" = "exec ${term}";
  "${meta}f" = "exec ${web}";
  "${meta}p" = "exec ${progs}";
  # TODO: Add screenshot utils here

  # Change layout
  "${meta}w" = "layout tabbed";
  "${meta}e" = "layout toggle split";
  # Close stuff
  "${meta}x" = "kill";
  "${ctrl + alt}Delete" = "exec swaymsg exit";
  } // move.change // move.move // spaces.change // spaces.move;
}
