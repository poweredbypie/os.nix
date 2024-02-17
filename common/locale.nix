{ pkgs, ... }:

let
  suffix = ".UTF-8/UTF-8";
  us = "en_US" + suffix;
  au = "en_AU" + suffix;
in
{
  time.timeZone = "America/Los_Angeles";
  i18n.supportedLocales = [ us au ];
  i18n.defaultLocale = us;
  console.keyMap = "us";

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-chinese-addons
        # TODO: Same as iwgtk, XDG autostart seems to be a bit inconsistent
        fcitx5-gtk
      ];
      ignoreUserConfig = true;
      settings = {
        inputMethod = {
          # Thanks https://github.com/leana8959!
          "Groups/0" = {
            Name = "default";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };
          "Groups/0/Items/0" = {
            Name = "pinyin";
            Layout = "";
          };
          GroupOrder = {
            "0" = "default";
          };
        };
        globalOptions = {
          Hotkey.EnumerateWithTriggerKeys = true;
          "Hotkey/TriggerKeys" = {
            "0" = "Control+space";
          };
        };
      };
    };
  };
}
