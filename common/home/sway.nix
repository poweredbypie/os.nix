{ nixpkgs, ... }:

let
  mod = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    # Use nixpkgs for the actual sway package.
    package = null;
    config = {
      fonts = {
        names = ["monospace"];
        size = 10.0;
      };
      keybindings = {
        # Programs
        "${mod}+t" = "exec alacritty";
        "${mod}+f" = "exec firefox";
        "${mod}+p" = "exec bemenu-run -b | xargs swaymsg exec --";

        # Movement, etc
        # Change focus
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        # Move focused window
        "${mod}+Alt+Left" = "focus left";
        "${mod}+Alt+Down" = "focus down";
        "${mod}+Alt+Up" = "focus up";
        "${mod}+Alt+Right" = "focus right";
        # Close stuff
        "${mod}+x" = "kill";
        "Ctrl+Alt+Delete" = "exec swaymsg exit";
      };
      bars = [{
        position = "top";
        statusCommand = "while echo $(date +'%d.%m.%Y %H:%M:%S'); do sleep 1; done";
        command = "swaybar";
        #
      }];
    };
  };
}
