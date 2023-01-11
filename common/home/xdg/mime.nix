{ ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          kak = "kak.desktop";
        in
        {
          "x-scheme-handler/file" = "nnn.desktop";
          "text/plain" = "${kak}";
          "text/x-c" = "${kak}";
          "text/x-c++" = "${kak}";
        };
    };
  };
}
