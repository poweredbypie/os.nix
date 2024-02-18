{ pkgs, ... }:

{
  home.packages = [ pkgs.alacritty ];

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
      keyboard.bindings = [
        # Bind Ctrl+Backspace to Ctrl+W (VSCode habit)
        {
          key = "Back";
          mods = "Control";
          chars = "\\u0017";
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
