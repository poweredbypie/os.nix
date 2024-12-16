{ pkgs, ... }:
let
  masterIP = "192.168.111.1";
  masterHost = "localhost";
  apiPort = 6443;
in
{
  environment.systemPackages = [ pkgs.kubectl ];

  networking.extraHosts = "${masterHost} ${masterIP}";
  services.kubernetes = {
    roles = [ "master" "node" ];
    masterAddress = masterHost;
    apiserverAddress = "https://${masterHost}:${toString apiPort}";
    easyCerts = true;
    apiserver = {
      securePort = apiPort;
      advertiseAddress = masterIP;
    };

    kubelet.extraOpts = "--fail-swap-on=false";
  };
}
