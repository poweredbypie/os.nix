{ pkgs, ... }:

{
  # Disable the audio input from the 3.5mm jack (my earpod mic is broken)
  # https://discourse.nixos.org/t/fixing-audio-on-asus-strix-scar-17-g733qs/12687/2
  hardware.firmware = [
    (pkgs.writeTextDir "/lib/firmware/hda-jack-retask.fw" (builtins.readFile ./hda-jack-retask.fw))
  ];
  boot = {
    loader = {
      # Use systemd boot
      systemd-boot.enable = true;
      # I don't actually know what this does in detail but I'm assuming it's fine
      efi.canTouchEfiVariables = true;
    };
    # Patch the firmware to force the audio input as the internal mic
    extraModprobeConfig = ''
      options snd-hda-intel patch=hda-jack-retask.fw dmic_detect=0
    '';
  };
}
