# Window manager / desktop environment of choice.

{ pkgs, misc, ... }:

{
  # Annoyingly, since this has some dependency on GL etc,
  # this has to be set here instead of in the home manager config.
  programs.sway.enable = true;
  # I don't use anything that doesn't natively support wayland
  programs.xwayland.enable = false;

  services.greetd = {
    enable = true;
    settings =
      let
        style = pkgs.writeText "greet.css" ''
          window {
            background-image: url("file://${misc}/yellowstone.jpg");
            background-size: cover;
            background-position: center;

            font-family: monospace;
            color: white;
          }

          button, entry, button:active {
            border: none;
            border-radius: 0px;
            box-shadow: none;
            background: black;
            color: white;
          }

          /* TODO: The dropdown is not styled properly but I can't really tell why */

          button:hover, entry:focus {
            background: #151515;
            border-style: none;
          }

          box#body {
            /* Shamelessly stolen from Alacritty. */
            background-color: rgba(29, 31, 33, 0.9);
            padding: 15px;
          }
        '';

        config = pkgs.writeText "greet.sway" ''
          exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${style} -c sway; swaymsg exit"
          bindsym q "poweroff"
          bindsym r "reboot"
        '';
      in {
        default_session.command = "sway --config ${config}";
      };
  };
}
