{ config, lib, ... }:

let
  cfg = config.pie.desktop.sound;
in
{
  options.pie.desktop.sound = {
    enable = lib.mkEnableOption "Whether to enable sound support with PipeWire.";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
