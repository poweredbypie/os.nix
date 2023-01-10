{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      # Use systemd boot
      systemd-boot.enable = true;
      # I don't actually know what this does in detail but I'm assuming it's fine
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    bluetooth.enable = true;
  };
}
