{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (retroarch.override {
      cores = [ libretro.vba-next ];
    })
  ];
}
