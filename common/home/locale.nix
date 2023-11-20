{ ... }:

{
  home.language =
    let
      suffix = ".UTF-8/UTF-8";
      us = "en_US" + suffix;
      au = "en_AU" + suffix;
    in
    {
      base = us;
      measurement = au;
      time = au;
    };
}
