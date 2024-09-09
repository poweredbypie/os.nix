{ config, lib, ... }:

let
  inherit (config.pie) host;
  home = config.home.homeDirectory;
  mkHostKeys = host: {
    "ssh/${host}/pie" = { };
    "ssh/${host}/pie.pub" = { };
    "ssh/${host}/irl" = { };
    "ssh/${host}/irl.pub" = { };
  };
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
      }
      (mkHostKeys "gear")
      (mkHostKeys "zen")
      {
        "ssh/${host}/pie" = {
          path = "${home}/.ssh/pie";
        };
        "ssh/${host}/irl" = {
          path = "${home}/.ssh/irl";
        };
        # These aren't actually secrets but it's just convenient to use sops to deploy them
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
