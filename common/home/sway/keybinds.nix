# Preferred keybinds.

{ lib, ... }:

let
  snap = args: "exec grim -g \"$(slurp ${args})\" - | wl-copy";
  sound = cmd: val: "exec wpctl set-${cmd} @DEFAULT_SINK@ ${val}";

  meta = "Mod4+";
  ctrl = "Ctrl+";
  shift = "Shift+";
  alt = "Alt+";

  # Folds a list of sets into a single set.
  # Not sure if this is the best way of doing it...
  concat = (left: right: left // right);
  fold = list: func:
    builtins.foldl' concat { } (map (i: func i) list);
  # Converts an attribute set to a list of attribute sets,
  # with the key and value specified by the caller.
  attrsToKVs = key: val: attrs:
    map
      (attr: {
        "${key}" = attr;
        "${val}" = (builtins.getAttr attr attrs);
      })
      (builtins.attrNames attrs);

  # Launch apps
  launch =
    let
      apps = rec {
        # "Terminal"
        t = "alacritty";
        # "Browser"
        b = "firefox";
        # "Run"
        r = "bemenu-run -b | xargs swaymsg exec --";
        # TODO: Annoyingly, I have Alacritty launch the shell,
        # and have the shell launch nnn. Otherwise nnn can't open
        # kakoune to edit text files. I wonder why...
        # "Filesystem"
        f = "${t} -e fish -c nnn";
      };
    in
    fold (attrsToKVs "app" "cmd" apps)
      ({ app, cmd }: {
        # Launch the app
        "${meta + app}" = "exec ${cmd}";
      });

  # Movement stuff
  move =
    let
      keys = {
        h = "left";
        j = "down";
        k = "up";
        l = "right";
      };
    in
    fold (attrsToKVs "key" "action" keys)
      ({ key, action }: {
        # Change focus
        "${meta + key}" = "focus ${action}";
        # Move focused window
        "${meta + alt + key}" = "move ${action}";
      });

  # Workspace stuff
  spaces =
    let
      nums = builtins.genList (i: toString i) 10;
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
in
{
  wayland.windowManager.sway.config = {
    # Disable resize mode
    modes = { };
    keybindings = {
      # Programs

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
    } // launch // move // spaces;
  };
}
