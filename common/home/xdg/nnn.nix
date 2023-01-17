{ ... }:

{
  xdg.desktopEntries.nnn = {
    name = "nnn";
    comment = "Terminal file manager";
    # TODO: Kakoune can't be opened in this context.
    # `fish -c nnn` doesn't forward args, so nnn starts in the wrong directory!
    exec = "alacritty -e nnn";
    mimeType = [
      "x-scheme-handler/file"
      "inode/directory"
    ];
  };
}
