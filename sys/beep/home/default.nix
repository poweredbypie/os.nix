{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hddtemp
    minecraft-server-hibernation
    tmux
    wol
  ];

  pie.home = {
    base.enable = true;
    dev-tools.enable = true;
  };

  pie.secrets.enable = true;
}
