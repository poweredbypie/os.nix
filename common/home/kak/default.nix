{ ... }:

{
  programs.kakoune = {
    enable = true;
    config = {
      colorScheme = "gruvbox-dark";
      indentWidth = 4;
      numberLines.enable = true;
      showWhitespace.enable = true;
      ui = {
        # I know, I'm such a disappointment for this
        enableMouse = true;
        setTitle = true;
      };
    };
  };
}
