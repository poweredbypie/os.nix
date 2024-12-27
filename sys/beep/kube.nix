{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.k3s ];

  services.k3s = {
    enable = true;
    role = "server";
  };
}
