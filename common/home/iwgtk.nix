{ pkgs, ... }:
{
  # For iwd tray icon
  home.packages = [ pkgs.iwgtk ];
}
