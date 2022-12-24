# Local environment config!

{ pkgs, ... }:

{
  home.packages = [pkgs.fish];

  programs.fish = {
    enable = true;
  };

  # Replace nano with kakoune
  home.sessionVariables = {
    EDITOR = "kak";
  };

  home.shellAliases = {
    pause = "systemctl suspend";
  };
}
