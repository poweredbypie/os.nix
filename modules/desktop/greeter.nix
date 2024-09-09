{ config, lib, pkgs, ... }:

let
  cfg = config.pie.desktop.greeter;
in
{
  options.pie.desktop.greeter = {
    enable = lib.mkEnableOption "Whether to enable a greeter service with greetd.";
    environments = lib.mkOption {
      description = "Environments to launch from greeter.";
      type = lib.types.listOf (lib.types.enum [ "sway-wrap" "bash" "fish" ]);
      default = [ "sway-wrap" "bash" "fish" ];
    };
  };

  config =
    # TODO: Help with rewriting services.xserver.displayManager so that it also works for Wayland
    # For now, this is a handrolled, simple graphical session initiator that wraps sway
    let
      # Inspired by services.xserver.updateDbusEnvironment and the display manager X11 script:
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/display-managers/default.nix#L253
      runSway = pkgs.writeShellScript "run-sway" ''
        ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
        # Sway config already initializes the target, we just need to stop it after sway exits.
        NIXOS_OZONE_WL=1 sway
        ${pkgs.systemd}/bin/systemctl --user stop sway-session.target
      '';

      swayWrap = pkgs.writeShellScriptBin "sway-wrap" ''
        ${pkgs.systemd}/bin/systemd-cat --identifier=sway-wrap ${runSway}
      '';
    in
    lib.mkIf cfg.enable {
      programs.sway.enable = true;
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
            # TODO: For some reason the background image being set here ends up with an infinite recursion and I'm too tired to figure it out
            style = pkgs.writeText "greet.css" ''
              window {
                background-image: url("");
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
              exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${style}; swaymsg exit"
              bindsym Ctrl+q exec poweroff
              bindsym Ctrl+r exec reboot
            '';
          in
          {
            default_session.command = "sway --config ${config}";
          };
      };
      environment.etc."greetd/environments".text = lib.concatStringsSep "\n" cfg.environments;
    };
}
