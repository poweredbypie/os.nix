{ config, ... }:

{
  xdg.userDirs =
    let
      home = config.home.homeDirectory;
      docs = "${home}/docs";
      media = "${docs}/media";
    in
    {
      enable = true;
      createDirectories = true;
      desktop = docs;
      documents = docs;
      music = media;
      pictures = media;
      videos = media;
      download = "${home}/dl";
      publicShare = null;
      templates = null;
      # For any source code
      extraConfig.XDG_SOURCE_DIR = "${home}/src";
    };
}
