{ pkgs, ... }:

{
  home.packages = [ pkgs.zathura ];

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}
