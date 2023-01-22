{ config, ... }:

let
  home = config.home.homeDirectory;
in {
  # For my external HDD
  xdg.userDirs.extraConfig.XDG_BACKUP_DIR = "${home}/seagate";
}
