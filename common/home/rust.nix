{ pkgs, ... }:

{
  home.packages = [
    # Hello verbosity
    (pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      # rust-analyzer needs this
      extensions = [ "rust-src" ];
    }))
  ];
}
