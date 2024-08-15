{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.onevpl-intel-gpu
    ];
  };
}
