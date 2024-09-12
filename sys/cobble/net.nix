{ config, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "pie" ];
      PasswordAuthentication = false;
    };
    authorizedKeysFiles =
      let
        key = host: config.sops.secrets."ssh/${host}/pie".path;
      in
      [
        (key "gear")
        (key "zen")
        (key "xi")
        (key "verthe")
        (key "beep")
      ];
  };
}
