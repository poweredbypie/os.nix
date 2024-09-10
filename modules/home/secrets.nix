{ config, lib, ... }:

let
  cfg = config.pie.secrets;
  home = config.home.homeDirectory;
  host = config.networking.hostName;
in
{
  # Import shared secrets to home
  imports = [
    ../secrets
  ];

  # TODO: I can probably extract out the shared parts of both the OS and home manager modules
  # and pass in the "namespace" I want the module to live under.
  options.pie.secrets = {
    # Most hosts should have SSH keys so this is fine
    hasSSH = lib.mkEnableOption "Whether the host has an SSH key." // { default = true; };
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.keyFile = "/home/pie/.config/sops/age/keys.txt";
      defaultSopsFormat = "yaml";

      secrets = lib.mkMerge [
        # System-specific secrets
        (lib.mkIf cfg.hasSSH {
          "ssh/pie" = {
            path = "${home}/.ssh/pie";
          };
          "ssh/irl" = {
            path = "${home}/.ssh/irl";
          };
          "ssh/${host}/pie" = {
            path = "${home}/.ssh/pie.pub";
          };
          "ssh/${host}/irl" = {
            path = "${home}/.ssh/irl.pub";
          };
        })
      ];
    };
  };
}
