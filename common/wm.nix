# Window manager / desktop environment of choice.

{ pkgs, pie, ... }:

# TODO: Help with rewriting services.xserver.displayManager so that it also works for Wayland
# For now, this is a handrolled, simple graphical session initiator that wraps sway
let
  # Inspired by services.xserver.updateDbusEnvironment and the display manager X11 script:
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/display-managers/default.nix#L253
  runSway = pkgs.writeShellScript "run-sway" ''
    ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
    ${pkgs.systemd}/bin/systemctl --user start sway-session.target
    sway
    ${pkgs.systemd}/bin/systemctl --user stop sway-session.target
  '';

  swayWrap = pkgs.writeShellScriptBin "sway-wrap" ''
    ${pkgs.systemd}/bin/systemd-cat --identifier=sway-wrap ${runSway}
  '';
in
{
  # Annoyingly, since this has some dependency on GL etc,
  # this has to be set here instead of in the home manager config.
  programs.sway.enable = true;
  # I don't use anything that doesn't natively support wayland
  # programs.xwayland.enable = false;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = [ swayWrap ];

  services.greetd = {
    enable = true;
    settings =
      let
        style = pkgs.writeText "greet.css" ''
          window {
            background-image: url("${pie.imgs.yellowstone}");
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

        # TODO: Let the login manager hibernate when idle
        config = pkgs.writeText "greet.sway" ''
          # Fix XDG portal issue
          exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
          exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${style} -c sway-wrap; swaymsg exit"

          bindsym Ctrl+q exec poweroff
          bindsym Ctrl+r exec reboot
        '';
      in
      {
        default_session.command = "sway --config ${config}";
      };
  };

  environment.etc."greetd/environments".text = ''
    sway-wrap
    fish
  '';
}
