{ pkgs, config, ... }:

{
  home.packages = [ pkgs.xdg-utils ];
  xdg = {
    enable = true;
    userDirs =
      let
        home = config.home.homeDirectory;
        docs = "${home}/docs";
      in
      {
        createDirectories = true;
        desktop = docs;
        documents = docs;
        download = "${home}/misc";
        # TODO: Is this even a good idea???
        extraConfig.XDG_SOURCE_DIR = "${home}/src";
      };
  };
}
