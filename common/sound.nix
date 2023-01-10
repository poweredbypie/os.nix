{ ... }:

{
  # TODO: I have absolutely no idea how to declaratively set
  # a certain sink in Wireplumber to be the default.
  # I know I can do it with `wpctl set-default`, but
  # there has to be a config file where I can set it, right???
  # Either way, it works right now, so I'm just not going to touch it.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
