{ pkgs, ... }:

{
  home.packages = [ pkgs.zathura ];

  programs.zathura = {
    enable = true;
    extraConfig = ''
      # Use the Ctrl+V clipboard or whatever it's called
      set selection-clipboard clipboard
    '';
  };
}
