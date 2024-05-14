# Internet, WiFi config

{ ... }:

{
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
    useNetworkd = true;
  };
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  };
}
