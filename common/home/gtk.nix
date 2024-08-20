# GTK theming
{ pkgs, config, ... }:

let
  dark = {
    extraConfig.gtk-application-prefer-dark-theme = true;
  };
in
{
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3 = dark;
    gtk4 = dark;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
