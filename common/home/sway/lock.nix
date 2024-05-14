{ pkgs, pie, ... }:
{
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${pie.imgs.yellowstone}";
      show-failed-attempts = true;
      show-keyboard-layout = true;
      indicator-idle-visible = true;
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        # Lock session before sleeping
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
    timeouts = [
      # 3 minutes - lock
      {
        timeout = 180;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      # 5 minutes - sleep
      {
        timeout = 300;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  wayland.windowManager.sway.config.window.commands = [
    {
      criteria = {
        class = ".*";
      };
      command = "inhibit_idle fullscreen";
    }
    {
      criteria = {
        app_id = ".*";
      };
      command = "inhibit_idle fullscreen";
    }
  ];
}
