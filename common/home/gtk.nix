# GTK theming
{ ... }:

{
  gtk = {
    enable = true;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
