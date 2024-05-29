{
  description = "pie's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nur, home-manager, rust-overlay, nixos-hardware }:
    let
      args = {
        pie = import ./pie { };
      };

      mkSystem = name: system: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common
            ./sys/${name}
            # Set the hostname in the flake.
            { networking.hostName = name; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                users.pie = {
                  imports = [
                    ./common/home
                    ./sys/${name}/home
                  ];
                };
                extraSpecialArgs = args;
              };
              nixpkgs.overlays = [
                nur.overlay
                rust-overlay.overlays.default
                (import ./pie/pkgs)
              ];
            }
          ] ++ extraModules;
          specialArgs = args;
        };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations =
        {
          # Desktop
          verthe = mkSystem "verthe" "x86-64-linux" [ ];
          # Old laptop
          zen = mkSystem "zen" "x86-64-linux" [ ];
          # Laptop
          gear = mkSystem "gear" "x86-64-linux" [
            nixos-hardware.nixosModules.framework-11th-gen-intel
          ];
        };
    };
}
