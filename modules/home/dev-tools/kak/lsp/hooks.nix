# Kakoune and LSP client interaction setup.

{ pkgs, ... }:

{
  programs.kakoune =
  let
    scm = [ ".git" ".hg" ];
    mkLang = { regex, lsp, args, roots }: {
      name = "BufSetOption";
      option = "filetype=${regex}";
      commands = ''
        set-option buffer lsp_servers %{
          ["${lsp}"]
          args = ${builtins.toJSON args}
          root_globs = ${builtins.toJSON roots}
        }
      '';
    };
  in
  {
    config.hooks = [
      # Enables kak-lsp.
      {
        name = "WinSetOption";
        option = "filetype=(javascript|typescript|html|css|json|nix|rust|go|sv|zig|latex|haskell|c|cpp)";
        commands = ''
          lsp-enable-window
          # Enables nicer diagnostics
          # TODO: This doesn't work because kakoune version is too old
          # The newest version was pulled a couple days ago but hasn't been upstreamed to nixos-unstable.
          # lsp-inlay-diagnostics-enable buffer
          lsp-inlay-code-lenses-enable buffer
          lsp-inlay-hints-enable buffer

          set-option window lsp_insert_spaces false
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

          # Format on save
          hook window BufWritePre .* lsp-formatting-sync
        '';
      }
      (mkLang {
        regex = "(?:c|cpp)";
        lsp = "${pkgs.clang-tools_15}/bin/clangd";
        args = [ "--log=error" ];
        roots = [ "compile_commands.json" ".clangd" ] ++ scm;
      })
      (mkLang {
        regex = "go";
        lsp = "${pkgs.gopls}/bin/gopls";
        args = [];
        roots = [ "go.mod" ] ++ scm;
      })
      (mkLang {
        regex = "hs";
        lsp = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
        args = [ "--lsp" ];
        roots = [ "Setup.hs" "stack.yaml" "*.cabal" ];
      })
      (mkLang {
        regex = "tex";
        lsp = "${pkgs.texlab}/bin/texlab";
        args = [];
        roots = scm;
      })
      (mkLang {
        regex = "nix";
        lsp = "${pkgs.nil}/bin/nil";
        args = [];
        roots = [ "flake.nix" "shell.nix" ] ++ scm;
      })
      (mkLang {
        regex = "rust";
        lsp = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        args = [];
        roots = [ "Cargo.toml" ];
      })
      (mkLang {
        regex = "zig";
        lsp = "${pkgs.zls}/bin/zls";
        args = [];
        roots = [ "build.zig" ];
      })
      (mkLang {
        regex = "typ";
        lsp = "${pkgs.tinymist}/bin/tinymist";
        args = [];
        roots = scm;
      })
      (mkLang {
        regex = "cs";
        lsp = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
        args = ["-lsp"];
        roots = scm;
      })
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
    # Load kak-lsp on startup.
    extraConfig = ''
      eval %sh{${pkgs.kakoune-lsp}/bin/kak-lsp --kakoune -s $kak_session}
      lsp-auto-hover-enable
    '';
  };
}
