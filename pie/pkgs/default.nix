# Overlay.

self: pkgs: {
  statxt = pkgs.callPackage ./statxt.nix { };
}
