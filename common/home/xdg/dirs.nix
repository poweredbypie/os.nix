{ config, ... }:

{
  xdg.userDirs =
    let
      home = config.home.homeDirectory;
      docs = "${home}/docs";
    in
    {
      enable = true;
      createDirectories = true;
      desktop = docs;
      documents = docs;
      download = "${home}/misc";
      # TODO: Is this even a good idea???
      extraConfig.XDG_SOURCE_DIR = "${home}/src";
    };
}
