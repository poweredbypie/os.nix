# Preferred keybinds.

let
  term = "alacritty";
  web = "firefox";
  launch = "bemenu-run -b | xargs swaymsg exec --";

  # TODO: Make use of this! It looks nicer
  # meta = keys: "Mod4+${keys}";
  meta = "Mod4";
in {
  # Programs
  "${meta}+t" = "exec ${term}";
  "${meta}+f" = "exec ${web}";
  "${meta}+p" = "exec ${launch}";
  # TODO: Add screenshot utils here

  # Movement
  # Change focus
  # TODO: Make some weird function to simplify this
  "${meta}+Left" = "focus left";
  "${meta}+Down" = "focus down";
  "${meta}+Up" = "focus up";
  "${meta}+Right" = "focus right";
  # Move focused window
  "${meta}+Alt+Left" = "move left";
  "${meta}+Alt+Down" = "move down";
  "${meta}+Alt+Up" = "move up";
  "${meta}+Alt+Right" = "move right";
  # Change layout
  "${meta}+w" = "layout tabbed";
  "${meta}+e" = "layout toggle split";
  # Close stuff
  "${meta}+x" = "kill";
  "Ctrl+Alt+Delete" = "exec swaymsg exit";
}
