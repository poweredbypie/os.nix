{ lib, config, prev, ... }:
let
  beep-wg = "wireguard-wg0-peer-beep";
  beep-start = prev.config.systemd.services."${beep-wg}".serviceConfig.ExecStart;
in
{
  systemd.services."${beep-wg}".serviceConfig.ExecStart = lib.mkForce (
    builtins.replaceStrings [ beep-start ] [ config.scalpel.trafos.beep-wg.destination ] beep-start
  );

  scalpel.trafos.beep-wg = {
    source = beep-start;
    matchers.beep-ip.secret = config.sops.secrets."wireguard/ips/beep".path;
    mode = "0555";
  };
}
