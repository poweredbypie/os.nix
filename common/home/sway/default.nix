{ ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    # Use nixpkgs for the actual sway package.
    package = null;
    config = import ./style.nix;
  };
}
