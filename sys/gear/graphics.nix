{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.vpl-gpu-rt
    ];
  };
}
