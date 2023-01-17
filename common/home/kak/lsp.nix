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

  # Big hack!!! I love hackiness
  xdg.configFile =
    let
      lsp = "kak-lsp";
      toTOML = config: (pkgs.formats.toml { }).generate "${lsp}.toml" config;
    in
    {
      "${lsp}/${lsp}.toml".source = toTOML {
        snippet_support = true;
        verbosity = 2;
        # exit session if no requests were received during given period in seconds
        server.timeout = 1800;

        language = {
          c_cpp = {
            filetypes = [ "c" "cpp" ];
            roots = [ "compile_commands.json" ".clangd" ".git" ".hg" ];
            command = "clangd";
          };
          nix = {
            filetypes = [ "nix" ];
            roots = [ "flake.nix" "shell.nix" ".git" ".hg" ];
            command = "rnix-lsp";
          };
          typescript = {
            filetypes = [ "typescript" ];
            roots = [ "package.json" "tsconfig.json" ".git" ".hg" ];
            command = "deno";
            args = [ "lsp" ];

            settings.deno = {
              enable = true;
              lint = true;
            };
          };
          zig = {
            filetypes = [ "zig" ];
            roots = [ "build.zig" ];
            command = "zls";
          };
        };

        # This is from the stock kak-lsp.toml.
        # I'm just not gonna touch it.
        semantic_tokens.faces = [
          { face = "documentation"; token = "comment"; modifiers = [ "documentation" ]; }
          { face = "comment"; token = "comment"; }
          { face = "function"; token = "function"; }
          { face = "keyword"; token = "keyword"; }
          { face = "module"; token = "namespace"; }
          { face = "operator"; token = "operator"; }
          { face = "string"; token = "string"; }
          { face = "type"; token = "type"; }
          { face = "default+d"; token = "variable"; modifiers = [ "readonly" ]; }
          { face = "default+d"; token = "variable"; modifiers = [ "constant" ]; }
          { face = "variable"; token = "variable"; }
        ];
      };
    };
}
