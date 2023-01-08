{
  description = "pie's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # TODO: Add a `format` output
  outputs = { self, nixpkgs, nur, home-manager }: {
    nixosConfigurations =
      let
        mkSystem = hostName: system:
          let
            args = {
              misc = ./misc;
              inherit hostName;
            };
          in nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./common
              ./sys/${hostName}
              home-manager.nixosModules.home-manager {
                home-manager = {
                  useGlobalPkgs = true;
                  users.pie = import ./common/home;
                  extraSpecialArgs = args;
                };
                # Add NUR for Firefox plugins
                nixpkgs.overlays = [nur.overlay];
              }
            ];
            specialArgs = args;
          };
      in {
        # Desktop
        verthe = mkSystem "verthe" "x86-64-linux";
        # Laptop
        zen = mkSystem "zen" "x86-64-linux";
      };
  };
}
