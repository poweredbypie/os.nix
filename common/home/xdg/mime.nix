{ ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          inherit (builtins) map listToAttrs;
          kak = "kak.desktop";

          text = [
            "plain"
            "x-csrc"
            "x-chdr"
            "x-c++src"
            "x-c++hdr"
            "markdown"
            "vnd.trolltech.linguist"
            "css"
            "html"
          ];
          list = listToAttrs (map (i: { name = "text/${i}"; value = kak; }) text);
        in
        {
          "x-scheme-handler/file" = "nnn.desktop";
          "application/json" = kak;
        } // list;
    };
  };
}
