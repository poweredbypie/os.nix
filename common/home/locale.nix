{ pkgs, ... }:

{
  # home.language =
  #   let
  #     suffix = ".UTF-8";
  #     us = "en_US" + suffix;
  #     au = "en_AU" + suffix;
  #   in
  #   {
  #     base = us;
  #     measurement = au;
  #     time = au;
  #   };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      # TODO: Same as iwgtk, XDG autostart seems to be a bit inconsistent
      fcitx5-gtk
    ];
  };
}
