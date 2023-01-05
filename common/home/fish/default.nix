# Local environment config!

{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    fish
    # TODO: Move this out? Not sure where else to put it thought
    neofetch
  ];

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
