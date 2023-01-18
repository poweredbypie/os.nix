{ ... }:

{
  xdg.desktopEntries.nnn = {
    name = "nnn";
    comment = "Terminal file manager";
    terminal = true;
    exec = "nnn";
    mimeType = [
      "x-scheme-handler/file"
      "inode/directory"
    ];
  };
}
