{ config, lib, ... }:

let
  inherit (config.pie) host;
  home = config.home.homeDirectory;
in
{
  sops = {
    age.keyFile = "/home/pie/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = lib.mkMerge [
      {
        git-irl = {
          format = "binary";
          sopsFile = ./git-irl;
        };
        ssh-irl = {
          format = "binary";
          sopsFile = ./ssh-irl;
        };
        "ssh/gear/pie" = { };
        "ssh/gear/pie.pub" = { };
        "ssh/gear/irl" = { };
        "ssh/gear/irl.pub" = { };
      }
      {
        "ssh/${host}/pie" = {
          path = "${home}/.ssh/pie";
        };
        "ssh/${host}/irl" = {
          path = "${home}/.ssh/irl";
        };
        "ssh/${host}/pie.pub" = {
          path = "${home}/.ssh/pie.pub";
          mode = "0444";
        };
        "ssh/${host}/irl.pub" = {
          path = "${home}/.ssh/irl.pub";
          mode = "0444";
        };
      }
    ];
  };
}
