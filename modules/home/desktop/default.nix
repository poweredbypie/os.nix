{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.desktop;
in
{
  imports = [
    ./firefox
    ./sway
  ];

  options.pie.home.desktop = {
    enable = lib.mkEnableOption "Whether to enable desktop customization.";
    apps = lib.mkOption {
      description = "Whether to enable various useful desktop apps.";
      type = lib.types.listOf (lib.types.enum [ "discord" "rnote" "zathura" ]);
      default = [ "discord" "rnote" "zathura" ];
      example = [ "rnote" ];
    };
  };

  config =
    let
      listHas = list: str: lib.lists.any (val: str == val) list;
    in
    lib.mkIf cfg.enable (lib.mkMerge [
      {
        pie.home.desktop.firefox.enable = lib.mkDefault true;
        pie.home.desktop.sway.enable = lib.mkDefault true;

        # Add a status indicator for IWD.
        home.packages = [ pkgs.iwgtk ];

        # Input method status indicator and GUI.
        i18n.inputMethod = {
          enabled = "fcitx5";
          fcitx5.addons = with pkgs; [
            fcitx5-chinese-addons
            # TODO: Same as iwgtk, XDG autostart seems to be a bit inconsistent
            fcitx5-gtk
          ];
        };
      }
      (lib.mkIf (listHas cfg.apps "discord") {
        home.packages = [
          (pkgs.vesktop.override {
            withSystemVencord = false;
          })
        ];
      })
      (lib.mkIf (listHas cfg.apps "rnote") {
        home.packages = [ pkgs.rnote ];
      })
      (lib.mkIf (listHas cfg.apps "zathura") (import ./zathura.nix { inherit pkgs; }))
      (import ./gtk.nix { inherit pkgs config; })
      (import ./launcher.nix { inherit config; })
      (import ./notifier.nix { inherit config; })
      (import ./terminal.nix { inherit pkgs; })
      (import ./wob.nix { inherit config lib; })
      (import ./xdg.nix { inherit config lib pkgs; })
    ]);
}
