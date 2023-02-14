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
  };

  outputs = { self, nixpkgs, nur, home-manager, rust-overlay }:
    let
      args = {
        misc = ./misc;
      };

      mkSystem = name: system:
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
              ];
            }
          ];
          specialArgs = args;
        };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations =
        {
          # Desktop
          verthe = mkSystem "verthe" "x86-64-linux";
          # Laptop
          zen = mkSystem "zen" "x86-64-linux";
        };
    };
}
