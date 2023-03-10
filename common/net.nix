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
        Network.EnableIPv6 = true;
        Settings.AutoConnect = true;
      };
    };
  };
}
