{ config, lib, pkgs, ... }:

let
  cfg = config.pie.home.dev-tools;
in
{
  imports = [
    ./git.nix
    ./kak
  ];

  options.pie.home.dev-tools = {
    enable = lib.mkEnableOption "Whether to enable various development tools.";
  };

  config =
    let
      npm = "npm";
      npmrc = "${npm}/${npm}rc";

      inherit (lib.generators) toKeyValue;
      inherit (config) xdg;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        # Go
        go

        # Haskell
        ghc
        # This needs to be on path otherwise the wrapper can't find the other binary
        haskell-language-server

        # Javascript
        deno
        nodejs_22

        # LaTeX
        tectonic

        # Typst
        typst

        # C/C++
        clang_15
        clang-tools_15
        lldb_15
        gnumake

        # C#
        dotnet-sdk

        # Rust
        # Hello verbosity
        (pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
          # rust-analyzer needs this
          extensions = [ "rust-src" ];
          targets = [ "x86_64-unknown-linux-musl" ];
        }))

        # TLA+
        tlaplus

        # Zig
        zig
      ];

      # XDG desktop spec corrections for various devtools
      home.sessionVariables = {
        # Go
        GOPATH = "${xdg.dataHome}/go";
        # Rust
        CARGO_HOME = "${xdg.dataHome}/cargo";
        # NodeJS
        NODE_REPL_HISTORY = "${xdg.stateHome}/node_repl_history";
        NPM_CONFIG_USERCONFIG = "${xdg.configHome}/${npmrc}";
      };

      # More fixes for NodeJS
      xdg = {
        enable = lib.mkDefault true;
        configFile."${npmrc}".text = toKeyValue { } {
          prefix = "${xdg.dataHome}/${npm}";
          cache = "${xdg.cacheHome}/${npm}";
        };
      };

      pie.home.dev-tools = {
        git.enable = lib.mkDefault true;
        kak.enable = lib.mkDefault true;
      };
    };
}
