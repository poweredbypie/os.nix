{ lib, config, prev, ... }:
let
  beagle-wg = "wireguard-wg0-peer-beagle";
  beagle-start = prev.config.systemd.services."${beagle-wg}".serviceConfig.ExecStart;
in
{
  systemd.services."${beagle-wg}".serviceConfig.ExecStart = lib.mkForce config.scalpel.trafos.beagle-wg.destination;

  scalpel.trafos.beagle-wg = {
    source = beagle-start;
    matchers.beagle-ip.secret = config.sops.secrets."wireguard/ips/beagle".path;
    mode = "0555";
  };
}
