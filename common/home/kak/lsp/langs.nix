# LSP servers and LSP client setup.

{ pkgs, lib, ... }:

{
  # TODO: This is so silly hacky please make an overlay to make this better lol
  xdg.configFile =
    let
      lsp = "kak-lsp";
      toTOML = config: (pkgs.formats.toml { }).generate "${lsp}.toml" config;
      lsps = rec {
        c_cpp = "${pkgs.clang-tools_15}/bin/clangd";
        css = "${pkgs.nodePackages_latest.vscode-css-languageserver-bin}/bin/css-languageserver";
        go = "${pkgs.gopls}/bin/gopls";
        haskell = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
        html = "${pkgs.nodePackages_latest.vscode-html-languageserver-bin}/bin/html-languageserver";
        javascript = "${pkgs.nodePackages_latest.typescript-language-server}/bin/typescript-language-server";
        json = "${pkgs.nodePackages_latest.vscode-json-languageserver-bin}/bin/json-languageserver";
        nix = "${pkgs.rnix-lsp}/bin/rnix-lsp";
        rust = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        svelte = "${pkgs.nodePackages_latest.svelte-language-server}/bin/svelteserver";
        sv = "${pkgs.verible}/bin/verible-verilog-ls";
        latex = "${pkgs.texlab}/bin/texlab";
        typescript = javascript;
        zig = "${pkgs.zls}/bin/zls";
      };

      mkLangs = langs: lib.attrsets.mapAttrs
        (name: value: {
          # This is basically only here for c_cpp
          filetypes = lib.strings.splitString "_" name;
          command = lsps."${name}";
        } // value)
        langs;
    in
    {
      "${lsp}/${lsp}.toml".source = toTOML {
        snippet_support = true;
        verbosity = 2;
        # From stock: "exit session if no requests were received during given period in seconds"
        server.timeout = 1800;
        language =
          let
            scm = [ ".git" ".hg" ];
            node = {
              roots = [ "package.json" ];
              args = [ "--stdio" ];
            };
          in
          mkLangs
            {
              c_cpp = {
                roots = [ "compile_commands.json" ".clangd" ] ++ scm;
              };
              css = node;
              go = {
                roots = [ "go.mod" ] ++ scm;
              };
              haskell = {
                roots = [ "Setup.hs" "stack.yaml" "*.cabal" ];
                args = [ "--lsp" ];
              };
              html = node;
              latex = {
                roots = scm;
              };
              nix = {
                roots = [ "flake.nix" "shell.nix" ] ++ scm;
              };
              svelte = node;
              javascript = node;
              json = node;
              typescript = node;
              # typescript = {
              #   roots = [ "deno.json" ] ++ scm;
              #   args = [ "lsp" ];
              #   settings.deno = {
              #     enable = true;
              #     line = true;
              #   };
              # };
              rust = {
                roots = [ "Cargo.toml" ];
                settings_section = "rust-analyzer";
                settings.rust-analyzer = {
                  # Apparently broken with kak-lsp
                  hoverActions.enable = false;
                };
              };
              sv = {
                roots = scm;
              };
              zig = {
                roots = [ "build.zig" ];
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
