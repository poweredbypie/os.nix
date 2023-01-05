# Local environment config!

{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    fish
    # TODO: Move this out? Not sure where else to put it though
    neofetch
  ];

  programs.fish = {
    enable = true;
    functions = {
      fish_prompt = builtins.readFile ./fish_prompt.fish;
    };
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
