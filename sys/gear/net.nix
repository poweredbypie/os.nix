{ config, pkgs, ... }:

{
  # TODO: Hook up with NetworkManager to let this be toggleable
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "192.168.155.4/24" ];
      privateKeyFile = config.sops.secrets."wireguard/key".path;
      # Setup DNS config
      postSetup = ''
        ${pkgs.systemd}/bin/resolvectl dns wg0 192.168.155.1
        ${pkgs.systemd}/bin/resolvectl domain wg0 wirenet
      '';
      # Teardown not required - wg0 interface gets destroyed beforehand

      peers = [{
        name = "beagle";
        publicKey = "d9Il+LRJDQfrId2kMtmOZT56xq8L4f8Gy/rB6puQygI=";
        allowedIPs = [ "192.168.155.0/24" ];
        endpoint = "!!beagle-ip!!";
      }];
    };
  };
  services.openvpn = {
    servers.cyber.config = "config ${config.sops.secrets.cyber-vpn.path}";
    servers.htb.config = "config ${config.sops.secrets.htb-vpn.path}";
  };
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };
  users.users.pie.extraGroups = [ "wireshark" ];
  hardware.bluetooth.enable = true;
}
