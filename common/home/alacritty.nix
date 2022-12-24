{ pkgs, ... }:

{
  home.packages = [pkgs.alacritty];

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        blink_interval = 500;
        blink_timeout = 0;
      };
      shell = {
        # Use fish instead.
        program = "fish";
        args = ["--login"];
      };
      key_bindings = [
        # Bind Ctrl+Backspace to Ctrl+W (VSCode habit)
        {
          key = "Back";
          mods = "Control";
          chars = "\\x17";
        }
        # Bind search to Ctrl+F
        {
          key = "F";
          mods = "Control";
          mode = "~Search";
          action = "SearchForward";
        }
        {
          key = "F";
          mods = "Control|Shift";
          mode = "~Search";
          action = "ReceiveChar";
        }
      ];
    };
  };
}
