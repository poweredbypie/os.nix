{ config, lib, ... }:

let
  cfg = config.pie.desktop.locale;
in
{
  options.pie.desktop.locale = {
    enable = lib.mkEnableOption "Whether to enable international input support with fcitx.";
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.settings = {
        inputMethod = {
          # Thanks https://github.com/leana8959!
          "Groups/0" = {
            Name = "default";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
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
