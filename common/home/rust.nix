{ pkgs, ... }:

{
  home.packages = [
    # Hello verbosity
    (pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
  ];
}
