# TypeScript / JavaScript stuff.

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    deno
    nodejs-19_x
  ];
}
