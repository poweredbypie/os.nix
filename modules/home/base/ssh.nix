{ config, lib, ... }:

{
  programs.ssh =
    let
      pie = config.sops.secrets."ssh/pie".path;
    in
    {
      enable = true;
      includes = lib.optional config.pie.secrets.hasIRLKey config.sops.secrets.ssh-irl.path;
      matchBlocks = {
        "*" = {
          identityFile = pie;
        };
      };
    };
}
