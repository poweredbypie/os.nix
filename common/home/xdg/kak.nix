{ ... }:

{
  xdg.desktopEntries.kak = {
    name = "kakoune";
    comment = "A better code editor";
    exec = "kak";
    terminal = true;
    mimeType = [
      "text/plain"
      "text/x-c"
      "text/x-c++"
    ];
  };
}
