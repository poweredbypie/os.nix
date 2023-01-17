# LSP servers and LSP client setup.

{ pkgs, ... }:

{
  programs.kakoune.plugins = with pkgs; [
    # These are enabled elsewhere.
    # deno
    # clang-tools_14
    kak-lsp
    # Currently not super stable; maybe later!
    # nil
    rnix-lsp
    zls
  ];

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
