{ config, lib, ... }:

let
  cfg = config.pie.secrets;
  sopsFile = ./secrets.yaml;
  sshPubKey = host: name: {
    "ssh/${host}/${name}" = {
      inherit sopsFile;
      mode = "0444";
    };
  };
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
          # beagle's Wireguard endpoint
          "wireguard/ips/beagle" = { inherit sopsFile; };
          git-irl = {
            format = "binary";
            sopsFile = ./git-irl;
          };
          ssh-irl = {
            format = "binary";
            sopsFile = ./ssh-irl;
          };
        }
        (sshPubKey "gear" "pie")
        (sshPubKey "gear" "irl")
        (sshPubKey "zen" "pie")
        (sshPubKey "zen" "irl")
        (sshPubKey "xi" "pie")
        (sshPubKey "beep" "pie")
        (sshPubKey "verthe" "pie")
        (sshPubKey "cobble" "pie")
        {
          cyber-vpn = {
            format = "binary";
            sopsFile = ./cyber-vpn;
          };
          htb-vpn = {
            format = "binary";
            sopsFile = ./htb-vpn;
          };
        }
      ];
    };
  };
}
