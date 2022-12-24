# Local environment config!

{ pkgs, config, ... }:

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
    rebuild = "doas nixos-rebuild switch --flake ${config.home.homeDirectory}/src/os.nix";
  };
}
