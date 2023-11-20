{ ... }:

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
}
