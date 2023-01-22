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
      download = "${home}/tmp";
      publicShare = null;
      templates = null;
      # TODO: Is this even a good idea???
      extraConfig.XDG_SOURCE_DIR = "${home}/src";
    };
}
