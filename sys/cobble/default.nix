{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./net.nix
  ];

  pie = {
    base = {
      enable = true;
      net.enableWifi = false;
    };
    secrets = {
      enable = true;
      hasWireguard = true;
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  environment.systemPackages = [ pkgs.virtiofsd ];
  users.users.pie.extraGroups = [ "libvirtd" ];
}
