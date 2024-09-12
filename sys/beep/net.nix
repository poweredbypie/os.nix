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
    ];
    firewall.allowedUDPPorts = [
      # Minecraft voice chat UDP port
      24454
      # WireGuard
      51820
    ];
    wireguard = {
      enable = true;
      interfaces = {
        # Architecture:
        # - Free peers (iPhone, laptop)
        # - Local static peers (Windows desktop)
        # This is a "router" for the local static peers, which make up a "site".
        # When this "router" receives packets on the WireGuard subnet it doesn't recognize,
        # it applies NAT to the packet and sends it out to the local static peer (which it knows the IP of, since I have set it here)
        wg0 = {
          ips = [ "192.168.155.1/24" ];
          listenPort = 51820;
          privateKeyFile = config.sops.secrets."wireguard/key".path;

          postSetup = ''
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.155.0/24 -o wg0 -j MASQUERADE
            ${pkgs.procps}/bin/sysctl net.ipv4.ip_forward=1
          '';

          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.155.0/24 -o wg0 -j MASQUERADE
            ${pkgs.procps}/bin/sysctl net.ipv4.ip_forward=0
          '';

          peers = [
            # Desktop
            {
              name = "verthe";
              publicKey = "8VMAmorVZx2mcakVlAcu8+6rdT9w+Krx+zmU/McTLF8=";
              allowedIPs = [ "192.168.155.2/32" ];
              # This is a fixed endpoint.
              endpoint = "192.168.1.156:51820";
            }
            # iPhone
            {
              name = "xi";
              publicKey = "vuLZN4uYP+khgI4QYGaunDJ21A3ix6EM8USzPkEcY2c=";
              allowedIPs = [ "192.168.155.3/32" ];
            }
            # Laptop
            {
              name = "gear";
              publicKey = "SjyDPxHd8/FHl2jIDK1g7vPcOpT3Q+HXL9CaglkUXH8=";
              allowedIPs = [ "192.168.155.4/32" ];
            }
            # pi (Raspberry Pi 2B)
            {
              name = "pi";
              publicKey = "xtc25CJPGU4edeq7Q5Gnac1kX7XZ929eWsseE+5ba2o=";
              allowedIPs = [ "192.168.155.5/32" ];
            }
          ];
        };
      };
    };
  };
  # services.terraria = {
  #   enable = true;
  #   autoCreatedWorldSize = "large";
  # };
}
