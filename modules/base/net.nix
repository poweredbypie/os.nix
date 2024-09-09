# Internet, WiFi config

{ config, lib, ... }:

let
  cfg = config.pie.base.net;
in
{
  options.pie.base.net = {
    enable = lib.mkEnableOption "Whether to enable network customization.";

    enableWifi = lib.mkOption {
      description = "Enable wireless configuration with IWD";
      type = lib.types.bool;
      default = true;
      example = false;
    };

    useFastDNS = lib.mkOption {
      description = "Use Cloudflare and Google's DNS servers by default";
      type = lib.types.bool;
      default = true;
      example = false;
    };
  };

  config = lib.mkIf cfg.enable
    (lib.mkMerge [
      (lib.mkIf cfg.enableWifi {
        networking = {
          # Use iwd.
          wireless.iwd = {
            enable = true;
            settings = {
              # Enable integrated DHCP.
              General.EnableNetworkConfiguration = true;
              Network = {
                EnableIPv6 = true;
                NameResolvingService = "systemd";
              };
              Settings.AutoConnect = true;
            };
          };
          # Use IWD's integrated service instead.
          dhcpcd.enable = false;
        };
      })
      (lib.mkIf cfg.useFastDNS {
        services.resolved = {
          enable = true;
          fallbackDns = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
          extraConfig = "DNS=1.1.1.1 8.8.8.8 8.8.4.4";
        };
      })
    ]);
}
