{ pie, ... }:
{
  programs.bemenu = {
    enable = true;
    settings =
      let
        inherit (pie.lib.colors) text light darkest;
      in
      {
        prompt = "launch app";
        bottom = true;
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
      };
  };
}
