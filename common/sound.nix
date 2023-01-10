{ ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    audio.enable = true;
    wireplumber.enable = true;
  };
}
