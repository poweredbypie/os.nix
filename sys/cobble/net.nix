{ config, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "pie" ];
      PasswordAuthentication = false;
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
        (key "beep")
      ];
  };
  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "192.168.155.6/24" ];
      privateKeyFile = config.sops.secrets."wireguard/key".path;

      peers = [{
        name = "beagle";
        publicKey = "vJ41r2IY7tgtGLz6YaZ5rC2kl8WgRWmJZFvt+Um1xzk=";
        allowedIPs = [ "192.168.155.0/24" ];
        endpoint = "!!beagle-ip!!";
        persistentKeepalive = 20;
      }];
    };
  };
}
