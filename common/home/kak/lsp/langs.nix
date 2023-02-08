# LSP servers and LSP client setup.

{ pkgs, ... }:

{
  # TODO: This is so silly hacky please make an overlay to make this better lol
  xdg.configFile =
    let
      lsp = "kak-lsp";
      toTOML = config: (pkgs.formats.toml { }).generate "${lsp}.toml" config;
      lsps = {
        cxx = "${pkgs.clang-tools_14}/bin/clangd";
        tex = "${pkgs.texlab}/bin/texlab";
        nix = "${pkgs.rnix-lsp}/bin/rnix-lsp";
        ts = "${pkgs.nodePackages_latest.typescript-language-server}/bin/typescript-language-server";
        html = "${pkgs.nodePackages_latest.vscode-html-languageserver-bin}/bin/html-languageserver";
        css = "${pkgs.nodePackages_latest.vscode-css-languageserver-bin}/bin/css-languageserver";
        json = "${pkgs.nodePackages_latest.vscode-json-languageserver-bin}/bin/json-languageserver";
        zig = "${pkgs.zls}/bin/zls";
      };
    in
    {
      "${lsp}/${lsp}.toml".source = toTOML {
        snippet_support = true;
        verbosity = 2;
        # From stock: "exit session if no requests were received during given period in seconds"
        server.timeout = 1800;

        language = {
          c_cpp = {
            filetypes = [ "c" "cpp" ];
            roots = [ "compile_commands.json" ".clangd" ".git" ".hg" ];
            command = lsps.cxx;
          };
          css = {
            filetypes = [ "css" ];
            roots = [ "package.json" ];
            command = lsps.css;
            args = [ "--stdio" ];
          };
          html = {
            filetypes = [ "html" ];
            roots = [ "package.json" ];
            command = lsps.html;
            args = [ "--stdio" ];
          };
          latex = {
            filetypes = [ "latex" ];
            roots = [ ".git" ".hg" ];
            command = lsps.tex;
          };
          nix = {
            filetypes = [ "nix" ];
            roots = [ "flake.nix" "shell.nix" ".git" ".hg" ];
            command = lsps.nix;
          };
          javascript = {
            filetypes = [ "javascript" ];
            roots = [ "package.json" ];
            command = lsps.ts;
            args = [ "--stdio" ];
          };
          json = {
            filetypes = [ "json" ];
            roots = [ "package.json" ];
            command = lsps.json;
            args = [ "--stdio" ];
          };
          typescript = {
            filetypes = [ "typescript" ];
            roots = [ "package.json" ];
            command = lsps.ts;
            args = [ "--stdio" ];
          };
          # typescript = {
          #   filetypes = [ "typescript" ];
          #   roots = [ "deno.json" ".git" ".hg" ];
          #   command = "deno";
          #   args = [ "lsp" ];

          #   settings.deno = {
          #     enable = true;
          #     lint = true;
          #   };
          # };
          zig = {
            filetypes = [ "zig" ];
            roots = [ "build.zig" ];
            command = lsps.zig;
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
