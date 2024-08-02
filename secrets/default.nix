{ ... }:
{
  sops = {
    age.keyFile = "/home/pie/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      git-irl = {
        format = "binary";
        sopsFile = ./git-irl;
      };
      gear-wireguard-key = {
        format = "binary";
        sopsFile = ./gear-wireguard-key;
      };
      gear-wireguard-endpoint = {
        format = "binary";
        sopsFile = ./gear-wireguard-endpoint;
        mode = "0550";
      };
    };
  };
}
