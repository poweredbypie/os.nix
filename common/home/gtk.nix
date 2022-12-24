# GTK theming
{ ... }:

let
  dark = {
    extraConfig.gtk-application-prefer-dark-theme = true;
  };
in {
  gtk = {
    enable = true;
    gtk3 = dark;
    gtk4 = dark;
  };
}
