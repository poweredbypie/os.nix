{ lib, ... }:

{
  # Customization stuff
  options.pie = {
    colors = {
      text = lib.mkOption {
        description = "Text color.";
        type = lib.types.str;
        default = "#ffffff";
      };

      light = lib.mkOption {
        description = "Foreground highlight color.";
        type = lib.types.str;
        default = "#d19336";
      };

      middle = lib.mkOption {
        description = "Foreground color.";
        type = lib.types.str;
        default = "#966924";
      };

      dark = lib.mkOption {
        description = "Background highlight color.";
        type = lib.types.str;
        default = "#353535";
      };

      darkest = lib.mkOption {
        description = "Background color.";
        type = lib.types.str;
        default = "#000000";
      };
    };
    background = lib.mkOption {
      description = "Background image.";
      type = lib.types.path;
      default = ./yellowstone.jpg;
    };
  };
}
