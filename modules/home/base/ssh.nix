{ config, ... }:

let
  inherit (config.pie) host;
in
{
  programs.ssh =
    let
      pie = config.sops.secrets."ssh/${host}/pie".path;
    in
    {
      enable = true;
      includes = [ config.sops.secrets.ssh-irl.path ];
      matchBlocks = {
        beep = {
          hostname = "192.168.155.1";
          identityFile = pie;
        };
        pi = {
          hostname = "192.168.155.5";
          identityFile = pie;
        };
        "github.com" = {
          identityFile = pie;
        };
      };
    };
}
