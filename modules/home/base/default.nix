{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.base;
in
{
  imports = [
    ./fish
    ./nnn.nix
  ];

  options.pie.home.base = {
    enable = lib.mkEnableOption "Whether to enable base home manager configuration.";
    apps = lib.mkOption {
      description = "Whether to enable various useful apps.";
      type = lib.types.listOf (lib.types.package);
      default = with pkgs; [ sops sshfs vifm wireguard-tools ];
      example = [ pkgs.python3 ];
    };
  };

  config = lib.mkIf cfg.enable
    (lib.mkMerge [
      {
        pie.home.base = {
          fish.enable = true;
          nnn.enable = true;
        };
        # Same as the Nix version, I've heard I shouldn't touch this.
        home.stateVersion = "22.11";
        programs.home-manager.enable = true;

        # Move bash's history file so it's cleaner.
        home.sessionVariables.HISTFILE = "${config.xdg.stateHome}/bash_history";

        # Enable manuals.
        programs.man = {
          enable = true;
          generateCaches = true;
        };
        home.packages = cfg.apps;
      }
      (import ./ssh.nix { inherit config; })
    ]);
}
