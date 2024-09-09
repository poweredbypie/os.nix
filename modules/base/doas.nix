# Replace sudo with doas (FreeBSD moment)

{ config, lib, ... }:

let
  cfg = config.pie.base.doas;
in
{
  options.pie.base.doas = {
    enable = lib.mkEnableOption "Whether to replace sudo with doas.";
  };

  config = lib.mkIf cfg.enable {
    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [{
          groups = [ "wheel" ];
          # This is just convenient to have.
          persist = true;
        }];
      };
    };
  };
}
