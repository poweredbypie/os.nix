# Preferred keybinds.

{ lib, pkgs, ... }:

let
  # TODO: This should not be like this lol
  # https://github.com/Scrumplex/flake/blob/main/nixosConfigurations/common/desktop/sway.nix#L91
  wobSock = "$XDG_RUNTIME_DIR/wob.sock";

  snap = args: "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp ${args})\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
  # TODO: This is kind of hard to read and a little cursed
  sound = cmd: val:
    let
      bin = "${pkgs.wireplumber}/bin/wpctl";
    in
    "exec ${pkgs.writeShellScript "sound-${cmd}-${val}" ''
      ${bin} set-${cmd} @DEFAULT_SINK@ ${val}
      if $(${bin} get-volume @DEFAULT_SINK@ | grep -q 'MUTED'); then
        echo '0' > ${wobSock}
      else
        ${bin} get-volume @DEFAULT_SINK@ | sed 's/[^0-9]//g' > ${wobSock}
      fi
    ''}";
  bright = val:
    let
      cmd = "${pkgs.brightnessctl}/bin/brightnessctl --class=backlight";
    in
    "exec ${pkgs.writeShellScript "bright-${val}" ''
      ${cmd} set ${val}
      current=$(${cmd} get)
      max=$(${cmd} max)
      echo $((current * 100 / max)) > ${wobSock}
    ''}";

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
        t = "${pkgs.alacritty}/bin/alacritty";
        # "Browser"
        b = "${pkgs.firefox}/bin/firefox";
        # TODO: Stupid hack! sway doesn't inherit BEMENU_OPTS from ../bemenu.nix, so this is my workaround
        # "Run"
        r = "${pkgs.fish}/bin/fish -c ${pkgs.bemenu}/bin/bemenu-run | xargs swaymsg exec --";
        # TODO: Annoyingly, I have Alacritty launch the shell,
        # and have the shell launch nnn. Otherwise nnn can't open
        # kakoune to edit text files. I wonder why...
        # "Filesystem"
        f = "${t} -e ${pkgs.fish}/bin/fish -c nnn";
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
    floating.modifier = "Mod4";
  };
}
