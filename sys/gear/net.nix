{ config, ... }:

{
  # TODO: Hook up with NetworkManager to let this be toggleable
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "192.168.155.4/24" ];
      privateKeyFile = config.sops.secrets."wireguard/keys/gear".path;

      peers = [{
        name = "beep";
        publicKey = "mk2HVSQDKGi6Mj8AaQQ6wgX0Q+DuMQWNYm0vPUdnlUs=";
        allowedIPs = [ "192.168.155.0/24" ];
        endpoint = "!!beep-ip!!";
      }];
    };
  };
}
