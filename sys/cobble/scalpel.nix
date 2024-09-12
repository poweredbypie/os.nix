{ lib, config, prev, ... }:
let
  beep-wg = "wireguard-wg0-peer-beep";
  beep-start = prev.config.systemd.services."${beep-wg}".serviceConfig.ExecStart;
in
{
  systemd.services."${beep-wg}".serviceConfig.ExecStart = lib.mkForce config.scalpel.trafos.beep-wg.destination;

  scalpel.trafos.beep-wg = {
    source = beep-start;
    matchers.beep-ip.secret = config.sops.secrets."wireguard/ips/beep".path;
    mode = "0555";
  };
}
