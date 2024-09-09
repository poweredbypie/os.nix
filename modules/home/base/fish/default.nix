# Local environment config!

{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.base.fish;
in
{
  options.pie.home.base.fish = {
    enable = lib.mkEnableOption "Whether to enable customization of fish.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # TODO: Move this out? Not sure where else to put it though
      neofetch
    ];

    programs.fish = {
      enable = true;
      functions = with builtins; {
        fish_prompt = readFile ./fish_prompt.fish;
        "cd.store" = readFile ./cd.store.fish;
      };
    };

    # Replace nano with kakoune
    home.sessionVariables = {
      EDITOR = "kak";
    };

    home.shellAliases = {
      pause = "systemctl suspend";
      rebuild = "doas nixos-rebuild switch --flake ${config.home.homeDirectory}/src/os.nix";

      fs = "nnn";

      e = "kak";
      q = "exit";
    };
  };
}
