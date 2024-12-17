{ pkgs, ... }:
let
  masterIP = "192.168.155.1";
  masterHost = "beep.kube";
  apiPort = 6443;
in
{
  environment.systemPackages = [ pkgs.kubectl ];

  networking.extraHosts = "${masterIP} ${masterHost}";
  services.kubernetes = {
    roles = [ "master" "node" ];
    masterAddress = masterHost;
    easyCerts = true;
    apiserver = {
      securePort = apiPort;
      advertiseAddress = masterIP;
    };
    kubelet.extraOpts = "--fail-swap-on=false";
    pki.cfsslAPIExtraSANs = [ "localhost" "192.168.155.1" ];
  };
}
