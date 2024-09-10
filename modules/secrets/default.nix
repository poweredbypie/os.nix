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
          # gear's public SSH keys
          "ssh/gear/pie" = {
            inherit sopsFile;
            mode = "0444";
          };
          "ssh/gear/irl" = {
            inherit sopsFile;
            mode = "0444";
          };
          # zen's public SSH keys
          "ssh/zen/pie" = {
            inherit sopsFile;
            mode = "0444";
          };
          "ssh/zen/irl" = {
            inherit sopsFile;
            mode = "0444";
          };
          # xi's public SSH key
          "ssh/xi/pie" = {
            inherit sopsFile;
            mode = "0444";
          };
          # beep's public SSH key
          "ssh/beep/pie" = {
            inherit sopsFile;
            mode = "0444";
          };
          "ssh/beep/irl" = {
            inherit sopsFile;
            mode = "0444";
          };
          # verthe's public SSH key
          "ssh/verthe/pie" = {
            inherit sopsFile;
            mode = "0444";
          };

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
