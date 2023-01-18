{ ... }:

{
  xdg.desktopEntries.kak = {
    name = "kakoune";
    comment = "A better code editor";
    exec = "alacritty -e kak";
    terminal = true;
    mimeType = [
      "text/plain"
      "text/x-csrc"
      "text/x-chdr"
      "text/x-c++src"
      "text/x-c++hdr"
      "text/markdown"
      # This is TypeScript ???
      "text/vnd.trolltech.linguist"
      "text/css"
      "text/html"
      "application/json"
    ];
  };
}
