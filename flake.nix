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
    # TODO: Write some helper to make this system agnostic
    nixosConfigurations.v4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common
        ./sys/v4
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            users.pie = import ./common/home;
          };
          # Add NUR for Firefox stuff
          nixpkgs.overlays = [nur.overlay];
        }
      ];
    };
  };
}
