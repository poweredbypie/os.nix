{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    handlr
    # TODO: This is really hacky. I don't know if I should fix it though.
    # Override xdg-open with handlr
    (lib.hiPrio (writeShellScriptBin "xdg-open" "exec handlr open \"$@\""))
  ];

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          text = "kak.desktop";
          browse = "firefox.desktop";
        in
        {
          "x-scheme-handler/file" = "nnn.desktop";
          "x-scheme-handler/terminal" = "Alacritty.desktop";
          "x-scheme-handler/http" = browse;
          "x-scheme-handler/https" = browse;
          "text/*" = text;
          "application/json" = text;
        };
    };
  };
}
