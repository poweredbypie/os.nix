{ pkgs, ... }:

{
  home.packages = [ pkgs.zathura ];

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      window-title-basename = true;
      window-title-page = true;

      window-title-home-tilde = true;
      statusbar-home-tilde = true;
    };
  };
}
