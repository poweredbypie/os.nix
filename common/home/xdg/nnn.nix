{ ... }:

{
  xdg.desktopEntries.nnn = {
    name = "nnn";
    comment = "Terminal file manager";
    exec = "nnn";
    terminal = true;
    mimeType = [
      "x-scheme-handler/file"
      "inode/directory"
    ];
  };
}
