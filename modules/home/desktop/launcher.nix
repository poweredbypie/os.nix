{ config, ... }:
{
  programs.bemenu = {
    enable = true;
    settings =
      let
        inherit (config.pie.colors) text light middle darkest;
      in
      {
        prompt = "launch app";
        list = "20 down";
        scrollbar = "always";
        center = true;
        width-factor = 0.5;
        ignorecase = true;

        # "Title" back/foreground (bemenu-run thing)
        tb = light;
        tf = text;
        # Cursor foreground (the block cursor)
        cf = text;
        # Highlighted selection foreground
        hf = light;
        # List normal / alternating background (don't need alternation)
        nb = darkest;
        ab = darkest;
        # List normal / alternating foreground (don't need alternation)
        nf = text;
        af = text;
        # Scrollbar foreground
        scf = middle;
      };
  };
}
