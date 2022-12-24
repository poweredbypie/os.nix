# Window manager / desktop environment of choice.

{ ... }:

{
  # Annoyingly, since this has some dependency on GL etc,
  # this has to be set here instead of in the home manager config.
  programs.sway.enable = true;
  # I don't use anything that doesn't natively support wayland
  programs.xwayland.enable = false;
}
