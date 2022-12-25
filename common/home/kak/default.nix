{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    plugins = with pkgs; [
      # Language server
      kak-lsp
      # Editorconfig implementation
      editorconfig-core-c
    ];
    config = {
      colorScheme = "gruvbox-dark";
      hooks = [
        # Sets up editorconfig.
        {
          name = "WinCreate";
          # Captures any real file; excludes things like the *debug* buffer.
          option = "^[^*]+$";
          commands = "editorconfig-load";
        }
        # Enables kak-lsp.
        {
          name = "WinSetOption";
          option = "filetype=(c|cpp)";
          commands = "lsp-enable-window";
        }
      ];
      indentWidth = 4;
      tabStop = 4;
      numberLines.enable = true;
      showWhitespace.enable = true;
      scrollOff.lines = 5;
      ui = {
        # I know, I'm such a disappointment for this
        enableMouse = true;
        setTitle = true;
      };
    };
    extraConfig = ''
      # Load kak-lsp
      eval %sh{kak-lsp --kakoune s $kak_session}
    '';
  };
}
