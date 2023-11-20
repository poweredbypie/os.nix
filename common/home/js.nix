# TypeScript / JavaScript stuff.

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    deno
    nodejs-slim_20
  ];
}
