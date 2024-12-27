{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "pie" ];
    };
    authorizedKeysFiles =
      let
        key = host: config.sops.secrets."ssh/${host}/pie".path;
      in
      [
        (key "gear")
        (key "zen")
        (key "xi")
        (key "verthe")
      ];
  };
  networking = {
    firewall.allowedTCPPorts = [
      # Terraria server
      # 7777
      # Minecraft server
      25565
      # DNS
      53
      # Kubernetes stuff
      6443
      8888
    ];
    firewall.allowedUDPPorts = [
      # Minecraft voice chat UDP port
      24454
      # WireGuard
      51820
      # DNS
      53
    ];
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [ "192.168.155.5/24" ];
          listenPort = 51820;
          privateKeyFile = config.sops.secrets."wireguard/key".path;

          peers = [{
            name = "beagle";
            publicKey = "d9Il+LRJDQfrId2kMtmOZT56xq8L4f8Gy/rB6puQygI=";
            allowedIPs = [ "192.168.155.0/24" "192.168.156.0/24" ];
            endpoint = "192.168.1.157:51820";
          }];
        };
      };
    };
  };
  services.coredns = {
    enable = true;
    config = ''
      . {
        bind wg0
        hosts {
          192.168.155.1 beagle.wirenet
          192.168.155.2 verthe.wirenet
          192.168.155.3 xi.wirenet
          192.168.155.4 gear.wirenet
          192.168.155.5 pi.wirenet
          192.168.155.6 cobble.wirenet
          192.168.155.7 beep.wirenet
        }
      }
    '';
  };
  # services.terraria = {
  #   enable = true;
  #   autoCreatedWorldSize = "large";
  # };
}
