{ pkgs, lib, ... }:

{
  imports = [
    ./kak.nix
    ./nnn.nix
  ];

  home.packages = with pkgs; [
    handlr
    xdg-utils
    # https://github.com/oxalica/nixos-config/blob/main/home/modules/mime-apps.nix#L16
    # TODO: This is really hacky. I don't know if I should fix it though.
    # Override xdg-open with handlr
    (lib.hiPrio (writeShellScriptBin "xdg-open" "exec handlr open \"$@\""))
    # Stupid hack to get around hardcoded GLib terminal list
    (writeShellScriptBin "xterm" "exec alacritty \"$@\"")
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
          "image/*" = browse;
          "video/*" = browse;
          "text/*" = text;
          "application/json" = text;
          "application/pdf" = "org.pwmt.zathura.desktop";
        };
    };
  };
}
