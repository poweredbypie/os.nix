{ config, lib, ... }:

let
  cfg = config.pie.secrets;
  sopsFile = ./secrets.yaml;
in
{
  options.pie.secrets = {
    enable = lib.mkEnableOption "Whether to enable secret management.";
    hasWireguard = lib.mkEnableOption "Whether the host has a WireGuard key.";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.keyFile = "/home/pie/.config/sops/age/keys.txt";
      defaultSopsFormat = "yaml";

      secrets = lib.mkMerge [
        # System-specific secrets
        (lib.mkIf cfg.hasWireguard {
          "wireguard/key" = { };
        })
        # Shared secrets
        {
          # beep's Wireguard endpoint
          "wireguard/ips/beep" = { inherit sopsFile; };
          # gear's publish SSH keys
          "ssh/gear/pie" = { inherit sopsFile; };
          "ssh/gear/irl" = { inherit sopsFile; };
          # zen's publish SSH keys
          "ssh/zen/pie" = { inherit sopsFile; };
          "ssh/zen/irl" = { inherit sopsFile; };

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
