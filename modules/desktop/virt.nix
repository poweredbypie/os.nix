{ config, lib, pkgs, ... }:

let
  cfg = config.pie.desktop.virt;
in
{
  options.pie.desktop.virt = {
    enable = lib.mkEnableOption "Whether to enable virtual machine support with libvirtd.";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    # Needed for virtio support.
    environment.systemPackages = [ pkgs.virtiofsd ];
  };
}
