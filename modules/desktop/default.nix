{ config, lib, ... }:

let
  cfg = config.pie.desktop;
in
{
  imports = [
    ./fonts.nix
    ./greeter.nix
    ./locale.nix
    ./sound.nix
    ./virt.nix
  ];

  options.pie.desktop = {
    enable = lib.mkEnableOption "Whether to enable a graphical desktop.";
  };


  config = lib.mkIf cfg.enable {
    pie.desktop = {
      fonts.enable = lib.mkDefault true;
      greeter.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      sound.enable = lib.mkDefault true;
      virt.enable = lib.mkDefault true;
    };
  };
}
