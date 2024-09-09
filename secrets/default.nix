{ ... }:
{
  sops = {
    age.keyFile = "/home/pie/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      "wireguard/keys/gear" = { };
      "wireguard/ips/beep" = { };
    };
  };
}
