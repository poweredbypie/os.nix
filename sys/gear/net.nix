{ config, pkgs, ... }:

{
  # TODO: Hook up with NetworkManager to let this be toggleable
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "192.168.155.4/24" ];
      privateKeyFile = config.sops.secrets."wireguard/key".path;
      # Setup and tear down DNS config
      postSetup = ''
        ${pkgs.systemd}/bin/resolvectl dns wg0 192.168.155.1
        ${pkgs.systemd}/bin/resolvectl domain wg0 wirenet
      '';
      postShutdown = ''
        ${pkgs.systemd}/bin/resolvectl revert wg0
      '';

      peers = [{
        name = "beep";
        publicKey = "mk2HVSQDKGi6Mj8AaQQ6wgX0Q+DuMQWNYm0vPUdnlUs=";
        allowedIPs = [ "192.168.155.0/24" ];
        endpoint = "!!beep-ip!!";
      }];
    };
  };
  services.openvpn = {
    servers.cyber.config = "config ${config.sops.secrets.cyber-vpn.path}";
  };
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };
  users.users.pie.extraGroups = [ "wireshark" ];
}
