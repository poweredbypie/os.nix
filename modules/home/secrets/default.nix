{ config, lib, ... }:

let
  cfg = config.pie.home.secrets;
  home = config.home.homeDirectory;
  host = config.pie.host;
  sopsFile = ./secrets.yaml;
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
          "ssh/pie" = {
            path = "${home}/.ssh/pie";
          };
          "ssh/irl" = {
            path = "${home}/.ssh/irl";
          };
          "ssh/${host}/pie" = {
            path = "${home}/.ssh/pie.pub";
          };
          "ssh/${host}/irl" = {
            path = "${home}/.ssh/irl.pub";
          };
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
          # gear's publish SSH keys
          "ssh/gear/pie" = { inherit sopsFile; };
          "ssh/gear/irl" = { inherit sopsFile; };
          # zen's publish SSH keys
          "ssh/zen/pie" = { inherit sopsFile; };
          "ssh/zen/irl" = { inherit sopsFile; };
        }
      ];
    };
  };
}
