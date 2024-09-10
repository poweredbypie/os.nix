{ config, lib, ... }:

let
  cfg = config.pie.home.secrets;
  host = config.pie.host;
in
{
  options.pie.home.secrets = {
    enable = lib.mkEnableOption "Whether to enable secret management.";
    # Most hosts should have SSH keys so this is fine
    hasSSH = lib.mkEnableOption "Whether the host has an SSH key." // { default = true; };
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.keyFile = "/home/pie/.config/sops/age/keys.txt";
      defaultSopsFile = ../../../sys/${host}/home/secrets.yaml;
      defaultSopsFormat = "yaml";

      secrets = lib.mkMerge [
        # System-specific secrets
        (lib.mkIf cfg.hasSSH {
          "ssh/pie" = { };
          "ssh/irl" = { };
        })
        # Shared secrets
        {
          git-irl = {
            format = "binary";
            sopsFile = ./git-irl;
          };
          ssh-irl = {
            format = "binary";
            sopsFile = ./ssh-irl;
          };
        }
      ];
    };
  };
}
