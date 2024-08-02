{ pkgs, config, ... }:

{
  # TODO: Hook up with NetworkManager to let this be toggleable
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "192.168.155.4/24" ];
      privateKeyFile = config.sops.secrets.gear-wireguard-key.path;

      peers = [{
        publicKey = "mk2HVSQDKGi6Mj8AaQQ6wgX0Q+DuMQWNYm0vPUdnlUs=";
        allowedIPs = [ "192.168.155.0/24" ];
      }];

      # STUPID HACK to set the endpoint since the wireguard module requires the IP at build time
      postSetup = "${pkgs.bash}/bin/bash ${config.sops.secrets.gear-wireguard-endpoint.path}";
    };
  };
}
