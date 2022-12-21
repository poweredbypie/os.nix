# Internet, WiFi config

{ pkgs, ... }:

{
  networking.hostName = "v4";
  # Use iwd.
  networking.wireless.iwd = {
    enable = true;
    settings = {
      # Enable integrated DHCP.
      General.EnableNetworkConfiguration = true;
      Network.EnableIPv6 = true;
      Settings.AutoConnect = true;
    };
  };
}
