{ config, lib, ... }:
let
  cfg = config.pie.home.base.nnn;
in
{
  options.pie.home.base.nnn = {
    enable = lib.mkEnableOption "Whether to enable nnn, a terminal file manager.";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nnn = {
        enable = true;
        bookmarks = {
          o = "~/src/os.nix";
          s = "~/docs/school";
        };
      };
    }
    (lib.mkIf config.pie.home.desktop.enable {
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
    })
  ]);
}
