# Haskell.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
    # This needs to be on path otherwise the wrapper can't find the other binary
    haskell-language-server
  ];
}
