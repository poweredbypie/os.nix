{ ... }: {
  wayland.windowManager.sway.config =
    let
      main = "eDP-1";
    in
    {
      output."${main}".scale = "1.3";
    };
}
