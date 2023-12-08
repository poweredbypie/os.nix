# Preferred keybinds.

{ lib, ... }:

let
  snap = args: "exec grim -g \"$(slurp ${args})\" - | wl-copy";
  sound = cmd: val: "exec wpctl set-${cmd} @DEFAULT_SINK@ ${val}";
  bright = val: "exec brightnessctl --class=backlight set ${val}";

  meta = "Mod4+";
  ctrl = "Ctrl+";
  shift = "Shift+";
  alt = "Alt+";

  # Import helpers
  mkPair = lib.attrsets.nameValuePair;
  inherit (lib.attrsets) mapAttrs';
  inherit (builtins) genList listToAttrs;

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
      # Run the specified command.
      run = (app: cmd: mkPair (meta + app) "exec ${cmd}");
    in
    mapAttrs' run apps;

  # Movement stuff
  move =
    let
      keys = {
        h = "left";
        j = "down";
        k = "up";
        l = "right";
      };
      # Change focus
      change = (key: action: mkPair (meta + key) "focus ${action}");
      # Move focused window
      move = (key: action: mkPair (meta + alt + key) "move ${action}");
    in
    mapAttrs' change keys // mapAttrs' move keys;

  # Workspace stuff
  spaces =
    let
      nums = genList (i: toString i) 10;
      # Change to workspace i.
      change = (i: mkPair (meta + i) "workspace ${i}");
      # Move focused window to workspace i.
      move = (i: mkPair (meta + shift + i) "move container to workspace ${i}");
    in
    listToAttrs (map change nums ++ map move nums);
in
{
  wayland.windowManager.sway.config = {
    # Disable resize mode
    modes = { };
    keybindings = {
      # Screenshot utils
      "Print" = snap "";
      "Shift+Print" = snap "-o";

      # Volume
      "XF86AudioLowerVolume" = sound "volume" "0.1-";
      "XF86AudioRaiseVolume" = sound "volume" "0.1+";
      "XF86AudioMute" = sound "mute" "toggle";

      # Brightness
      "XF86MonBrightnessUp" = bright "10%+";
      "XF86MonBrightnessDown" = bright "10%-";

      # Change layout
      "${meta}Return" = "layout toggle split tabbed";
      "${meta}Space" = "fullscreen";
      # Move back and forth between workspaces
      "${meta}Tab" = "workspace back_and_forth";
      # Close stuff
      "${meta}x" = "kill";
      "${ctrl + alt}Delete" = "exec swaymsg exit";
    } // launch // move // spaces;
  };
}
