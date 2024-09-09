{ config, lib, pkgs, ... }:

let
  cfg = config.pie.base;
in
{
  imports = [
    ./doas.nix
    ./env.nix
    ./net.nix
    ./nix.nix
  ];

  options.pie.base = {
    enable = lib.mkEnableOption "Whether to enable baseline NixOS options.";
  };

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;

    users.users.pie = {
      createHome = true;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };

    time.timeZone = "America/Los_Angeles";
    # i18n.supportedLocales = [ us au ];
    # i18n.defaultLocale = us;
    console.keyMap = "us";


    pie.base = {
      doas.enable = lib.mkDefault true;
      env.enable = lib.mkDefault true;
      net.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
    };
  };
}
