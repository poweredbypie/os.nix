# Preferred keybinds.

{ lib, ... }:

let
  term = "alacritty";
  browse = "firefox";
  run = "bemenu-run -b | xargs swaymsg exec --";
  # TODO: Annoyingly, I have Alacritty launch the shell,
  # and have the shell launch nnn. Otherwise nnn can't open
  # kakoune to edit text files. I wonder why...
  fs = "${term} -e fish -c nnn";
  snap = args: "exec grim -g \"$(slurp ${args})\" - | wl-copy";
  sound = cmd: val: "exec wpctl set-${cmd} @DEFAULT_SINK@ ${val}";

  meta = "Mod4+";
  ctrl = "Ctrl+";
  shift = "Shift+";
  alt = "Alt+";

  # Helper stuff
  inherit (builtins) foldl' map;
  # Folds a list of sets into a single set.
  # Not sure if this is the best way of doing it...
  concat = (left: right: left // right);
  fold = list: func:
    foldl' concat { } (map (i: func i) list);

  # Workspace stuff
  spaces =
    let
      nums = map (i: toString i) (lib.lists.range 0 9);
    in
    fold nums
      (i: {
        # Change to workspace i.
        "${meta + i}" = "workspace ${i}";
        # Move focused window to workspace i.
        "${meta + shift + i}" = "move container to workspace ${i}";
      }) //
    {
      "${meta}Tab" = "workspace back_and_forth";
    };

  # Movement stuff
  move =
    let
      keys = [
        { key = "h"; action = "left"; }
        { key = "j"; action = "down"; }
        { key = "k"; action = "up"; }
        { key = "l"; action = "right"; }
      ];
    in
    fold keys
      ({ key, action }: {
        # Change focus
        "${meta + key}" = "focus ${action}";
        # Move focused window
        "${meta + alt + key}" = "move ${action}";
      });
in
{
  wayland.windowManager.sway.config = {
    # Disable resize mode
    modes = { };
    keybindings = {
      # Programs
      "${meta}t" = "exec ${term}";
      "${meta}b" = "exec ${browse}";
      "${meta}r" = "exec ${run}";
      "${meta}f" = "exec ${fs}";

      # Screenshot utils
      "Print" = snap "";
      "Shift+Print" = snap "-o";

      # Volume
      "XF86AudioLowerVolume" = sound "volume" "0.1-";
      "XF86AudioRaiseVolume" = sound "volume" "0.1+";
      "XF86AudioMute" = sound "mute" "toggle";

      # Change layout
      "${meta}Return" = "layout toggle split tabbed";
      "${meta}Space" = "fullscreen";

      # Close stuff
      "${meta}x" = "kill";
      "${ctrl + alt}Delete" = "exec swaymsg exit";
    } // move // spaces;
  };
}
