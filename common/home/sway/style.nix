# Font, colors, bar config, etc.

let
  fonts = {
    names = ["monospace"];
    size = 10.0;
  };
in {
  # TODO: Fix this to have everything imported at the top level!
  keybindings = import ./keybinds.nix;
  input = import ./input.nix;
  inherit fonts;
  bars = [{
    inherit fonts;
    position = "top";
    statusCommand = "while echo $(date +'%d.%m.%Y %H:%M:%S'); do sleep 1; done";
    command = "swaybar";
    #
  }];
}
