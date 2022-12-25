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
    # TODO:
    # - Split things into multiple files by category
    # - Hook colorscheme to have transparent background
    # - Look into only formatting spaces on save
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
          commands = ''
            lsp-enable-window
            # Enables nicer diagnostics
            lsp-inlay-diagnostics-enable window
            lsp-inlay-code-lenses-enable window
            lsp-inlay-hints-enable window

            # Prefer spaces
            set-option window lsp_insert_spaces true
            # Show info inline with cursor (looks nicer)
            set-option window lsp_hover_anchor true

            # Use semantic highlighting
            # TODO: This should be configured more Nix-like, please fix!
            hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
            hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
            hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
            hook -once -always window WinSetOption filetype=.* %{
              remove-hooks window semantic-tokens
            }
          '';
        }
        # Use tab for autocomplete
        {
          name = "InsertCompletionShow";
          option = ".*";
          commands = ''
            try %{
              # I don't even know what this does lol
              execute-keys -draft 'h<a-K>\h<ret>'
              map window insert <tab> <c-n>
              map window insert <s-tab> <c-p>
              hook -once -always window InsertCompletionHide .* %{
                unmap window insert <tab> <c-n>
                unmap window insert <s-tab> <c-p>
              }
            }
          '';
        }
      ];
      keyMappings = [
        # Indent and dedent with spaces.
        {
          key = "<tab>";
          mode = "insert";
          effect = "<a-;><a-gt>";
        }
        {
          key = "<s-tab>";
          mode = "insert";
          effect = "<a-;><a-lt>";
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
      eval %sh{kak-lsp --kakoune -s $kak_session}
      lsp-auto-hover-enable
    '';
  };
}
