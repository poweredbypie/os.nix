{ pkgs, ... }:

{
  programs.kakoune = {
    plugins = [pkgs.editorconfig-core-c];
    config = {
      # Editorconfig-related options.
      hooks = [{
        name = "WinCreate";
        # Captures any real file; excludes things like the *debug* buffer.
        option = "^[^*]+$";
        commands = "editorconfig-load";
      }];
      indentWidth = 4;
      tabStop = 4;

      # Highlighters, status, etc.
      numberLines.enable = true;
      showWhitespace.enable = true;
      scrollOff.lines = 5;
      ui = {
        # I know, I'm such a disappointment for this
        enableMouse = true;
        setTitle = true;
      };

      # Theme.
      colorScheme = "gruvbox-dark";
    };
    # Use transparent background with Alacritty
    extraConfig = ''
      face global Default rgb:ebdbb2,default
      face global BufferPadding rgb:504945,default
    '';
  };
}
