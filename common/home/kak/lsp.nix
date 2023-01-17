{ pkgs, ... }:

{
  # TODO: Clean this up and use more Nix-config like setup!
  # If it isn't possible with home-manager, we can make our own overlay.
  programs.kakoune = {
    plugins = with pkgs; [
      # These are enabled elsewhere.
      # deno
      # clang-tools_14
      kak-lsp
      # Currently not super stable; maybe later!
      # nil
      rnix-lsp
      zls
    ];
    config = {
      hooks = [
        # Enables kak-lsp.
        {
          name = "WinSetOption";
         option = "filetype=(typescript|c|cpp|nix|zig)";
          commands = ''
            lsp-enable-window
            # Enables nicer diagnostics
            lsp-inlay-diagnostics-enable buffer
            lsp-inlay-code-lenses-enable buffer
            lsp-inlay-hints-enable buffer

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
    };
    # Load kak-lsp on startup.
    extraConfig = ''
      eval %sh{kak-lsp --kakoune -s $kak_session}
      lsp-auto-hover-enable
    '';
  };

  # TODO: Use the standard library func to configure this in Nix!
  # Big hack!!! I love hackiness
  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
}
